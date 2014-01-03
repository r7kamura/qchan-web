class Qchan.Views.Application
  constructor: ->
    Qchan.mediator = new Qchan.Mediator()

    @element = $('#application')
    @element.html(
      """
        <header id="header">
          <h1>Qchan</h1>

          <div class="authentication">
            <a href="http://localhost:3000/auth/authorize?redirect_to=http%3A%2F%2Flocalhost%3A4000">
              sign in
            </a>
          </div>
        </header>
        <div id="main"></div>
      """
    )

    @header = new Qchan.Views.Header(element: @element.find('#header'))

    Qchan.mediator.trigger('load')
