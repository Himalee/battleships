require "messages"

describe Messages do
  it "returns initial welcome message" do
  messages = Messages.new
  expect(messages.welcome_message).to include("Battleships")
  end
end
