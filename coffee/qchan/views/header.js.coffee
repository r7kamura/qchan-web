class Qchan.Views.Header extends Qchan.View
  @TEMPLATE = """
    <h1>Qchan</h1>

    <div class="authentication">
    </div>
  """

  initialize: ->
    Qchan.mediator.on 'initialized', =>
      @render()

    new Qchan.Views.Authentication(@, '.authentication')
