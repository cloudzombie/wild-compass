# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

statuses = Status.create([
  { name: 'harvest'   },
  { name: 'drying'    },
  { name: 'curing'    },
  { name: 'growing'   },
  { name: 'destroyed' }
])

brands = Brand.create([
  { name: "Good Morning" },
  { name: "Midday"       },
  { name: "After Dinner" },
  { name: "Bedtime"      }
])

formats = Format.create([
  { name: "60 G"     },
  { name: "45 G"	   },
  { name: "15 G"	   },
  { name: " 6 L"     }
])

strains = Strain.create([
  { name: "Big Blue Bubble Buds", acronym: "BB"  },
  { name: "Yo Diamond", acronym: "YO"	 	},
  { name: "Good Meds", acronym: "GM"	 	},
  { name: "Snow Leopard", acronym: "SL"     },
  { name: "Mk", acronym: "MK"  },
  { name: "Casey x Ww" , acronym: "CXWW"   },
  { name: "Space Queen", acronym: "SQ"   },
  { name: "Critical Cheese", acronym: "CC"     },
  { name: "Norther Lights 5", acronym: "NLXBB" },
  { name: "(Pmayi)", acronym: "PM"   },
  { name: "(Krona x Norther California", acronym: "KS"     },
  { name: "(Cambodian x Mes Gold x Lumbo Gold x Thai x Maui)", acronym: "PG"  },
  { name: "Socal Master Kush", acronym: "SC"   },
  { name: "Prayer Tower", acronym: "PT"   },
  { name: "Shark Shock", acronym: "SS"     },
])

user_roles = User::Role.create([{ admin: false, manager: false, name: 'user'       },
                                { admin: false, manager: true,  name: 'manager'    },
                                { admin: true,  manager: false, name: 'admin'      },
                                { admin: true,  manager: true,  name: 'super_user' }])

user_group_roles = User::Group::Role.create([{ admin: false, manager: false, name: 'users'       },
                                             { admin: false, manager: true,  name: 'managers'    },
                                             { admin: true,  manager: false, name: 'admins'      },
                                             { admin: true,  manager: true,  name: 'super_users' }])

user_groups = User::Group.create([{ role: User::Group::Role.users,       name: 'users'       },
                                  { role: User::Group::Role.managers,    name: 'managers'    },
                                  { role: User::Group::Role.admins,      name: 'admins'      },
                                  { role: User::Group::Role.super_users, name: 'super_users' }])

users = User.create([{ name: 'Super User',
                       email: email = 'su_admin@wild.compass',
                       uid: email,
                       provider: :email,
                       password: password = 'wildcompass',
                       password_confirmation: password,
                       role: User::Role.super_user,
                       group: User::Group.super_users }])
