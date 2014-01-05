class Qchan.Views.Authentication extends Qchan.View
  @TEMPLATE_BEFORE_SIGNED_IN = """
    <a href="{apiServerOrigin}/auth/authorize?redirect_to={clientServerOrigin}">
      sign in
    </a>
  """

  @TEMPLATE_AFTER_SIGNED_IN = """
    <div class="name">
      {name}
    </div>
  """

  initialize: ->
    Qchan.mediator.on 'initialized', =>
      @render()

    Qchan.mediator.on 'rendered', =>
      @user.signIn(Qchan.URIFragmentParser.parse(window.location.hash))

    Qchan.mediator.on 'signedIn', =>
      @render()

    @user = new Qchan.Models.User()

    @user.on 'signedIn', ->
      Qchan.mediator.trigger 'signedIn'

  template: ->
    if @user.access_token
      $.render(@constructor.TEMPLATE_AFTER_SIGNED_IN, @user)
    else
      $.render(
        @constructor.TEMPLATE_BEFORE_SIGNED_IN,
        apiServerOrigin: Qchan.configuration.apiServerOrigin,
        clientServerOrigin: window.encodeURIComponent(Qchan.configuration.clientServerOrigin),
      )
