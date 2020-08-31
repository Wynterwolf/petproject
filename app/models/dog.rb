class Dog < ActiveRecord::Base
    belongs_to :foster, class_name: "User"

    validates :name, presence: true
    validates :breed, presence: true
    validates :age, presence: true
end
