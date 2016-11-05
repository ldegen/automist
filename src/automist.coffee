optsSwitch = (o)->
  s="-#{o.short}"
  s+= " <#{o.argument}>" if o.argument?
  if o.long?
    s += ",\n--#{o.long}"
    s+= " <#{o.argument}>" if o.argument?
  s
pairs2obj = (pairs)->
  o={}
  o[key]=value for [key,value] in pairs
  o
minimistOptions = (readme)->
  boolean: (option.short for option in readme.options when not option.argument?)
  string: (option.short for option in readme.options when option.argument?)
  alias: pairs2obj ([option.short,option.long] for option in readme.options when option.long?)
  stopEarly: false

help= (readme)->
  opts = ({option:optsSwitch(option), description:option.description+'\n\n'} for option in readme.options)
  optionColumns = columnify opts,
    minWidth:15
    config:
      description:
        preserveNewLines:true
      option:
        maxWidth:35
  configColumns = columnify readme.configuration
  """

  Synopsis:
  =========

    #{readme.synopsis}

  Usage:
  ======

  #{readme.usage}

  Valid Options:
  ==============

  #{optionColumns}

  Configuration:
  ==============
  
  The following settings are read from the configuration file:

  #{configColumns}
  
  """

module.exports = minimistOptions
module.exports.help = help
