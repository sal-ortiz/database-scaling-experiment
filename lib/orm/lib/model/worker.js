#!/usr/bin/env node

const Client = require('pg').Client;
const File = require('fs');


const executeQuery = function(client, query, values) {
  client.connect((err) => {

    if (err) {
      error(err);
    }

    client.query(query, values, (err, res) => {
      client.end();

      if (err) {
        error(err);

      } else {
        output(res.rows);

      }

    });

  })


}

const output = function(data) {
  let dataStr = JSON.stringify(data);

  process.stdout.write(dataStr, process.exit);
}

const error = function(err) {
  let errStr = JSON.stringify(err);

  process.stdout.write(errStr, process.exit);
};


let argsStr = File.readFileSync(process.stdin.fd, 'utf-8');
let args = JSON.parse(argsStr);

let client = new Client({
  connectionString: args.url,
});

let query = args.query;
let values = args.values;

executeQuery(client, query, values);
