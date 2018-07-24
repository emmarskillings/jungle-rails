require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They can add items to cart" do

    #ACT
    visit root_path

    page.find_link("Add", :href => "/cart/add_item?product_id=1").trigger(:click)
    sleep 1

    # DEBUG / VERIFY
    # save_screenshot
    expect(page).to have_css 'article.product', count: 1

  end

end
