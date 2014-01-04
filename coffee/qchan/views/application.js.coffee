class Qchan.Views.Application extends Qchan.View
  @TEMPLATE = """
    <header id="header"></header>

    <div id="main"></div>
  """

  initialize: ->
    @header = new Qchan.Views.Header(@, '#header')

    Qchan.mediator.on 'render', =>
      @trigger('render')

    @on 'render', =>
      @render()
      @header.trigger('render')
