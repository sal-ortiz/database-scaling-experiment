
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

    if (!meta.configuration.element) {
      meta.configuration.element = this.name.toLowerCase();
    }

    if (meta.cache.properties.length < 1) {
      this[metaKey].cache.properties = this.getTables(
        this[metaKey].configuration.url,
        this[metaKey].configuration.element,
        this[metaKey].configuration.timeout
      );

    }

    return this[metaKey];
  }

  static getValueMeta(dbURL, element, property, handle, timeout) {
    let crit = [handle];
    let query = 'SELECT * FROM ' + element + '.' + property + ' '
      + 'WHERE ' + property + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static getValue(dbURL, element, property, handle, timeout) {
    let crit = [handle];
    let query = 'SELECT value FROM ' + element + '.' + property + ' '
      + 'WHERE ' + property + '.handle = $1 ';
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0].value;
  }

  static getAllValues(dbURL, element, handle, timeout) {
    let properties = this.getTables(dbURL, element, timeout);

    let props = properties.map((property) => {
      return property + '.' + 'value AS ' + property;
    });

    props.push(element + '.handle.created AS created');
    props.push(element + '.handle.updated AS updated');

    let joins = properties.map((property) => {
      if (property != 'handle') {
        return 'INNER JOIN ' + element + '.' + property + ' '
          + 'ON ' + property + '.handle = ' + 'handle.value'
      } else {
        return '';
      }

    });

    let crit = [handle];
    let query = 'SELECT ' + props.join(', ') + ' FROM ' + element + '.handle'
      + ' ' + joins.join(' ') + ' WHERE handle.value = $1 ';
      + 'LIMIT 1;'

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static createRecord(dbURL, element, values, timeout) {
    let properties = this.getTables(dbURL, element, timeout);
    let insIdx = 0;

    let query = 'INSERT INTO ' + element + '.handle DEFAULT VALUES RETURNING value;';
    let rows = this.executeQuery(dbURL, query, [], timeout);

    for (let propsIdx = 0; propsIdx < properties.length; propsIdx++) {
      let property = properties[propsIdx];
      let value = values[property];
      let crit = [];

      if (property == 'handle') {
        continue;
      }

      if (value) {
        crit.push(value);

        query = 'INSERT INTO ' + element + '.' + property + '(value) '
          + 'VALUES ($' + crit.length + '); ';

      } else {
        query = 'INSERT INTO ' + element + '.' + property + ' DEFAULT VALUES; ';

      }

      this.executeQuery(dbURL, query, crit, timeout);
    }

    let handle = rows[0].value;

    return handle;
  }

  static setValue(dbURL, element, property, handle, val, timeout) {
    let crit = [handle, val];
    let query = 'UPDATE ' + element + '.' + property + ' AS ' + property + ' '
      + 'SET value = $2 '
      +  'WHERE ' + property + '.handle = $1 '
      + 'LIMIT 1;';

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows;
  }

}


module.exports = VariableModelBase;
