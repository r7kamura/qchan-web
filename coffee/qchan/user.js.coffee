class Qchan.User
  constructor: ->
    $.observable(@)
    @repository = Qchan.Repository.for('user')
    @keys = ['access_token', 'email', 'name']
    @sync()

  set: (attributes) ->
    for key in @keys
      @repository.set(key, @[key] = attributes[key])

  sync: ->
    for key in @keys
      @[key] = @repository.get(key)
