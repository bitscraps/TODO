require 'rails_helper'

describe Task do
  it 'should belong to a list' do
    expect(Task.new).to belong_to :list
  end

  it 'should validate presence of a name' do
    expect(Task.new).to validate_presence_of :name
  end
end
