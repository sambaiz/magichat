require 'rails_helper'

RSpec.describe WorldController, :type => :controller do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with existing user :name' do
      it 'flash existing name alert' do
        user = create(:user)
        post :create, user: attributes_for(:user, name: user.name)
        expect(flash[:alert]).to include("Name has already been taken")
      end

      it 'redirects to root_url' do
        user = create(:user)
        post :create, user: attributes_for(:user, name: user.name)
        expect(response).to redirect_to root_url
      end
    end

    context 'with not existing user :name' do
      before :each do
        @attr_user = attributes_for(:user)
      end

      it 'saves the new world in   the database' do
        expect{
          post :create, user: @attr_user
        }.to change(World, :count).by(1)
      end

      it 'saves the new user in the database' do
        expect{
          post :create, user: @attr_user
        }.to change(User, :count).by(1)
      end

      it 'adds a user to created world' do
        post :create, user: @attr_user
        expect(assigns(:user).world).to eq assigns(:world)
      end

      it 'sets a user id to session' do
        post :create, user: @attr_user
        expect(session[:user_id].values).to include assigns(:user).id
      end

      it 'redirects to chat_url' do
        post :create, user: @attr_user
        expect(response).to redirect_to chat_url(assigns(:world).code)
      end
    end

    context 'with user :name is blank' do
      it 'flash existing name alert' do
        post :create, user: attributes_for(:user, name: "")
        expect(flash[:alert]).to include("Name can't be blank")
      end

      it 'redirects to root_url' do
        user = create(:user)
        post :create, user: attributes_for(:user, name: user.name)
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #show' do
    context 'with existing world :code' do
      before :each do
        user = create(:user)
        session[:user_id] = {user.world.code => user.id}
        @world = user.world
      end
      context 'with session user belongs to the world' do
        it 'assigns the session user to @user' do
          get :show, code: @world.code
          expect(assigns(:user).id).to eq User.where(id: session[:user_id][@world.code]).first.id
        end

        it 'assigns the requested world to @world' do
          get :show, code: @world.code
          expect(assigns(:world)).to eq @world
        end

        it 'renders the :show template' do
          get :show, code: @world.code
          expect(response).to render_template :show
        end
      end

      context 'with session user not belongs to the world' do
        before :each do
          user = create(:user)
          session[:user_id][user.world.code] = user.id
          @world = create(:world)
        end

        it 'redirects to root_url' do
          get :show, code: @world.code
          expect(response).to redirect_to root_url
        end
      end
    end

    context 'with not existing world :code' do
      it 'redirects to root_url' do
        get :show, code: World.new.new_code
        expect(response).to redirect_to root_url
      end
    end
  end
end
