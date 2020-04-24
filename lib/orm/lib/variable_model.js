
const URL = require('url');
const Path = require('path');
const Client = require('pg');
const ChildProcess = require('child_process');

const ProxyHandlers = require(Path.join(__dirname, 'proxy_handlers.js'))



const metaKey = '._ormMeta';

class VariableModelBase extends Object {

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
    let schema = this.meta.configuration.schema;
    let timeout = this.meta.configuration.timeout;

    let values = this.toJSON();
    let handle = this.meta.cache.values.handle;

    if (handle) {

      for (let table in values) {
        let value = values[table];

        constr.setValue(dbURL, schema, table, handle, value, timeout)
      }

    } else {
      let handle = constr.createRecord(dbURL, schema, values, timeout);

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

  static getValueMeta(dbURL, schema, table, handle, timeout) {
    let mainTable = [schema, 'handle'].join('.');

    let crit = [handle];
    let query = 'SELECT * FROM ' + schema + '.' + table + ' '
      + 'WHERE ' + table + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static getValue(dbURL, schema, table, handle, timeout) {
    let mainTable = [schema, 'handle'].join('.');

    let crit = [handle];
    let query = 'SELECT value FROM ' + schema + '.' + table + ' '
      + 'WHERE ' + table + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0].value;
  }

  static getAllValues(dbURL, schema, handle, timeout) {
    let tables = this.getTables(dbURL, schema, timeout);

    let props = tables.map((table) => {
      return table + '.' + 'value AS ' + table;
    });

    let joins = tables.map((table) => {
      if (table != 'handle') {
        return 'INNER JOIN ' + schema + '.' + table + ' '
          + 'ON ' + table + '.handle = ' + 'handle.value'
      } else {
        return '';
      }

    });

    let crit = [handle];
    let query = 'SELECT ' + props.join(', ') + ' FROM ' + schema + '.handle'
      + ' ' + joins.join(' ') + ' WHERE handle.value = $1 ';
      + 'LIMIT 1;'
    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static createRecord(dbURL, schema, values, timeout) {
    let tables = this.getTables(dbURL, schema, timeout);
    let crit = [];
    let insIdx = 0;

    let query = 'INSERT INTO ' + schema + '.handle DEFAULT VALUES RETURNING value;';
    let rows = this.executeQuery(dbURL, query, [], timeout);

    for (let tablesIdx = 1; tablesIdx < tables.length - 1; tablesIdx++) {
      let table = tables[tablesIdx];
      let value = values[table];

      if (table == 'handle') {
        continue;
      }

      if (value) {
        crit.push(value);

        query = 'INSERT INTO ' + schema + '.' + table + '(value) '
          + 'VALUES ($' + crit.length + '); ';

      } else {
        query = 'INSERT INTO ' + schema + '.' + table + ' DEFAULT VALUES; ';

      }

      this.executeQuery(dbURL, query, crit, timeout);
    }

    let handle = rows[0].value;

    return handle;
  }

  static setValue(dbURL, schema, table, handle, val, timeout) {
    let mainTable = [schema, 'handle'].join('.');
    let keyTable = [schema, table].join('.');

    let crit = [handle, val];
    let query = 'UPDATE ' + schema + '.' + table + ' AS ' + table + ' '
      + 'SET value = $2 '
      +  'WHERE ' + table + '.handle = $1 '
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows;
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

  static getColumns(dbURL, schema, table, timeout) {
    let crit = [schema, table];
    let query = 'SELECT DISTINCT column_name '
      + 'FROM information_schema.columns '
      + 'WHERE table_schema = $1 '
        + 'AND table_name = $2;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    let output = rows.map((obj) => {
      return obj.column_name;
    });

    return output;
  }

  static populateSchemaCache(dbURL, schema, timeout) {
    let cache = {};
    let tables = this.getTables(dbURL, schema, timeout);

    cache.schema = {};

    for (let tablesIdx = 0; tablesIdx < tables.length; tablesIdx++) {
      let table = tables[tablesIdx];

      cache.schema[table] = this.getColumns(dbURL, schema, table, timeout);
    }

    return cache.schema;
  }

}


module.exports = VariableModelBase;
