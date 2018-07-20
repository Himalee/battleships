require "message"

describe Message do
  it "returns initial welcome message" do
  message = Message.new
  expect(message.welcome_message).to include("Battleships")
  end
end
