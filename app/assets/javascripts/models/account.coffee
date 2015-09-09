WildCompass.Account = DS.Model.extend
  prefix: DS.belongsTo('prefix'),
  number: DS.attr('number'),
  value: DS.attr('number'),
  debits: DS.hasMany('transaction'),
  credits: DS.hasMany('transaction')
