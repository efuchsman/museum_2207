require 'rspec'
require './lib/exhibit'

RSpec.describe Exhibit do
  it 'exists and has readable attributes' do
    exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})

    expect(exhibit).to be_an_instance_of Exhibit
    expect(exhibit.name).to eq("Gems and Minerals")
    expect(exhibit.cost).to eq(0)

  end
end
