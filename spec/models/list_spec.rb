require 'rails_helper'

describe List do
  it 'should validate presence of name' do
    expect(List.new).to validate_presence_of :name
  end

  it 'should validate it belongs to a user' do
    expect(List.new).to belong_to :user
  end

  it 'should have many tasks' do
    expect(List.new).to have_many :tasks
  end
end
