require "console"

describe Console do
  it "displays hello" do
    output = StringIO.new
    console = Console.new(output)
    console.present("hello")
    expect(output.string).to eql("hello\n")
  end

  it "returns hello, given hello" do
    output = StringIO.new
    input = StringIO.new("hello")
    console = Console.new(output, input)
    expect(console.receive).to eql("hello")
  end
end
