


class BaseQueries {

  static getSchemas() {
    let query = 'SELECT DISTINCT schema_name '
      + 'FROM information_schema.schemata;';

    return [query];
  }

  static getTables() {
    let query = 'SELECT table_name '
      + 'FROM information_schema.tables '
      + 'WHERE table_schema = $1';

    return [query];
  }

  static getColumns() {
    let query = 'SELECT DISTINCT column_name '
      + 'FROM information_schema.columns '
      + 'WHERE table_name = $1;';

    return [query];
  }

  static createTable(schema, table, colsData) {

    let colsStrAry = colsData.map((colData) => {
      return colData.join(' ');
    });

    let query = 'CREATE TABLE ' + schema + '.' + table + '('      + colsStrAry.join(', ')
      + ');'

    return [query];
  }

  static addColumn(schema, table, colData) {
    let colStr = colData.join(' ');

    let query = 'ALTER TABLE ' + schema + '.' + table + ' '
      + 'ADD COLUMN ' + colStr;

    return [query];
  }

  static addSchema(schema) {
    let query = 'CREATE SCHEMA IF NOT EXISTS ' + schema;

    return [query];
  }

}


module.exports = BaseQueries;
