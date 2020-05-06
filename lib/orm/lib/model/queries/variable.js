


class VariableQueries {

  static getValueMeta(element, property) {
    let query = 'SELECT * FROM ' + element + '.' + property + ' '
      + 'WHERE ' + property + '.handle = $1 ';
      + 'LIMIT 1;';

    return [query];
  }

  static getValue(element, property) {
    let query = 'SELECT value FROM ' + element + '.' + property + ' '
      + 'WHERE ' + property + '.handle = $1 ';
      + 'LIMIT 1;';

    return [query];
  }

  static getAllValues(element, properties) {

    let props = properties.map((property) => {
      return element + '.' + property + '.' + 'value AS ' + property;
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

    let query = 'SELECT ' + props.join(', ') + ' FROM ' + element + '.handle'
      + ' ' + joins.join(' ') + ' WHERE handle.value = $1 '
      + 'LIMIT 1;';

    return [query];
  }

  static createRecord(element, properties, values) {
    let queries = [];
    let valueCount = 0;

    queries.push('INSERT INTO ' + element + '.handle DEFAULT VALUES RETURNING value;');

    for (let propsIdx = 0; propsIdx < properties.length; propsIdx++) {
      let property = properties[propsIdx];
      let value = values[property];
      let query;

      if (property == 'handle') {
        continue;
      }

      if (value) {

        query = 'INSERT INTO ' + element + '.' + property + '(value) '
          + 'VALUES ($1); ';

      } else {
        query = 'INSERT INTO ' + element + '.' + property + ' DEFAULT VALUES; ';

      }

      queries.push(query);
    }

    return queries;
  }

  static setValue(element, property) {
    let query = 'UPDATE ' + element + '.' + property + ' AS ' + property + ' '
      + 'SET value = $2 '
      +  'WHERE ' + property + '.handle = $1;';

    return [query];
  }

}


module.exports = VariableQueries;
