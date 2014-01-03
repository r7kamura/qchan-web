Qchan.Repository.register('user', new Qchan.Repositories.LocalStorageRepository())

$ ->
  controller = new Qchan.Controller
  controller.trigger('load')
