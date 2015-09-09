WildCompass.Transaction = DS.Model.extend
  value: DS.attr('number'),
  credit: DS.belongsTo('transaction'),
  debit: DS.belongsTo('transaction')
