#invalid to kaise bhi invalid hoga hi but valid k case m sare preapplied validation k dhyan rakha karo,also invalid k case m dhyan rakho ki kahi valid n likhdo..!!all in all we cant fool test case 


require 'rails_helper'

RSpec.describe User, type: :model do 
	
	it "is valid with a name and email and password" do 
		user=User.new(name: "Meenu",email: "meenu@gmail.com",password:"123456")
		expect(user).to be_valid
	end
	
	it "is invalid without a name" do 
        user=User.new(name: nil)
	    expect(user).to_not be_valid
	end

	before do
     User.create(name:"one",email:"one@gmail.com",password:"123456")
    end	

    it "is invalid with a duplicate email"  do
      user=User.new(name:"one",email:"one@gmail.com",password:"123456")
       expect(user).to_not be_valid
    end

    it "is valid without a duplicate email" do
    	user=User.new(name:"one",email:"two@gmail.com",password:"123456")
    	expect(user).to be_valid
    end
    	
    it "can have many groups" do
     user=User.create(name:"Papa",email:"papa@mail.com",password:"123456")
     group1=Group.create(name:"g1",user:user)
     group2=Group.create(name:"g2",user:user)
     expect(user.groups).to include(group1,group2)
    end

    it "is invalid if password is less than 6" do
     user=User.new(name:"mummy",email:"mummy@gmail.com",password:"12345")
      expect(user).to_not be_valid
    end   

    it "can have many memberships" do 
      user=User.create(name:"didi",email:"didi@gmail.com",password:"123456")
      user1=User.create(name:"didi1",email:"didi1@gmail.com",password:"123456")
      group1=Group.create(name:"g1",user:user)
      group2=Group.create(name:"g2",user:user1)
      membership1=Membership.create(user:user,group:group1)
      membership2=Membership.create(user:user,group:group2)
      expect(user.memberships).to include(membership1,membership2)
    end

    it "can have many groups through memberships"  do
      user=User.create(name:"meenu",email:"meenu@gmail.com",password:"123456")
      user1=User.create(name:"meenu1",email:"meenu1@gmail.com",password:"123456")
      group1=Group.new(name:"g1",user:user)
      group2=Group.new(name:"g2",user:user1)
      Membership.create(user:user,group:group1)
      Membership.create(user:user,group:group2)
      expect(user.group_memberships).to include(group1,group2)
    end

    it "can have many expense_spits" do
     user=User.create(name:"meenu2",email:"meenu2@gmail.com",password:"123456")  
     grp=Group.new(name:"g1",user:user)
     exp1=Expense.new(name:"exp1",amount:100,group:grp,date:Date.today,user_id:1)
     exp2=Expense.new(name:"exp2",amount:200,group:grp,date:Date.today,user_id:2)  
     es1=ExpenseSplit.create(user:user,expense:exp1,amount:1000)
     es2=ExpenseSplit.create(user:user,expense:exp2,amount:2000)
     expect(user.expense_splits).to include(es1,es2)
     end
end