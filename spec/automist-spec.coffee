describe "The Automist", ->
  readme = undefined
  automist = require "../src/automist"
  beforeEach ->
    readme =
      synopsis: "foobar [ <option> … ] <file> …"
      usage: """
      Ferner gibt es auch niemanden, der den Schmerz um seiner selbst willen
      liebt, der ihn sucht und haben will, einfach, weil es Schmerz ist […].
      """
      configuration:
        specialKey: "Ein spezieller Schlüssel für ganze besondere Anlässe."
        commonKey: "Ein eher gewöhnlicher Schlüssel"

      options: [
        short:'h'
        long:'help'
        description: """
        Help! (engl. ‚Hilfe!‘) ist das fünfte Album der Beatles und Soundtrack
        zum gleichnamigen Film, der im deutschsprachigen Raum unter dem Titel
        Hi-Hi-Hilfe! in die Kinos kam. Veröffentlicht wurde es am 6. August
        1965.
        """
      ,
        short: 'c'
        long: 'config'
        argument: 'path'
        description: "Path to the configuration file to read. Defaults to $HOME/.foobarrc"
      ]

  it "assumes that an otion is a boolean if no argument was given", ->
    opts = automist readme
    expect(opts.boolean).to.eql ['h']
    expect(opts.string).to.eql ['c']

  it "registers the long option names as aliasses", ->
    opts = automist readme
    expect(opts.alias).to.eql
      h:'help'
      c:'config'
