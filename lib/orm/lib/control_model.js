
const URL = require('url');
const Path = require('path');
const Client = require('pg');
const ChildProcess = require('child_process');

const ProxyHandlers = require(Path.join(__dirname, 'proxy_handlers.js'))



const metaKey = '._ormMeta';

class ControlModelBase extends Object {

  constructor(dbURL) {
    super();

    let constr = this.constructor;
    let schema = constr.name.toLowerCase();
    let timeout = 6000;

    Object.defineProperty(this, metaKey, {
      enumerable: false,
      writable: false,
      configurable: false,

      value: {

        cache: {
          values: {},
          schema: constr.getTables(dbURL, schema, timeout),
        },

        configuration: {
          url: dbURL,
          schema: schema,
          timeout: timeout,
        },

      }

    });

    return new Proxy(this, ProxyHandlers);
  }

  get meta() {
    let desc = Object.getOwnPropertyDescriptor(this, metaKey);

    return desc.value;
  }

  save() {
    let constr = this.constructor;
    let dbURL = this.meta.configuration.url;
    let table = this.meta.configuration.schema;
    let timeout = this.meta.configuration.timeout;

    let values = this.toJSON();
    let handle = this.meta.cache.values.handle;

    if (handle) {
      for (let key in values) {
        let val = values[key];

        this.constructor.setValue(dbURL, table, key,  handle, val, timeout)
      }

    } else {
      let handle = this.constructor.createRecord(dbURL, table, values, timeout);

      this.meta.cache.values.handle = handle;
    }

    return handle;
  }

  toString() {
    let json = this.toJSON();

    return JSON.stringify(json);
  }

  toJSON() {
    return this.meta.cache.values;
  }

  static executeQuery(dbURL, query, values, timeout) {
    let workerPath = Path.join(__dirname, 'model', 'worker.js');
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

  //static getValueMeta(dbURL, schema, table, handle, timeout) {
  //  // TODO: Get a single value's meta data.
  //}

  static getValue(dbURL, table, key, handle, timeout) {
    // TODO: Get a single value from our table.
    let crit = [handle];
    let query = 'SELECT ' + key + ' FROM ' + table + ' '
      + 'WHERE ' + table + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0][key];
  }

  static getAllValues(dbURL, table, handle, timeout) {
    // TODO: Get all the values in a table;
    let crit = [handle];
    let query = 'SELECT *  FROM ' + table + ' '
      + 'WHERE ' + table + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static createRecord(dbURL, table, values, timeout) {
    // TODO: Create a new table entry.
    let columns = this.getColumns(dbURL, table, timeout);
    let keys = Object.keys(values);

    let placeholders = [];

    let crit = keys.map((key, idx, ary) => {
      let value = values[key];

      placeholders.push('$' + (idx + 1).toString());

      return value;
    });


    let query = 'INSERT INTO ' + table + '(' + keys.join(', ') + ') '
      + 'VALUES (' + placeholders.join(', ') + ') RETURNING handle;'

    let rows = this.executeQuery(dbURL, query, crit, timeout);
    let handle = rows[0].handle;

    return handle;
  }

  static setValue(dbURL, table, key,  handle, val, timeout) {
    let crit = [handle, val];
    let query = 'UPDATE ' + table + ' SET '
      + key + ' = $2'
      + ' WHERE handle = $1 RETURNING ' + key + ';';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0][key];
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


module.exports = ControlModelBase;
