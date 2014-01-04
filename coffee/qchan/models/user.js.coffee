class Qchan.Models.User
  KEYS = ['access_token', 'email', 'name']

  constructor: ->
    $.observable(@)
    @repository = Qchan.Repository.for('user')
    @pull()

  set: (attributes) ->
    for key in KEYS
      @repository.set(key, @[key] = attributes[key])

  pull: ->
    for key in KEYS
      @[key] = @repository.get(key)
