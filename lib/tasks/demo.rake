namespace :demo do

  DEMO_STRAIN_NAME = 'DEMO-STRAIN'
  DEMO_STRAIN_ACRONYM = 'DM'

  DEMO_BRAND_NAME = 'DEMO-BRAND'
  DEMO_BRAND_DESCRIPTION = 'Demonstration brand'

  DEMO_CONTAINER_NAME = 'DEMO-CTN'

  DEMO_PLANT_NAME = 'DEMO-PLANT'

  DEMO_BIN_NAME = 'DEMO-BIN'

  DEMO_BAG_NAME = 'DEMO-BAG'

  DEMO_LOT_NAME = 'DEMO-LOT'

  desc "creates demo products"
  task create: :environment do
    
    strain = Strain.create(
      name: DEMO_STRAIN_NAME,
      acronym: DEMO_STRAIN_ACRONYM
    )

    brand = Brand.create(
      name: DEMO_BRAND_NAME,
      description: DEMO_BRAND_DESCRIPTION
    )

    plant = Plant.create(
      name: DEMO_PLANT_NAME,
      strain: strain
    )

    bin = Bin.create(
      name: DEMO_BIN_NAME
    )

    container = Container.create(
      name: DEMO_CONTAINER_NAME
    )
    
    bag = Bag.create(
      name: DEMO_BAG_NAME
    )
    
    lot = Lot.create(
      name: DEMO_LOT_NAME,
      bags: [ bag ],
      plants: [ plant ]
    )

  end

  desc "removes demo products"
  task remove: :environment do

    lot = Lot.find_by(name: DEMO_LOT_NAME)
    lot.delete

    bag = Bag.find_by(name: DEMO_BAG_NAME)
    bag.delete

    container = Container.find_by(name: DEMO_CONTAINER_NAME)
    container.delete

    bin = Bin.find_by(name: DEMO_BIN_NAME)
    bin.delete

    plant = Plant.find_by(name: DEMO_PLANT_NAME)
    plant.delete

    brand = Brand.find_by(name: DEMO_BRAND_NAME)
    brand.delete

    strain = Strain.find_by(name: DEMO_STRAIN_NAME)
    strain.delete

  end

end
