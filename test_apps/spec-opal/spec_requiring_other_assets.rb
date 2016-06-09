require 'coffee_greeter'

CoffeeGreeter = Native(`window.CoffeeGreeter`)

describe CoffeeGreeter do
  it 'greets offering coffee' do
    coffee_greeter = `new CoffeeGreeter('Mario')`
    expect(`coffee_greeter.greet()`).to eq("Hello Mario! Want some coffee?")
  end
end
