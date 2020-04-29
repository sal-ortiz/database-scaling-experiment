
const URL = require('url');
const Path = require('path');

const libPath = Path.join(__dirname, 'model');
const ModelBase = require(Path.join(libPath, 'base.js'))


class VariableModelBase extends ModelBase {

  constructor(dbURL) {
    super(dbURL);
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
