class Qchan.Views.Authentication
  constructor: ->
    @template = $('#authentication-template').html()
    @container = $('#authentication')

  render: (user) ->
    @container.html($.render(@template, user))
