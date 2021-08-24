10.times do |index|
  Category.create!(name: "Sub Category #{index + 10}",
                   description: "Description for category Sub #{index}",
                   parent_id: 1)
end

categories = Category.where.not(parent_id: 0)

categories.each_with_index do |category, index|
  category.products.create!(name: "Product #{index}",
                            content: "Content for product #{index}",
                            quantity: index + 10 ,
                            price: 100000 ,
                            category_id: category.id)
end

10.times do |index|
    User.create!(email: "user#{index}@gmail.com",
                 password: "111111",
                 password_confirmation: "111111",
                 fullname: "User #{index}",
                 address: "Da Nang #{index}",
                 phone: "1100000#{index}")

    Comment.create!(content: "Content comment #{index}",
                    user_id: index + 1 ,
                    product_id: index + 1 ,
                    parent_id: index + 1)

    Order.create!(user_id: index + 1)

    OrderDetail.create!(order_id: index + 1 ,
                        product_id: index + 1 ,
                        quantity: index + 10)
end
