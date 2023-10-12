require 'rails_helper'

<<<<<<< HEAD
RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      username: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[username]"
    end
  end
=======
RSpec.describe "users/edit.html.erb", type: :view do
  pending "add some examples to (or delete) #{__FILE__}"
>>>>>>> editTest
end
