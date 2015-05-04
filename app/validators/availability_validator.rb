class AvailabilityValidator < ActiveModel::Validator
  def validate(record)
    unless record.brand.available?
      record.errors[:brand] << "#{record.brand} is unavailable."
    end
  end
end
