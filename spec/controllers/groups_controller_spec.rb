require 'rails_helper'
RSpec.describe "GroupsController",type: :request do

     before do
     	#here we use @ with user varna ye local var ban jata and hum group banate time isko access nahi kar pate
     	@user=User.create(name:"one",email:"one@gmail.com",password:"123456")
     	sign_in @user

     	
        
     end


	describe "GET /index" do
		it "renders index view and returns a successfull response" do
               get groups_path
			group=Group.create(name:"g1",user: @user) 
			expect(response).to have_http_status(:success)
			expect(response).to render_template(:index)
		     expect(assigns(:groups)).to eq([group])#beta see here we have square brackets because group is a collection
		end
	end


	describe "GET /part_of" do 
          it "renders part of view and returns succesfull rsponse"  do
               get part_of_path
          	expect(response).to have_http_status(:success)
          	expect(response).to render_template(:part_of)
          	other_user=User.create(name:"two",email:"two@gmail.com",password:"123456")
          	group1=Group.create(name:"g1",user: @user)
          	group2=Group.create(name:"g2", user: other_user)
          	Membership.create(user: @user,group: group1)
          	Membership.create(user: @user,group: group2)
          	Membership.create(user: other_user,group: group2)
          	# expect(assigns(:groups)).to include(group1,group2)---------------issue
              
          end
		
	end

	describe "GET /new" do
		it "renders new view and returns succesfull rsponse" do
			get new_group_path
			other_user=User.create(name:"j1",email:"j1@gmail.com",password:"123456")
			expect(response).to have_http_status(:success)
          	expect(response).to render_template(:new)
          	expect(assigns(:group)).to be_a_new(Group)
          	expect(assigns(:users).count).to eq(1)#because we dont want current user hence count is only 1 but we created 2 users
		end
	end

   
  describe "POST #create" do #-------------issue
   
      it "creates a new group, adds the current user and other members, and redirects to the groups list" do
        user2 = User.create(name:"test1",email:"test1@gmail.com",password:"123456")
        user3 = User.create(name:"test2",email:"test1@gmail.com",password:"123456")
        valid_params = { group: {name: "Test Group", user_ids: [user2.id, user3.id]}}
        expect { post :create, params: valid_params}
        group = Group.last
        expect(group.memberships.count).to eq(3)
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq('Group created successfully!')
      end
    end
	
	
end