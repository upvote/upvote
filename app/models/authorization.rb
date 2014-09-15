class Authorization < ActiveRecord::Base
  serialize :meta, JSON
end
