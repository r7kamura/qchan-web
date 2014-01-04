class Qchan.Views.Header extends Qchan.View
  @TEMPLATE = """
    <h1>Qchan</h1>

    <div class="authentication">
      <a href="http://localhost:3000/auth/authorize?redirect_to=http%3A%2F%2Flocalhost%3A4000">
        sign in
      </a>
    </div>
  """

  initialize: ->
    @authentication = new Qchan.Views.Authentication(@, '.authentication')

    @on 'initialized', =>
      @render()
      @authentication.trigger('initialized')
