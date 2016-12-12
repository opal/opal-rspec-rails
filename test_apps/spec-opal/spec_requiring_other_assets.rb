require 'js'
require 'coffee_greeter'

CoffeeGreeter = `window.CoffeeGreeter`

describe CoffeeGreeter do
  it 'greets offering coffee' do
    expect(JS::new(CoffeeGreeter, 'Mario').JS.greet).to eq("Hello Mario! Want some coffee?")
  end
end
