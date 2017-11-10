require "rails_helper"
RSpec.describe MeetupsController, type: :controller do
  describe "GET index" do
    it "assigns @meetups and render template" do
      user = User.create!( :email => "test@example.com", :password => "12345678")
      meetup1 = Meetup.create!(title: "foo", description: "bar", user_id: user.id)
      meetup2 = Meetup.create!(title: "bar", description: "foo", user_id: user.id)

      sign_in user
      get :index
      expect(assigns[:meetups]).to eq([meetup1, meetup2])
      expect(response).to render_template("index")
    end
  end
end
