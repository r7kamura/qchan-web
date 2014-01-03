class Qchan.Views.Authentication
  constructor: (element: @element) ->
    @template = """
      <div class="name">
        welcome, {name}
      </div>
    """

    Qchan.mediator.on 'load', =>
      @updateUserWithURIFragments()

    Qchan.mediator.on 'signedIn', =>
      @render()

    @user = new Qchan.Models.User()
    @triggerIfSignedIn()

  render: ->
    @element.html($.render(@template, @user))

  updateUserWithURIFragments: ->
    if @hasUserAttributes()
      @user.set(@userAttributes())
      @triggerIfSignedIn()

  triggerIfSignedIn: ->
    Qchan.mediator.trigger('signedIn') if @user.access_token

  userAttributes: ->
    @__userAttributes ||= Qchan.URIFragmentParser.parse(window.location.hash)

  hasUserAttributes: ->
    !!@userAttributes().access_token
