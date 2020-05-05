

const Path = require('path');

const libPath = Path.join(__dirname, 'error');
const PgErrors = require(Path.join(libPath, 'pg.js'));



class ExecutionError extends Error {

  constructor(err) {
    super();

    let pgErr = PgErrors[err.code];

    this.code = err.code;
    this.name = pgErr.message;
    this.message = pgErr.identifier;

    this.lineNumber = err.line;
    this.columnNumber = err.position;

    this.fileName = err.file;
  }

}


module.exports = ExecutionError;
