



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

}


module.exports = ControlQueries;
