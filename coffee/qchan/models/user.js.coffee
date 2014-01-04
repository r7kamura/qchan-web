class Qchan.Models.User
  KEYS = ['access_token', 'email', 'name']

  constructor: ->
    $.observable(@)
    @repository = Qchan.Repository.for('user')

  signIn: (attributes) ->
    if attributes.access_token
      @set(attributes)
    else
      @pull()
    @trigger('signedIn') if @hasCredentials()

  set: (attributes) ->
    for key, value of attributes
      @[key] = value
    @push()

  push: ->
    for key in KEYS
      @repository.set(key, @[key])

  pull: ->
    for key in KEYS
      @[key] = @repository.get(key)

  hasCredentials: ->
    @access_token?
