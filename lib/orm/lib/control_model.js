
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

  }

  static get getProperties() {
    return this.getColumns;
  }

  static getValue(dbURL, element, property, handle, timeout) {
    let crit = [handle];
    let query = Queries.Control.getValue(element, property)[0];

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0][property];
  }

  static getAllValues(dbURL, element, handle, timeout) {
    let crit = [handle];
    let query = Queries.Control.getAllValues(element)[0];

    let rows = this.executeQuery(dbURL, query, crit, timeout);

    return rows[0];
  }

  static createRecord(dbURL, element, values, timeout) {
    let properties = Object.keys(values);
    let data = Object.values(values);

    let query = Queries.Control.createRecord(element, properties)[0];

    let rows = this.executeQuery(dbURL, query, data, timeout);
    let handle = rows[0].handle;

    return handle;
  }

  static setValue(dbURL, element, property,  handle, value, timeout) {
    let data = [handle, value];
    let query = Queries.Control.setValue(element, property)[0];

    let rows = this.executeQuery(dbURL, query, data, timeout);

    return rows[0][property];
  }

}


module.exports = ControlModelBase;
