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

  it "can exhibits" do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    expect(dmns.exhibits).to eq([])

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])

  end

  it 'can recommend exhibits to patrons' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("IMAX")

    expect(dmns.recommend_exhibits(patron_1)).to eq([gems_and_minerals, dead_sea_scrolls])
    expect(dmns.recommend_exhibits(patron_2)).to eq([imax])

  end

  it "can admit patrons" do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])

  end

  it 'can lists patrons by exhibit interest' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.patrons_by_exhibit_interest).to eq(
      {
        gems_and_minerals => [patron_1],
        dead_sea_scrolls => [patron_1, patron_2, patron_3],
        imax => []

        }
      )

  end

  it 'creates a list of interested patron who do not have money and draws a winner' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 0)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])

    # allow(Museum).to receive(:draw_lottery_winner).and_return("Johnny"|| "Bob")
    expect(dmns.draw_lottery_winner(dead_sea_scrolls)).to eq("Johnny").or(eq("Bob"))

    expect(dmns.draw_lottery_winner(gems_and_minerals)).to be nil
    expect(dmns.draw_lottery_winner(imax)).to be nil

    # allow(Museum).to receive(:announce_lottery_winner).and_return("Johnny has won the Dead Sea Scrolls lottery" || "Bob has won the Dead Sea Scrolls lottery")
    expect(dmns.announce_lottery_winner(dead_sea_scrolls)).to eq("Johnny has won the Dead Sea Scrolls lottery").or(eq("Bob has won the Dead Sea Scrolls lottery"))

    expect(dmns.announce_lottery_winner(imax)).to eq("No winners for this lottery")
  end

 it "has patrons of an exhibit" do
  dmns = Museum.new("Denver Museum of Nature and Science")
  gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
  dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
  imax = Exhibit.new({name: "IMAX",cost: 15})
  patron_1 = Patron.new("Bob", 10)
  patron_2 = Patron.new("Sally", 20)
  morgan = Patron.new("Morgan", 15)
  tj = Patron.new("TJ", 7)

  dmns.add_exhibit(gems_and_minerals)
  dmns.add_exhibit(dead_sea_scrolls)
  dmns.add_exhibit(imax)

  tj.add_interest("IMAX")
  tj.add_interest("Dead Sea Scrolls")
  patron_1.add_interest("Dead Sea Scrolls")
  patron_1.add_interest("IMAX")
  patron_2.add_interest("IMAX")
  patron_2.add_interest("Dead Sea Scrolls")
  morgan.add_interest("Gems and Minerals")
  morgan.add_interest("Dead Sea Scrolls")


  dmns.admit(tj)
  dmns.admit(patron_1)
  dmns.admit(patron_2)
  dmns.admit(morgan)

  expect(dmns.patrons_of_exhibits).to eq(
    {
       dead_sea_scrolls => [patron_2, morgan],
       imax => [patron_2],
       gems_and_minerals => [morgan]
     }
    )

 end

end
