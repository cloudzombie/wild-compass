class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value
  delegate :total_weight, :total_current_weight, :total_initial_weight
end