require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :user => nil,
      :ip => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "input#message_user_id[name=?]", "message[user_id]"

      assert_select "input#message_ip[name=?]", "message[ip]"

      assert_select "textarea#message_text[name=?]", "message[text]"
    end
  end
end
