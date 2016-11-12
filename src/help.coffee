
optsSwitch = (o)->
  s="-#{o.short}"
  if o.long?
    s += ", --#{o.long}"
  s+= " <#{o.argument}>" if o.argument?
  s

synopsis = (readme)->
  [
    "#{readme.name.split('-')[0].trim()}"
    "[option …]"
  ].concat( for arg in readme.arguments
      s=arg.name
      s+=" …" if arg.moreThanOnce
      s="[#{s}]" if arg.optional
      s
  ).join " "

par = (input, {totalWidth=process.stdout.columns, indent=""})->
  inputLines = input.split '\n'
  buf = ""
  output = []
  for line in inputLines
    if line.trim().length == 0 or line.match /^\s/
      output.push indent+buf if buf.length > 0
      output.push indent+line
      buf = ""
    else
      words = line.split /\s+/
      for word in words
        shouldWrap = indent.length+buf.length+word.length + 1 > totalWidth
        if (buf.length >0) and shouldWrap
          output.push indent+buf
          buf = ""
        buf += " " if buf.length > 0
        buf += word
  output.push buf if buf.length >0
  output.join "\n"

option = (o)->
  """
  #{optsSwitch(o)} 
    
  #{par o.description, indent: "   "}
  """
help= (readme)->
  opts = (option o for o in readme.options)
  """

  Synopsis:

    #{synopsis readme}

  Options:

  #{opts.join "\n"}
  
  """

module.exports = help
