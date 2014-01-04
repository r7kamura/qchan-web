class Qchan.Views.Authentication extends Qchan.View
  @TEMPLATE = """
    <a href="http://localhost:3000/auth/authorize?redirect_to=http%3A%2F%2Flocalhost%3A4000">
      sign in
    </a>
  """

  @TEMPLATE_AFTER_SIGNED_IN = """
    <div class="name">
      welcome, {name}
    </div>
  """

  initialize: ->
    @on 'initialized', =>
      @render()

    Qchan.mediator.on 'loaded', =>
      @updateUserWithURIFragments()
      @triggerIfSignedIn()

    Qchan.mediator.on 'signedIn', =>
      @render()

    @user = new Qchan.Models.User()

  updateUserWithURIFragments: ->
    @user.set(@userAttributes()) if @hasUserAttributes()

  triggerIfSignedIn: ->
    Qchan.mediator.trigger('signedIn', @user) if @user.access_token

  userAttributes: ->
    @__userAttributes ||= Qchan.URIFragmentParser.parse(window.location.hash)

  hasUserAttributes: ->
    !!@userAttributes().access_token

  template: ->
    if @user.access_token
      $.render(@constructor.TEMPLATE_AFTER_SIGNED_IN, @user)
    else
      super
