class User < ActiveRecord::Base
    has_many :workouts
    has_secure_password
    validates_uniqueness_of :username, :case_sensitive => false
    
end