require 'spec_helper'

describe "Microposts" do
  
  before(:each) do
    integration_sign_in(Factory(:user))
  end
  
  describe "creation" do
    
    describe "failure" do      
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count).by(1)
      end
    end
    
    describe "success" do
      content = "Successful micropost!"
      it "should make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end      
    end
    
  end
  
end
