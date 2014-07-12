class Post < ActiveRecord::Base
  validate :title, :body, presence: true
end
