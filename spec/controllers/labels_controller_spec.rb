require 'spec_helper'

describe LabelsController do

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:label) { Factory.create(:label) }
    subject { label }

    before do
      sign_in user
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          #json = { :format => 'json', :application => { label: { :name => "foo" } } }
          #post :create, json
          #expect{post :create, {label: {name: 'hi'}}}.to change(Label, :count).by(1)
        end
      end
    end
  end

end
