require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :user => nil,
      :ip => "MyString",
      :text => "MyText"
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "input#message_user_id[name=?]", "message[user_id]"

      assert_select "input#message_ip[name=?]", "message[ip]"

      assert_select "textarea#message_text[name=?]", "message[text]"
    end
  end
end
