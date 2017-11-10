require 'rails_helper'

RSpec.describe "API_V1::Auth", :type => :request do
  before do
    @user = User.create!( :email => "test@example.com", :password => "12345678")
  end

  it "valid login" do
    post "/api/v1/login", params: { :auth_token => @user.authentication_token,
                                    :email => @user.email, :password => "12345678" }
  expect(response).to have_http_status(200)

  expect(response.body).to eq(
    {
      :message => "Ok",
      :auth_token => @user.authentication_token,
      :user_id => @user.id
    }.to_json
  )
  end

  it "invalid antu token login" do
    post "/api/v1/login", params: { :auth_token => @user.authentication_token,
                                    :email => @user.email, :password => "xxx" }

    expect(response).to have_http_status(401)
    expect(response.body).to eq(
      { :message => "Email or Password is wrong" }.to_json
    )
  end

end
