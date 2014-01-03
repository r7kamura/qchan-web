# Manages browser loading event.
class Qchan.Controller
  constructor: ->
    $.observable(@)
    @user = new Qchan.User()
    @view = new Qchan.Views.Authentication()

    @on 'load', ->
      @setUserAttributes() if @hasUserAttributes()
      @updateUser() if @hasAccessToken()

    @user.on 'updated', =>
      @view.render(@user)

  updateUser: ->
    @user.trigger('updated')

  hasAccessToken: ->
    !!@user.access_token

  setUserAttributes: ->
    @user.set(@userAttributes())

  hasUserAttributes: ->
    !!Object.keys(@userAttributes()).length

  userAttributes: ->
    @__userAttributes ||= Qchan.URIFragmentParser.parse(window.location.hash)
