
const URL = require('url');
const Path = require('path');

const libPath = Path.join(__dirname, 'model');
const ModelBase = require(Path.join(libPath, 'base.js'))

const Queries = require(Path.join(libPath, 'queries.js'));


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
    let query = Queries.Variable.getValueMeta(element, property)[0];

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static getValue(dbURL, element, property, handle, timeout) {
    let crit = [handle];
    let query = Queries.Variable.getValue(element, property)[0];

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0].value;
  }

  static getAllValues(dbURL, element, handle, timeout) {
    let properties = this.meta.cache.properties;
    let crit = [handle];

    let query = Queries.Variable.getAllValues(element, properties)[0];

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static createRecord(dbURL, element, values, timeout) {
    let properties = this.meta.cache.properties;
    let queries = Queries.Variable.createRecord(element, properties, values);

    // we must create a handle record first.
    let handleRows = this.executeQuery(dbURL, queries[0], [], timeout);
    let handle = handleRows[0].value;

    for (let idx = 0; idx < queries.length; idx++) {
      let query = queries[idx + 1];
      let property = properties[idx];

      if (property == 'handle') {
        continue;
      }

      let value = values[property];
      let data = (value && [value]) || [];

      this.executeQuery(dbURL, query, data, timeout);
    }

    return handle;
  }

  static setValue(dbURL, element, property, handle, val, timeout) {
    let data = [handle, val];
    let query = Queries.Variable.setValue(element, property)[0];

    let rows = this.executeQuery(dbURL, query, data, timeout);

    return rows;
  }

}


module.exports = VariableModelBase;
