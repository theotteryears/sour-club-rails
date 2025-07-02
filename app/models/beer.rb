class Beer < ApplicationRecord
  has_one_attached :image

  after_create_commit -> { broadcast_append_to "beers", target: "beer_list", partial: "beers/beer", locals: { beer: self } }
  after_destroy_commit -> { broadcast_remove_to "beers" }
end
