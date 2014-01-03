class Qchan.Views.Header
  constructor: (element: @element) ->
    @authentication = new Qchan.Views.Authentication(element: @element.find('.authentication'))
