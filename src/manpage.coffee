  
inlineMarkup = (s)->
  s
    .replace /\*\*([^*]+)\*\*/g, (_,w)->"\\f[B]"+w+"\\f[]"
    .replace /\*([^*]+)\*/g, (_,w)->"\\f[I]"+w+"\\f[]"
    .replace /`([^`]+)`/g, (_,w)->"\\f[B]"+w+"\\f[]"
    .replace /<([^>]+)\>/g, (_,w)->"\\f[I]"+w+"\\f[]"


synopsis = (readme)->
  [
    "\\f[B]#{readme.name.split('-')[0].trim()}\\f[]"
    "[\\f[I]option\\f[] …]"
  ].concat( for arg in readme.arguments
      s="\\f[I]#{arg.name}\\f[]"
      s+=" …" if arg.moreThanOnce
      s="[#{s}]" if arg.optional
      s
  ).join "\n"

description = (readme)->
  inlineMarkup readme.description

ite = (i,t=i,e="")->if i? then t else e
option = (o)->
  names =[ 
    ite o.short, "\\f[B]\\-#{o.short}\\f[]"
    ite o.long, "\\f[B]\\-\\-#{o.long}\\f[]"
  ]
    .filter (s)->s?
    .join ", "

  """
  .TP
  .B #{names}#{ite o.argument, " \\f[I]"+o.argument+"\\f[]"}
  #{inlineMarkup o.description}
  """
options = (readme)->
  (option d for d in readme.options).join '\n'

module.exports = man = (readme)->
  [name] = readme.name.split /\s*-\s*/
  """
  .TH #{name.toUpperCase()} #{readme.section}
  .SH NAME
  .PP
  #{readme.name.split('-').join " \- "}
  .SH SYNOPSIS
  .PP
  #{synopsis readme}
  .SH DESCRIPTION
  .PP
  #{description readme}
  .SH OPTIONS
  .PP
  #{options readme}
  """


