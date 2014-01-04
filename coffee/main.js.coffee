# Configuration.
Qchan.Repository.register('user', new Qchan.Repositories.LocalStorage())
Qchan.mediator = new Qchan.Mediator()

# Create and start our application instance.
new Qchan.Views.Application(null, '#application')

Qchan.mediator.trigger('initialized')
Qchan.mediator.trigger('rendered')
