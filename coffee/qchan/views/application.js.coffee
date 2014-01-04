class Qchan.Views.Application extends Qchan.View
  @TEMPLATE = """
    <header id="header"></header>

    <div id="main"></div>
  """

  initialize: ->
    @header = new Qchan.Views.Header(@, '#header')
    @main = new Qchan.Views.Main(@, '#main')

    Qchan.mediator.on 'initialized', =>
      @render()
      @header.trigger('initialized')
