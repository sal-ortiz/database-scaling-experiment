

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





//const url = 'postgres://db-scaling-test@localhost:5432/db-scaling-test-control';
const url = 'postgres://db-scaling-test@localhost:5432/db-scaling-test-variable';

//class Author extends DatabaseScalingTest.ControlModel {
class Author extends DatabaseScalingTest.VariableModel {

}


Author.url = url;

let author = new Author();

author.email = 'user@gmail.dsdsdcom';
author.password = 'passwdsdord';
author.save();

console.log();
console.log(author.toJSON());

author.email = 'asdfsdfasd@fsafasdf';
author.password = 'buttwordddd';
author.save();

console.log();
console.log(author.toJSON());


let handle = author.handle;

author = new Author(handle);

console.log();
console.log(author.toJSON());
