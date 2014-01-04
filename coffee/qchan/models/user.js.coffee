class Qchan.Models.User
  KEYS = ['access_token', 'email', 'name']

  constructor: ->
    $.observable(@)
    @repository = Qchan.Repository.for('user')

  set: (attributes) ->
    for key, value of attributes
      @[key] = value
    @push()
    @trigger('signedIn') if @hasCredentials()

  push: ->
    for key in KEYS
      @repository.set(key, @[key])

  pull: ->
    for key in KEYS
      @[key] = @repository.get(key)
    @trigger('signedIn') if @hasCredentials()

  hasCredentials: ->
    @access_token?
