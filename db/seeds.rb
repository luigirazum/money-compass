# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
def icon_link(icon)
  "https://fakeimg.pl/160x160/252f3f,255/f29800,255/?font=roboto&text=#{icon}"
end

def user_categories(uname)
  (0..10).to_a.sample(rand(uname.size) + rand(5)).sample
end

def cat_payments(cat_count)
  (0..10).to_a.sample(rand(cat_count) + rand(5)).sample
end

%w[Kevin Marco Kyle].each do |uname|
  User.create!(name: uname, email: "#{uname}@me.com", password: 'pwd1234')
end

User.all.each do |u|
  total_categories = user_categories(u.name)
  next unless total_categories
  total_categories.times do |n|
    cat = u.categories.create!(name: "Category ##{n + 1}", icon: icon_link("Cat+#{n + 1}"))
    total_payments = cat_payments(n + 1)
    next unless total_payments
    total_payments.times do |t|
      cat.payments.create!(name: "Payment ##{t + 1} for Category ##{n + 1}", amount: 1.0)
    end
  end
end
