pairs2obj = (pairs)->
  o={}
  o[key]=value for [key,value] in pairs
  o
minimistOptions = (readme)->
  boolean: (option.short for option in readme.options when not option.argument?)
  string: (option.short for option in readme.options when option.argument?)
  alias: pairs2obj ([option.short,option.long] for option in readme.options when option.long?)
  stopEarly: false

module.exports = (readme)->
  options: ->minimistOptions readme
  help: -> require("./help") readme
  manpage: -> require("./manpage") readme

