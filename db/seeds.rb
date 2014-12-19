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

strains = Strain.create([
  { name: :"Big Blue Bubble Buds", acronym: :"Bb"  },
  { name: :"Yo Diamond", acronym: :"Yo"	 	},
  { name: :"Good Meds", acronym: :"Gm"	 	},
  { name: :"Snow Leopard", acronym: :"LG"     },
  { name: :"Mk", acronym: :"Mk"  },
  { name: :"Casey x Ww" , acronym: :"CxWw"   },
  { name: :"Space Queen", acronym: :"Sq"   },
  { name: :"Critical Cheese", acronym: :"Cc"     },
  { name: :"Norther Lights 5", acronym: :"NlxBb" ,info: :"Nl x Bb" },
  { name: :"(Pmayi)", acronym: :"Pm1"   },
  { name: :"(Pmayi)", acronym: :"Pm2"   },
  { name: :"(Krona x Norther California", acronym: :"Ks"     },
  { name: :"(Cambodian x Mes Gold x Lumbo Gold x Thai x Maui)", acronym: :"Pg"  },
  { name: :"Socal Master Kush", acronym: :"Sc"   },
  { name: :"Prayer Tower", acronym: :"Pt"   },
  { name: :"Shark Shock", acronym: :"Ss"     },
])

password = 'wildcompass'
users = User.create([
  { name: 'Super User',
    email: 'su_admin@wild.compass',
    password: password,
    password_confirmation: password
  }
])
