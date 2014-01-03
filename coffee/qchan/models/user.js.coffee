class Qchan.Models.User
  constructor: ->
    $.observable(@)
    @repository = Qchan.Repository.for('user')
    @keys = ['access_token', 'email', 'name']
    @pull()

  set: (attributes) ->
    for key in @keys
      @repository.set(key, @[key] = attributes[key])

  pull: ->
    for key in @keys
      @[key] = @repository.get(key)
