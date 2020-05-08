
const Path = require('path');

const libPath = Path.join(__dirname, 'queries');
const BaseQueries = require(Path.join(libPath, 'base.js'));
const ControlQueries = require(Path.join(libPath, 'control.js'));
const VariableQueries = require(Path.join(libPath, 'variable.js'));


class Queries {

  static get Base() {
    return BaseQueries;
  }

  static get Control() {
    return ControlQueries;
  }

  static get Variable() {
    return VariableQueries;
  }

}


module.exports = Queries;
