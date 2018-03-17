require 'rails_helper'

RSpec.describe TownsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      town = FactoryBot.create(:town)
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      town = FactoryBot.create(:town)
      get :show, id: town.to_param
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, {}
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      town = FactoryBot.create(:town)
      get :edit, id: town.to_param
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Town' do
        expect do
          post :create, town: FactoryBot.build(:town).attributes
        end.to change(Town, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'render form' do
        post :create, town: FactoryBot.build(:town).attributes.except('name')
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested town' do
        town = FactoryBot.create(:town)
        put :update, id: town.to_param, town: town.attributes
        town.reload
      end
    end

    context 'with invalid params' do
      it 'render form' do
        town = FactoryBot.create(:town)
        town.name = 'Town that does not exist'
        put :update, id: town.to_param, town: town.attributes
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested town' do
      town = FactoryBot.create(:town)
      expect do
        delete :destroy, id: town.to_param
      end.to change(Town, :count).by(-1)
    end
  end
end
