require 'rails_helper'

RSpec.describe Post, :type => :model do
  it 'should validate presence of title' do
    post = Post.new
    post.valid?
    expect(post.errors.messages[:title]).to include "can't be blank"
  end
  
  it 'should validate presence of body' do
    post = Post.new
    post.valid?
    expect(post.errors.messages[:body]).to include "can't be blank"
  end
end
