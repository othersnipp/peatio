class Currency extends PeatioModel.Model
  @configure 'Currency', 'key', 'code', 'coin', 'blockchain'

  @initData: (records) ->
    PeatioModel.Ajax.disable ->
      $.each records, (idx, record) ->
        console.log(record)
        currency = Currency.create(record.attributes)

window.Currency = Currency
