class Gear
  # Make cog and chainring available ONCE
  attr_reader :chainring, :cog

  # Now we can refer to both of them
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * (rim + (tire * 2))
  end
end

puts Gear.new(52,11,26,1.5).gear_inches
puts Gear.new(52,11,24, 1.25).gear_inches