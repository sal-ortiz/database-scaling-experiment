
const Path = require('path');
const ChildProcess = require('child_process');
const ProxyHandlers = require(Path.join(__dirname, 'proxy_handlers.js'))

const metaKey = '._ormMeta';
const defaultTimeout = 6000;  // milliseconds
const workerPath = Path.join(__dirname, 'worker.js');


class ModelBase extends Object {

  constructor() {
    super();

    if (!this.constructor.meta.configuration.url) {
      throw new Error('No target server/database set!');
    }

    let url = this.constructor.meta.configuration.url;
    let element = this.constructor.meta.configuration.element;
    let timeout = this.constructor.meta.configuration.timeout;

    Object.defineProperty(this, metaKey, {
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
    let constr = this.constructor;
    let dbURL = this.constructor.meta.configuration.url;
    let element = this.constructor.meta.configuration.element;
    let timeout = this.constructor.meta.configuration.timeout;

    let values = this.toJSON();
    let handle = this.meta.cache.values.handle;

    if (handle) {

      for (let key in values) {
        let val = values[key];

        this.constructor.setValue(dbURL, element, key,  handle, val, timeout)
      }

    } else {
      let handle = this.constructor.createRecord(dbURL, element, values, timeout);

      this.meta.cache.values.handle = handle;
    }

    return handle;
  }

  static get configuration() {
    return this.meta.configuration;
  }

  static set url(val) {
    this.meta.configuration.url = val;
  }

  static executeQuery(dbURL, query, values, timeout) {

    let options = {
      input: JSON.stringify({
        url: dbURL,
        query: query,
        values: values,
      }),

      timeout: timeout,
    }

    let cmd = ['node', workerPath].join(' ');
    let res = ChildProcess.execSync(cmd, options);

    return JSON.parse(res.toString());
  }

  static getSchemas(dbURL, timeout) {
    let crit = [];
    let query = 'SELECT DISTINCT schema_name '
      + 'FROM information_schema.schemata;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);
    let systemSchemas = ['information_schema', 'pg_catalog', 'public'];

    return rows.filter((row) => {
      return !systemSchemas.includes(row);
    });

  }

  static getTables(dbURL, schema, timeout) {
    let crit = [schema];
    let query = 'SELECT table_name '
      + 'FROM information_schema.tables '
      + 'WHERE table_schema = $1';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    let output = rows.map((obj) => {
      return obj.table_name;
    });

    return output;
  }

  static getColumns(dbURL, table, timeout) {
    let crit = [table];
    let query = 'SELECT DISTINCT column_name '
      + 'FROM information_schema.columns '
      + 'WHERE table_name = $1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

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

  value: metaKey,
});

Object.defineProperty(ModelBase, metaKey, {
  enumerable: false,
  writable: false,
  configurable: false,

  value: {

    configuration: {
      timeout: defaultTimeout,
    },
    cache: {
      properties: [],
    },

  },

});


module.exports = ModelBase;
