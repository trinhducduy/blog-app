namespace :generate do
  desc "Generate slugs for needed model"
  task slugs: :environment do
    User.find_each(&:save)
    Post.find_each(&:save)
    Tag.find_each(&:save)
  end

end
