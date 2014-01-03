# Configuration.
Qchan.Repository.register('user', new Qchan.Repositories.LocalStorageRepository())

# Create and start our application instance.
new Qchan.Views.Application()
