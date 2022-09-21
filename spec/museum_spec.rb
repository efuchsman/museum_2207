require 'rspec'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

RSpec.describe Museum do
  it "exists and has readable attributes" do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns).to be_an_instance_of(Museum)
    expect(dmns.name).to eq("Denver Museum of Nature and Science")
  end

end
