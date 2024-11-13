require 'rails_helper'
RSpec.describe "UsersController",type: :request do

     before do
     	user=User.create(name:"one",email:"one@gmail.com",password:"123456")
     	sign_in user
     end


	describe "GET /profile" do
	it "renders profile view and give successfull response" do 
      get user_profile_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:profile)
		end
	end
end