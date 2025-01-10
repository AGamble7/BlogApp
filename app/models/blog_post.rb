class BlogPost < ApplicationRecord
  validate :custom_validator
  def custom_validator
    if body == title
      errors.add(:title, "They can not be the same!")
    end
  end
end
