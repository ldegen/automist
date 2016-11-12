fs = require "fs"
path = require "path"
yaml = require "js-yaml"
readme =  yaml.load fs.readFileSync path.join __dirname,  'README.yaml'
automist = require("../src/automist") readme
minimist = require "minimist"
argv = minimist process.argv.slice(2), automist.options()
if argv.h
  console.log automist.help()
  process.exit -1
if argv.m
  console.log automist.manpage()
console.log "argv:", argv
