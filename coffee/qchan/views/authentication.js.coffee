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
    @user = new Qchan.Models.User()

    @on 'initialized', =>
      @render()

    Qchan.mediator.on 'loaded', =>
      @user.loadAttributesFromFragment()

    @user.on 'updated', ->
      @render()

  template: ->
    if @user.access_token
      $.render(@constructor.TEMPLATE_AFTER_SIGNED_IN, @user)
    else
      super
