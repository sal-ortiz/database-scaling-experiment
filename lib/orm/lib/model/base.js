
const Configuration = require('configuration-wrapper');
const Path = require('path');
const ChildProcess = require('child_process');

const ProxyHandlers = require(Path.join(__dirname, 'proxy_handlers.js'))

const PgError = require(Path.join(__dirname, 'error.js'));
const Queries = require(Path.join(__dirname, 'queries.js'));

const workerPath = Path.join(__dirname, 'worker.js');
const cfgPath = Path.join(__dirname, 'cfg');

const Defaults = Configuration.fromFile(Path.join(cfgPath, 'defaults.yml'));


class ModelBase extends Object {

  constructor() {
    super();

    if (!this.constructor.meta.configuration.url) {
      throw new Error('No target server/database set!');
    }

    let url = this.constructor.meta.configuration.url;
    let element = this.constructor.meta.configuration.element;

    Object.defineProperty(this, this.constructor.metaKey, {
      enumerable: false,
      writable: false,
      configurable: false,

      value: {

        cache: {
          values: {},
        },

      }

    });

    return new Proxy(this, ProxyHandlers);
  }

  get meta() {
    let metaKey = this.constructor.metaKey;
    let desc = Object.getOwnPropertyDescriptor(this, metaKey);

    return desc.value;
  }

  toString() {
    let json = this.toJSON();

    return JSON.stringify(json);
  }

  toJSON() {
    return this.meta.cache.values;
  }

  save() {
    let element = this.constructor.meta.configuration.element;

    let values = this.toJSON();
    let handle = this.meta.cache.values.handle;

    if (handle) {

      for (let key in values) {
        let val = values[key];

        if (key != 'handle') {
          this.constructor.setValue(element, key,  handle, val)
        }

      }

    } else {
      let properties = this.constructor.meta.cache.properties;
      let handle = this.constructor.createRecord(element, values);

      this.meta.cache.values.handle = handle;
    }

    return handle;
  }

  static get meta() {
    let metaKey = this.metaKey;
    let meta = this[metaKey];

    if (!meta.configuration.element) {
      meta.configuration.element = this.name.toLowerCase();
    }

    return this[metaKey];
  }

  static get configuration() {
    return this.meta.configuration;
  }

  static set url(val) {
    this.meta.configuration.url = val;
  }

  static executeQuery(url, query, values, timeout) {
    let options = {
      input: JSON.stringify({
        url: url,
        query: query,
        values: values,
      }),

      timeout: timeout,
    }

    let cmd = ['node', workerPath].join(' ');
    let res = ChildProcess.execSync(cmd, options);

    let parsed = JSON.parse(res.toString());

    if (parsed.severity && parsed.severity == 'ERROR') {
      throw new PgError(parsed);
    }

    return parsed;
  }

  static getSchemas() {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [];
    let query = Queries.Base.getSchemas()[0];

    let rows = this.executeQuery(url, query, crit, timeout);
    let systemSchemas = Defaults.system_schemas;

    return rows.filter((row) => {
      return !systemSchemas.includes(row);
    });

  }

  static getTables(schema) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [schema];
    let query = Queries.Base.getTables()[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    let output = rows.map((obj) => {
      return obj.table_name;
    });

    return output;
  }

  static getColumns(table) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [table];
    let query = Queries.Base.getColumns()[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    let output = rows.map((obj) => {
      return obj.column_name;
    });

    return output;
  }

}

Object.defineProperty(ModelBase, 'metaKey', {
  enumerable: false,
  writable: false,
  configurable: false,

  value: Defaults.metaKey,
});

Object.defineProperty(ModelBase, Defaults.metaKey, {
  enumerable: false,
  writable: false,
  configurable: false,

  value: {

    configuration: {
      timeout: Defaults.timeout,
    },
    cache: {
      properties: [],
    },

  },

});


module.exports = ModelBase;
