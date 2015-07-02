require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end

    it "should have correct title" do
      visit static_pages_home_path
      expect(page).to have_title "Home | Ruby on Rails Tutorial Sample App"
    end
  end

  describe "GET #help" do

    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end

    it "should have correct title" do
      visit static_pages_help_path
      expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
    end
  end

end
