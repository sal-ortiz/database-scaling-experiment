
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

    if (!meta.configuration.element) {
      meta.configuration.element = this.name.toLowerCase();
    }

    if (meta.cache.properties.length < 1) {
      this[metaKey].cache.properties = this.getColumns(
        this[metaKey].configuration.url,
        this[metaKey].configuration.element,
        this[metaKey].configuration.timeout,
      );
    }

    return this[metaKey];
  }

  static getValue(dbURL, element, property, handle, timeout) {
    // TODO: Get a single value from our table.
    let crit = [handle];
    let query = 'SELECT ' + property + ' FROM ' + element + ' '
      + 'WHERE ' + element + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0][property];
  }

  static getAllValues(dbURL, element, handle, timeout) {
    // TODO: Get all the values in a table;
    let crit = [handle];
    let query = 'SELECT *  FROM ' + element + ' '
      + 'WHERE ' + element + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static createRecord(dbURL, element, values, timeout) {
    // TODO: Create a new table entry.
    let properties = Object.keys(values);

    let placeholders = [];

    let crit = properties.map((property, idx, ary) => {
      let value = values[property];

      placeholders.push('$' + (idx + 1).toString());

      return value;
    });

    let query = 'INSERT INTO ' + element + '(' + properties.join(', ') + ') '
      + 'VALUES (' + placeholders.join(', ') + ') RETURNING handle;'

    let rows = this.executeQuery(dbURL, query, crit, timeout);
    let handle = rows[0].handle;

    return handle;
  }

  static setValue(dbURL, element, property,  handle, val, timeout) {
    let crit = [handle, val];
    let query = 'UPDATE ' + element + ' SET '
      + property + ' = $2'
      + ' WHERE handle = $1 RETURNING ' + property + ';';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0][property];
  }

}


module.exports = ControlModelBase;
