require 'spec_helper'

describe TasksController do
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
    let(:assignment) { FactoryGirl.create(:assignment) }
    subject { FactoryGirl.create(:task) }

    before do
      sign_in user
      assignment.task = subject
      assignment.user = user
      assignment.save
    end

    describe "GET #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns the requested task to subject" do
        get :index
        expect(user.tasks).to include(subject)
      end
    end

    describe "GET #show" do
      it "assigns the requested task to subject" do
        get :show, id: subject
        expect(assigns(:task)).to eq(subject)
       end

      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns the requested task to new task" do
        get :new
        expect(assigns(:task)).to be_new_record
      end

      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{post :create, task: FactoryGirl.attributes_for(:task)}.to change(Task, :count).by(1)
        end

        it "redirects to index path" do
          post :create, task: FactoryGirl.attributes_for(:task)
          expect(response).to redirect_to tasks_path
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested task to subject" do
        get :edit, id: subject
        expect(assigns(:task)).to eq(subject)
      end

      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{ patch :update, id: subject, task: { name: 'new_task' } }.to change{ subject.reload.name }.to('new_task')
        end

        it "redirects to index path" do
          patch :update, id: subject, task: { name: 'new_task' }
          expect(response).to redirect_to tasks_path
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the task" do
        expect{ delete :destroy, id: subject }.to change(Task, :count).by(-1)
      end

      it "redirects to tasks#index" do
        delete :destroy, id: subject
        expect(response).to redirect_to tasks_path
      end
    end

  end
end
