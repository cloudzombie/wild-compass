class Inventory::JarsController < InventoryController
  expose(:jars) { Jar.all }
end