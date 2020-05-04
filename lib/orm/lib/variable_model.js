
const URL = require('url');
const Path = require('path');

const libPath = Path.join(__dirname, 'model');
const ModelBase = require(Path.join(libPath, 'base.js'))


class VariableModelBase extends ModelBase {

  constructor(handle) {
    super();

    if (handle) {
      this.handle = handle;
    }

  }

  static get meta() {
    let metaKey = this.metaKey;
    let meta = this[metaKey];
    let url = meta.configuration.url;

    if (!meta.configuration.schema) {
      meta.configuration.schema = this.name.toLowerCase();
    }

    if (meta.cache.schema.length < 1) {
      this[metaKey].cache.schema = this.getTables(
        this[metaKey].configuration.url,
        this[metaKey].configuration.schema,
        this[metaKey].configuration.timeout
      );

    }

    return this[metaKey];
  }

  static getValueMeta(dbURL, schema, table, handle, timeout) {
    let crit = [handle];
    let query = 'SELECT * FROM ' + schema + '.' + table + ' '
      + 'WHERE ' + table + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static getValue(dbURL, schema, table, handle, timeout) {
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
    let insIdx = 0;

    let query = 'INSERT INTO ' + schema + '.handle DEFAULT VALUES RETURNING value;';
    let rows = this.executeQuery(dbURL, query, [], timeout);

    for (let tablesIdx = 0; tablesIdx < tables.length; tablesIdx++) {
      let table = tables[tablesIdx];
      let value = values[table];
      let crit = [];

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
    let crit = [handle, val];
    let query = 'UPDATE ' + schema + '.' + table + ' AS ' + table + ' '
      + 'SET value = $2 '
      +  'WHERE ' + table + '.handle = $1 '
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows;
  }

}


module.exports = VariableModelBase;
