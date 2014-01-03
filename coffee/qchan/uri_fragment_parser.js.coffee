class Qchan.URIFragmentParser
  @parse: (fragment) ->
    new @(fragment).parse()

  constructor: (@fragment) ->

  parse: ->
    table = {}
    for segment in @segments()
      [key, value] = segment.split('=', 2)
      table[key] = window.decodeURIComponent(value) if value
    table

  segments: ->
    @fragment.substr(1).split('&')
