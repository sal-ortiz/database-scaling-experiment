

const Path = require('path');

const ControlModelBase = require(Path.join(__dirname, 'lib', 'control_model.js'));
const VariableModelBase = require(Path.join(__dirname, 'lib', 'variable_model.js'));


class DatabaseScalingTest {

  static get VariableModel() {
    return VariableModelBase;
  }

  static get ControlModel() {
    return ControlModelBase;
  }

}


module.exports = DatabaseScalingTest;







//class Author extends DatabaseScalingTest.ControlModel {
class Author extends DatabaseScalingTest.VariableModel {

  constructor(handle) {
    //super('postgres://db-scaling-test@localhost:5432/db-scaling-test-control');
    super('postgres://db-scaling-test@localhost:5432/db-scaling-test-variable');

    if (handle) {
      this.handle = handle;
    }

  }

}


//console.log(Author.getTables('postgres://db-scaling-test@localhost:5432/db-scaling-test-variable', 'author', 6000));

//let author = new Author('TOnWTJulkirhy4utgQ21pJaxXZ1COHchKRqvJaePWen98PzalAY96HVUQs8yVxkN');
//author.handle = 'TOnWTJulkirhy4utgQ21pJaxXZ1COHchKRqvJaePWen98PzalAY96HVUQs8yVxkN';

let author = new Author();

author.email = 'user@gmail.dsdsdcom';
author.password = 'passwdsdord';

author.save();

console.log(author.toJSON());

author.email = 'asdfsdfasd@fsafasdf';
author.password = 'buttwordddd';


author.save();

console.log(author.toJSON());
