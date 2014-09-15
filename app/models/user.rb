class User < ActiveRecord::Base
  devise :trackable, :omniauthable
end
