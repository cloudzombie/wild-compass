class Inventory::ContainersController < InventoryController
  expose(:containers) { Container.all }
end