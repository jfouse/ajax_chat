require 'rails_helper'

RSpec.describe "messages/show", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :user => nil,
      :ip => "Ip",
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Ip/)
    expect(rendered).to match(/MyText/)
  end
end
