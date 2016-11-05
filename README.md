# automist
Create a CLI from human readable documentation

The automist takes a yaml file and produces a configuration object for [minimist](https://github.com/substack/minimist).


# Installation
You now the drill. Just `npm install` it and your good.
``` bash
npm install --save automist
```
# Usage

First, document your CLI. We use YAML here, because its easy on the eyes. Coffeescript may also be an option.


```yaml
---
synopsis: |
  foobar [<options> ...] [<input>]
  
usage: |
  Describe what *foobar* does, how it is used.

# if your programm uses key-value-based configuration file or similar
# you can describe this here.
configuration: 
  someConfigKey: A description of that key.
  someOtherKey: |
    Even more description. YAML is great for that kind of stuff, you
    could put anything here, includeing markup of any kind, even
    nest another yaml document, as long as you keep the indent-levels
    consistent.

options:
  - short: c
    long: config-file
    argument: path
    description:: |
      Read configuration from  '<path>'. If ommited, the configuration is 
      read from `FOOBAR_HOME/config.json`
  - short: h
    long: help
    description: |
      Print this help message
```

In your application, you would feed this file to the automist like this:
```coffee

yaml = require "js-yaml"
automist = require "automist"
minimist = require "minimist"
readme =  yaml.load fs.readFileSync path.join __dirname, '..', 'README.yaml'
argv = minimist process.argv.slice(2), automist readme
if argv.h
  console.log automist.help readme
  process.exit -1
```

