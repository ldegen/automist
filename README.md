# automist
Create a CLI from human readable documentation

The automist takes a descriptor object and produces configuration for [minimist](https://github.com/substack/minimist).
- It can also generate a nice help message and an even nicer manpage.
- Bonus: There are no dependencies.

## Installation
You now the drill. Just `npm install` it and your good.
``` bash
npm install --save automist
```
## Usage

First, document your CLI. We use YAML because its easy on the eyes. Coffeescript may also be an option.

In your application, you would feed this readme object to the automist and use it to

- configure your minimist so it parses the command line in accordance with your documentation
- generate a useful help message

Have a look at a working [example](example/). Try:

```bash

coffee example/main.coffee --help
coffee example/main.coffee --manpage | man -l -

```

## Future Plans

### process markdown input
On the input side, it might be nice to extract the `readme`-object from
a markdown. This would be nice for github projects, where it is very common
to have a README.md file as your primary form of documentation.

