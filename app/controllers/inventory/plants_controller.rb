class Inventory::PlantsController < InventoryController
  expose(:plants) { Plant.all }
end