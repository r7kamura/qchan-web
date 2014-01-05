class Qchan.Views.Application extends Qchan.View
  @TEMPLATE = """
    <header id="header"></header>

    <div id="main"></div>
  """

  initialize: ->
    Qchan.mediator.on 'initialized', =>
      @render()

    new Qchan.Views.Header(@, '#header')
    new Qchan.Views.Main(@, '#main')
