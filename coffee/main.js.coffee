# Configuration for Dependency Injection
Qchan.Repository.register('user', new Qchan.Repositories.LocalStorage())
Qchan.mediator = new Qchan.Mediator()
Qchan.configuration.apiServerOrigin = 'http://localhost:3000'
Qchan.configuration.clientServerOrigin = 'http://localhost:4000'

# Create a tree of view objects
new Qchan.Views.Application(null, '#application')

# Trigger events after objects initialization
#
# * Load data from LocalStorage
# * Render HTML elements
#
Qchan.mediator.trigger('initialized')

# Trigger events after view rendering
#
# * Authentication
# * Re-render HTML elements if authentication succeeded
#
Qchan.mediator.trigger('rendered')
