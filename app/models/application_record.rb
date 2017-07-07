class ApplicationRecord < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  self.abstract_class = true
end
