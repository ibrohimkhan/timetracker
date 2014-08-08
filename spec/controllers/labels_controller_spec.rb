require 'spec_helper'

describe LabelsController do

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:label) { FactoryGirl.create(:label) }
    subject { label }

    before do
      sign_in user
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{post :create, format: 'json', label: FactoryGirl.attributes_for(:label)}.to change(Label, :count).by(1)
        end

        it "responds with json" do
          post :create, format: 'json', label: FactoryGirl.attributes_for(:label)
          response.body.should have_json_type(String).at_path("name")
        end

        it "should have json type" do
          post :create, format: 'json', label: FactoryGirl.attributes_for(:label)
          label.to_json.should have_json_path("name")
          label.to_json.should have_json_type(String).at_path("name")
        end

        it "raises a parser error for invalid JSON" do
          post :create, format: 'json', label: FactoryGirl.attributes_for(:label)
          expect{ parse_json(label.name) }.to raise_error(MultiJson::DecodeError)
        end

      end
    end
  end

end
