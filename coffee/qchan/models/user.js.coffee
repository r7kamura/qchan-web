class Qchan.Models.User
  KEYS = ['access_token', 'email', 'name']

  constructor: ->
    $.observable(@)
    @repository = Qchan.Repository.for('user')
    @pull()

  set: (attributes) ->
    @repository.set(key, @[key] = attributes[key]) for key in KEYS
    @trigger('updated')

  pull: ->
    for key in KEYS
      @[key] = @repository.get(key)

  loadAttributesFromFragment: ->
    @set(attributes) if (attributes = Qchan.URIFragmentParser.parse(window.location.hash)).access_token
