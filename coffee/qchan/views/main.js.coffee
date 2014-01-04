class Qchan.Views.Main extends Qchan.View
  @TEMPLATE = """
    <p>welcome</p>
  """

  initialize: ->
    Qchan.mediator.on 'signedIn', =>
      @render()
