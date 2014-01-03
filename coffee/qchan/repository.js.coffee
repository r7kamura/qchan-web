class Qchan.Repository
  @table = {}

  @register: (name, storage) ->
    @table[name] = storage

  @for: (name) ->
    @table[name]
