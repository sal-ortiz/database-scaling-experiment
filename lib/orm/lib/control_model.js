
const URL = require('url');
const Path = require('path');

const libPath = Path.join(__dirname, 'model');
const ModelBase = require(Path.join(libPath, 'base.js'))


class ControlModelBase extends ModelBase {

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
      this[metaKey].cache.schema = this.getColumns(
        this[metaKey].configuration.url,
        this[metaKey].configuration.schema,
        this[metaKey].configuration.timeout,
      );
    }

    return this[metaKey];
  }

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
    let columns = this.meta.cache.schema;
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

}


module.exports = ControlModelBase;
