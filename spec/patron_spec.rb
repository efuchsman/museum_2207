require 'rspec'
require './lib/exhibit'
require './lib/patron'

RSpec.describe Patron do
  it 'exists and has readable attributes' do
    patron_1 = Patron.new("Bob", 20)

    expect(patron_1).to be_an_instance_of(Patron)
    expect(patron_1.name).to eq("Bob")
    expect(patron_1.spending_money).to eq(20)

  end
end
