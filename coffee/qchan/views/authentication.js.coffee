class Qchan.Views.Authentication extends Qchan.View
  @TEMPLATE = """
    <a href="http://localhost:3000/auth/authorize?redirect_to=http%3A%2F%2Flocalhost%3A4000">
      sign in
    </a>
  """

  @TEMPLATE_AFTER_SIGNED_IN = """
    <div class="name">
      {name}
    </div>
  """

  initialize: ->
    @user = new Qchan.Models.User()

    @on 'initialized', =>
      @render()

    Qchan.mediator.on 'rendered', =>
      if (attributes = Qchan.URIFragmentParser.parse(window.location.hash)).access_token
        @user.set(Qchan.URIFragmentParser.parse(window.location.hash))
      else
        @user.pull()

    Qchan.mediator.on 'signedIn', =>
      @render()

    @user.on 'signedIn', ->
      Qchan.mediator.trigger 'signedIn'

  template: ->
    if @user.access_token
      $.render(@constructor.TEMPLATE_AFTER_SIGNED_IN, @user)
    else
      super
