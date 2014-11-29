require 'rails_helper'

RSpec.describe WorldController, :type => :controller do
  describe 'GET #show' do
    context 'with existing world :code' do
      it 'assigns the requested world to @world' do
        world = create(:world)
        get :show, code: world.code
        expect(assigns(:world)).to eq world
      end

      it 'renders the :show template' do
        world = create(:world)
        get :show, code: world.code
        expect(response).to render_template :show
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
