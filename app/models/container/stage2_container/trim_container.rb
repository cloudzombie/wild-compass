class Container::Stage2Container::TrimContainer < Container::Stage2Container

  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  
  scope :by_categories, -> (category = nil) { where(category: category).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { none }
  
  scope :by_brands,     -> (brand = nil) { Container.joins(:strains).merge(Strain.where(brand: brand)).uniq }

end