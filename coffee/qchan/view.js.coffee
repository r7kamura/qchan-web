class Qchan.View
  constructor: (@parent, @selector) ->
    @initialize()

  initialize: ->

  render: ->
    @element().html(@template())

  template: ->
    @constructor.TEMPLATE

  element: ->
    @parentElement().find(@selector)

  parentElement: ->
    @parent?.element() || $(document.body)
