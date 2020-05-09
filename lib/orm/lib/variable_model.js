
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

    if (this.constructor.meta.cache.properties.length < 1) {
      let element = this.constructor.meta.configuration.element;

      this.constructor.meta.cache.properties = this.constructor.getTables(element);
    }

  }

  static getValueMeta(element, property, handle) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [handle];
    let query = Queries.Variable.getValueMeta(element, property)[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    return rows[0];
  }

  static getValue(element, property, handle) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [handle];
    let query = Queries.Variable.getValue(element, property)[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    return rows[0].value;
  }

  static getAllValues(element, handle) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let properties = this.meta.cache.properties;
    let crit = [handle];
    let query = Queries.Variable.getAllValues(element, properties)[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    return rows[0];
  }

  static createRecord(element, values) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let properties = this.meta.cache.properties;
    let queries = Queries.Variable.createRecord(element, properties, values);

    // we must create a handle record first.
    let handleRows = this.executeQuery(url, queries[0], [], timeout);
    let handle = handleRows[0].value;

    for (let idx = 0; idx < queries.length; idx++) {
      let query = queries[idx + 1];
      let property = properties[idx];

      if (property == 'handle') {
        continue;
      }

      let value = values[property];
      let data = (value && [value]) || [];

      this.executeQuery(url, query, data, timeout);
    }

    return handle;
  }

  static setValue(element, property, handle, value) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let properties = this.meta.cache.properties;
    let data = [handle, value];
    let query = Queries.Variable.setValue(element, property)[0];

    if (!properties.includes(property)) {
      let type = value.constructor;

      this.addProperty(element, property, type);
    }

    let rows = this.executeQuery(url, query, data, timeout);

    return rows;
  }

  static addProperty(element, property, type) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let query = Queries.Variable.createProperty(element, property, type)[0];

    let rows = this.executeQuery(url, query, [], timeout);
  }

}


module.exports = VariableModelBase;
