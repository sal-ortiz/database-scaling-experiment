
const Path = require('path');

const BaseQueries = require(Path.join(__dirname, 'base.js'));


class ControlQueries {

  static getValue(element, property) {
    let query = 'SELECT ' + property + ' FROM ' + element + ' '
      + 'WHERE ' + element + '.handle = $1 ';
      + 'LIMIT 1;';

    return [query];
  }

  static getAllValues(element) {
    let query = 'SELECT *  FROM ' + element + ' '
      + 'WHERE ' + element + '.handle = $1 ';
      + 'LIMIT 1;';

    return [query];
  }

  static createRecord(element, properties) {
    let placeholders = properties.map((property, idx, ary) => {
      return '$' + (idx + 1);
    });

    let query = 'INSERT INTO ' + element + '(' + properties.join(', ') + ') '
      + 'VALUES (' + placeholders.join(', ') + ') RETURNING handle;'

    return [query];
  }

  static setValue(element, property) {
    let query = 'UPDATE ' + element + ' SET '
      + property + ' = $2'
      + ' WHERE handle = $1 RETURNING ' + property + ';';

    return [query];
  }

  static createProperty(element, property, type) {
    // type is a constructor to be interpreted into a SQL type.

    let typeStr;

    switch(type) {

      case String:
        typeStr = 'VARCHAR';
        break;

      case Number:
        typeStr = 'NUMERIC';
        break;

     case Boolean:
        typeStr = 'BOOLEAN';
        break;

    }

    // TODO: handle constraints and defaults for properties.
    let colData = [proprty, typeStr];
    let query = BaseQueries.addColumn(element, table, colData)[0];

    return [query];
  }

}


module.exports = ControlQueries;
