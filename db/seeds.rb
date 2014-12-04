# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

statuses = Status.create([
  { name: :drying    },
  { name: :curing    },
  { name: :harvest   },
  { name: :growing   },
  { name: :destroyed }
])

formats = Format.create([
  { name: :"65g"     },
  { name: :"45g"	 },
  { name: :"15g"	 },
  { name: :"6L"      }
])

cultivars = Cultivar.create([
  { name: :"BB"     },
  { name: :"YO"	 },
  { name: :"CA"	 },
  { name: :"LG"      }
])

RFIDs = RFID.create([
  { name: :"#######" }
])

Lots = Lot.create([
  { name: :"Lot001" },
  { name: :"Lot002" },
  { name: :"Lot003" }
])