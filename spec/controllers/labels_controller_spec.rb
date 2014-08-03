require 'spec_helper'

describe LabelsController do

	context "when user not logged in" do
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:label) }

    before do
      sign_in user
    end

    describe "GET #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns the requested label to subject" do
        get :index
        expect(assigns(:labels)).to eq([subject])
      end
    end

    describe "GET #show" do
      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end

      it "assigns the requested label to subject" do
        get :show, id: subject
        expect(assigns(:label)).to eq(subject)
       end 
    end

    describe "GET #new" do
      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end

      it "assigns the requested label to new label" do
        get :new
        expect(assigns(:label)).to be_new_record
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{post :create, label: FactoryGirl.attributes_for(:label)}.to change(Label, :count).by(1)
        end

        it "redirects to index path" do
          post :create, label: FactoryGirl.attributes_for(:label)
          expect(response).to redirect_to labels_path
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested label to subject" do
        get :edit, id: subject
        expect(assigns(:label)).to eq(subject)
      end

      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{ patch :update, id: subject, label: { name: 'new_label' } }.to change{ subject.reload.name }.to('new_label')
        end

        it "redirects to index path" do
          patch :update, id: subject, label: { name: 'new_label' }
          expect(response).to redirect_to labels_path
        end
      end
    end

    describe "DELETE #destroy" do
      before(:each) { @label = FactoryGirl.create :label }

      it "deletes the label" do
        expect{ delete :destroy, id: @label }.to change(Label, :count).by(-1)
      end

      it "redirects to labels#index" do
        delete :destroy, id: @label
        expect(response).to redirect_to labels_path
      end
    end

  end
end
