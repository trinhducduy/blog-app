require 'rails_helper'

RSpec.describe Post, type: :model do
  
  it "is valid with a content and a cover image" do
    post = build(:valid_post)
    expect(post).to be_valid
  end

  it "is invalid without a content" do
    post = build(:post_without_content)
    expect(post).to have(2).errors_on(:content)
  end

  it "is invalid without a cover image" do 
    post = build(:post_without_cover_image)
    expect(post).to have(1).errors_on(:cover_image)
  end

  it "is invalid with a content less than 100 characters" do
    post = build(:post_with_too_short_content)
    expect(post).to have(1).errors_on(:content)
  end
end
