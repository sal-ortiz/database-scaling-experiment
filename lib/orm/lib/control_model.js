
const URL = require('url');
const Path = require('path');

const libPath = Path.join(__dirname, 'model');
const ModelBase = require(Path.join(libPath, 'base.js'));

const Queries = require(Path.join(libPath, 'queries.js'));


class ControlModelBase extends ModelBase {

  constructor(handle) {
    super();

    if (handle) {
      this.handle = handle;
    }

    if (this.constructor.meta.cache.properties.length < 1) {
      let element = this.constructor.meta.configuration.element;

      this.constructor.meta.cache.properties = this.constructor.getColumns(element);
    }

  }

  static getValue(element, property, handle) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [handle];
    let query = Queries.Control.getValue(element, property)[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    return rows[0][property];
  }

  static getAllValues(element, handle) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let crit = [handle];
    let query = Queries.Control.getAllValues(element)[0];

    let rows = this.executeQuery(url, query, crit, timeout);

    return rows[0];
  }

  static createRecord(element, values) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let properties = Object.keys(values);
    let data = Object.values(values);

    let query = Queries.Control.createRecord(element, properties)[0];

    let rows = this.executeQuery(url, query, data, timeout);
    let handle = rows[0].handle;

    return handle;
  }

  static setValue(element, property, handle, value) {
    let url = this.meta.configuration.url;
    let timeout = this.meta.configuration.timeout;

    let properties = this.meta.cache.properties;
    let data = [handle, value];
    let query = Queries.Control.setValue(element, property)[0];

    let rows = this.executeQuery(dbURL, query, data, timeout);

    return rows[0][property];
  }

}


module.exports = ControlModelBase;
