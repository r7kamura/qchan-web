# Configuration phase.
#
# We use Repository Pattern to do away LocalStorage from testing environment.
# This repository is replaced with some other on-memory KVS in such environment.
#
Qchan.Repository.register('user', new Qchan.Repositories.LocalStorageRepository())

# Activity
repository = Qchan.Repository.for('user')
switch
  when repository.get('accessToken')
    console.log('Access token already exists')
  when token = Qchan.URIFragmentParser.parse(window.location.hash).access_token
    repository.set('accessToken', token)
    console.log('Access token was set')
  else
    console.log('No access token given!')
