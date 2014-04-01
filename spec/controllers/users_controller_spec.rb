require 'spec_helper'

describe UsersController do
  describe 'POST #create' do
    before :each do
      @analytics = double 'analytics'
      controller.analytics = @analytics

      allow(@analytics).to receive(:identify)
    end

    context 'with valid params' do
      it 'creates a user' do
        expect {
          post :create, mailing_email: attributes_for(:user)[:email]
        }.to change(User, :count).by 1
      end
      it 'identifies the user' do
        expect(@analytics).to receive(:identify) do |object|
          last_user = User.last
          object[:user_id].should == last_user.id
          object[:traits][:email].should == last_user.email
          object[:traits][:created_at].to_i.should == last_user.created_at.to_i
        end
        post :create, mailing_email: attributes_for(:user)[:email]
      end
      it 'redirects to the home page' do
        post :create, mailing_email: attributes_for(:user)[:email]
        page.should redirect_to root_path
        flash[:notice].should == 'You have been signed up for the mailing list.'
      end
    end

    context 'with invalid params' do
      context 'with existing email' do
        before :each do
          @user = create(:user)
          @email = @user.email
        end
        it 'redirects to home with an error' do
          post :create, mailing_email: @email
          page.should redirect_to root_path
          flash[:error].should == 'You are already signed up for the mailing list.'
        end
        it 'does not create a user' do
          expect {
            post :create, mailing_email: @email
          }.to_not change(User, :count)
        end
        it 'identifies the user' do
          expect(@analytics).to receive(:identify) do |object|
            object[:user_id].should == @user.id
            object[:traits][:email].should == @user.email
            object[:traits][:created_at].to_i.should == @user.created_at.to_i
          end
          post :create, mailing_email: @email
        end
      end
      context 'with invalid email' do
        before :each do
          @email = 'something_invalid'
        end

        it 'redirects to home' do
          post :create, mailing_email: @email
          page.should redirect_to root_path
          flash[:error].should == 'Please enter a valid email.'
        end

        it 'does not create a user' do
          expect {
            post :create, mailing_email: @email
          }.to_not change(User, :count)
        end

        it 'does not identify the user' do
          expect(@analytics).to_not receive(:identify)
          post :create, mailing_email: @email
        end
      end
    end
  end
end