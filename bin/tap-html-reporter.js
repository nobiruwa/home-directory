#!/usr/bin/env node
// $ npm install --save tap-parser
// $ node parser.js test.tap > table.html
/*global require:true */
const fs = require('fs');
const util = require('util');
const parser = require('tap-parser');
const process = require('process');

var p = parser();

p.on('complete', function(results) {
  console.log('</table>');
});
p.on('assert', function(assert) {
  const cleanse = function(diagLog) {
    return diagLog.split('\n').map(function(line) {
      var unsafeObj, newLine;
      if (!/{.+}/.test(line)) {
        return null;
      }
      eval('unsafeObj = ' + line);
      newLine = unsafeObj.type + ": " + unsafeObj.text.replace(/^'/, '').replace(/'\n/, '');
      return newLine;
    }).filter(function(line) {
      return line !== null;
    }).join('<br>');
  };
  console.log('<tr>');
  process.stdout.write('<td>' + assert.id + '</td>');
  var isOk = assert.ok ? 'ok' : 'not ok';
  process.stdout.write('<td>' + isOk + '</td>');
  process.stdout.write('<td>' + assert.name + '</td>');
  if (assert.diag && assert.diag.Log) {
    if (assert.diag.message) {
      process.stdout.write(assert.diag.message);
    } else {
      process.stdout.write('<td></td>');
    }
    if (assert.diag.Log) {
      process.stdout.write('<td>' + cleanse(assert.diag.Log) + '</td>');
    } else {
      process.stdout.write('<td></td>');
    }
  }
  process.stdout.write('\n');
  console.log('</tr>');
});
// p.on('plan', function(plan) {
//   console.log('plan');
//   console.dir(plan);
// });
// p.on('version', function(version) {
//   console.log('version');
//   console.dir(version);
// });
// p.on('bailout', function(reason) {
//   console.log('reason');
//   console.dir(reason);
// });
// p.on('child', function(childParser) {
//   console.log('child');
//   console.dir(childParser);
// });
// p.on('extra', function(extra) {
//   console.log('extra');
//   console.dir(extra);
// });
var fileStream = fs.createReadStream(process.argv[2], 'utf-8');
console.log('<table>');
fileStream.pipe(p);
