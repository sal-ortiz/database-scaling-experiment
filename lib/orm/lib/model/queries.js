
const Path = require('path');

const libPath = Path.join(__dirname, 'queries');
const ControlQueries = require(Path.join(libPath, 'control.js'));
const VariableQueries = require(Path.join(libPath, 'variable.js'));


class Queries {

  static get Control() {
    return ControlQueries;
  }

  static get Variable() {
    return VariableQueries;
  }

}


module.exports = Queries;
