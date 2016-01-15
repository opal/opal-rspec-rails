require 'coffee_greeter'

CoffeeGreeter = Native(`window.CoffeeGreeter`)

describe CoffeeGreeter do
  it 'greets offering coffee' do
    expect(CoffeeGreeter.new('Mario').greet).to eq("Hello Mario! Want some coffee?")
  end
end
