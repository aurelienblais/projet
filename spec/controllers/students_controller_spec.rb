require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      student = FactoryBot.create(:student)
      get :index, {}
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
      student = FactoryBot.create(:student)
      get :edit, id: student.to_param
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Student' do
        expect do
          post :create, student: FactoryBot.build(:student).attributes
        end.to change(Student, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'render form' do
        post :create, student: FactoryBot.build(:student).attributes.except('lastname')
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested student' do
        student = FactoryBot.create(:student)
        put :update, id: student.to_param, student: student.attributes
        student.reload
      end
    end

    context 'with invalid params' do
      it 'render form' do
        student          = FactoryBot.create(:student)
        student.lastname = nil
        put :update, id: student.to_param, student: student.attributes
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested student' do
      student = FactoryBot.create(:student)
      expect do
        delete :destroy, id: student.to_param
      end.to change(Student, :count).by(-1)
    end

    it "can't delete student" do
      expect do
        delete :destroy, id: 0
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the students list' do
      student = FactoryBot.create(:student)
      delete :destroy, id: student.to_param
      expect(response).to redirect_to(students_url)
    end
  end
end
