require 'pp'
class Museum

attr_reader :name, :exhibits, :patrons
  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end


  def recommend_exhibits(patron)
    recommended = @exhibits.select do |exhibit|
      exhibit if patron.interests.include?(exhibit.name)
    end
    recommended
  end

  def admit(patron)
    @patrons << patron
    # @exhibits.each do |exhibit|
    #   if patron.interests.include?(exhibit.name)
    #     patron.spending_money -= exhibit.cost
    #   end
    # end

  end

  def patrons_by_exhibit_interest
    pbei_hash = Hash.new{|h, k| h[k] = []}
    @exhibits.each do |exhibit|
      pbei_hash[exhibit] = @patrons.select do |patron|
        patron.interests.include?(exhibit.name)
      end
    end
    pbei_hash
  end

  def ticket_lottery_contestants(exhibit)
    @patrons.select do |patron|
      patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    contestant_names_array = []
    ticket_lottery_contestants(exhibit).each do |patron|
      contestant_names_array << patron.name
    end

    if contestant_names_array.length == 1
    return contestant_names_array[0]

    elsif contestant_names_array.length > 1
      return contestant_names_array.sample
    else
      nil
    end
  end

  def announce_lottery_winner(exhibit)
    if draw_lottery_winner(exhibit) == nil
      "No winners for this lottery"
    else
    "#{draw_lottery_winner(exhibit)} has won the #{exhibit.name} lottery"
    end
  end

  def patrons_of_exhibits
    p_o_e_hash = Hash.new { |h, k| h[k] = []}

    @exhibits.each do |exhibit|
      p_o_e_hash[exhibit] = @patrons.select do |patron|
      patron.interests.include?(exhibit.name) && patron.spending_money > exhibit.cost
      end
    end
    p_o_e_hash
  end

end

