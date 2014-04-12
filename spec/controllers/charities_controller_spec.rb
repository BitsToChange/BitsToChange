require 'spec_helper'

describe CharitiesController do
  describe 'GET #index' do
    it 'populates an array of charities' do
      charity = create :charity
      get :index
      assigns(:charities).should == [charity]
    end

    it 'renders the :index template' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested charity to @charity' do
      charity = create :charity
      get :show, id: charity
      assigns(:charity).should == charity
    end
    it 'renders the :show template' do
      get :show, id: create(:charity)
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it_has_behavior 'redirects when not logged in', route: :new, role: Constants::Roles::CHARITY_ADMINISTRATOR
    context 'logged in as a charity administrator' do
      before :each do
        login_as Constants::Roles::CHARITY_ADMINISTRATOR
      end
      it 'assigns a new charity to @charity' do
        get :new
        assigns(:charity).should be_a_kind_of Charity
      end
      it 'renders the :new template' do
        get :new
        response.should render_template :new
      end
    end
  end
  describe 'POST #create' do
    it_has_behavior 'redirects when not logged in', method: :post, route: :create, params: {charity: FactoryGirl.attributes_for(:charity)}, role: Constants::Roles::CHARITY_ADMINISTRATOR
    context 'logged in as a charity administrator' do
      before :each do
        login_as Constants::Roles::CHARITY_ADMINISTRATOR
      end
      context 'with valid attributes' do
        it 'creates a charity' do
          expect {
            post :create, charity: attributes_for(:charity)
          }.to change(Charity, :count).by 1
        end
        it 'redirects to the charity' do
          post :create, charity: attributes_for(:charity)
          response.should redirect_to Charity.last
        end
      end
      context 'with invalid attributes' do
        it 'does not save the charity' do
          expect {
            post :create, charity: attributes_for(:invalid_charity)
          }.to_not change(Charity, :count)
        end
        it 're-renders the new method' do
          post :create, charity: attributes_for(:invalid_charity)
          response.should render_template :new
        end
      end
    end
  end
  describe 'PUT #update' do
    # TODO: Find a way to test redirection with PUTs
    # problem is we cannot create an object when the test runs, but we need an object for redirects to happen
    #it_has_behavior 'redirects when not logged in', method: :put, route: :update, params: {id: 0, charity: {}}, role: Constants::Roles::CHARITY_ADMINISTRATOR
    context 'logged in as a charity administrator' do
      before :each do
        login_as Constants::Roles::CHARITY_ADMINISTRATOR
        @charity = create :charity
      end
      context 'with valid attributes' do
        it 'located the charity' do
          put :update, id: @charity, charity: attributes_for(:charity)
          assigns(:charity).should == @charity
        end
        it 'updates the charity\'s attributes' do
          put :update, id: @charity,
              charity: attributes_for(:charity, name: 'Cool', description: 'Alright', website: 'http://coolalright.com')
          @charity.reload
          @charity.name.should == 'Cool'
          @charity.description.should == 'Alright'
          @charity.website.should == 'http://coolalright.com'
        end
        it 'redirects to the updated charity' do
          put :update, id: @charity, charity: attributes_for(:charity)
          response.should redirect_to @charity
        end
      end
      context 'with invalid attributes' do
        it 'locates the requested @charity' do
          put :update, id: @charity, charity: attributes_for(:invalid_charity)
          assigns(:charity).should eq(@charity)
        end
        it 'does not change @charity\'s attributes' do
          old_description = @charity.description
          put :update, id: @charity, charity: attributes_for(:charity, name: 'Charity', description: nil)
          @charity.reload
          @charity.name.should_not eq('Charity')
          @charity.description.should eq(old_description)
        end
        it 're-renders the edit method' do
          put :update, id: @charity, charity: attributes_for(:invalid_charity)
          response.should render_template :edit
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    # TODO: Test redirects, no good way, see PUT #update
    context 'logged in as charity administrator' do
      before :each do
        login_as Constants::Roles::CHARITY_ADMINISTRATOR
        @charity = create :charity
      end
      it 'deletes the charity' do
        expect {
          delete :destroy, id: @charity
        }.to change(Charity, :count).by -1
      end
      it 'redirects to the index page' do
        delete :destroy, id: @charity
        response.should redirect_to charities_path
      end
    end
  end
  describe 'POST #generate_wallet' do
    # TODO: test redirects
    context 'logged in as a charity administrator' do
      before :each do
        login_as Constants::Roles::CHARITY_ADMINISTRATOR
        @charity = create(:charity)
        @wallet = create(:wallet)
        @wallet_generator = double 'WalletGenerator'
        controller.wallet_generator = @wallet_generator
      end
      context 'with no wallet' do
        it 'calls #wallet_for_charity on it\'s wallet generator' do
          expect(@wallet_generator).to receive(:wallet_for_charity).with(@charity) { @wallet }
          post :generate_wallet, id: @charity
        end
        it 'attaches the created wallet to the charity' do
          @wallet_generator.stub(:wallet_for_charity) { @wallet }
          post :generate_wallet, id: @charity
          @charity.wallets.last.should == @wallet
        end
      end
      context 'with a wallet' do
        before :each do
          @charity.wallets << @wallet
        end
        it 'redirects to charity\'s path with an error' do
          post :generate_wallet, id: @charity
          response.should redirect_to @charity
          flash[:error].should == 'That charity already has a wallet.'
        end
        it 'does not add the wallet' do
          post :generate_wallet, id: @charity
          @charity.wallets.length.should == 1
        end
      end
    end
  end
end

def login_as(role)
  session[:userid] = create(:user, roles: [create(:role, name: role)])
end