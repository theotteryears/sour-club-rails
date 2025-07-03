class Beer < ApplicationRecord
  has_one_attached :image

  after_create_commit -> {
  beer_with_attachment = Beer.includes(image_attachment: :blob).find(id)
  broadcast_prepend_to "beers", target: "beer_grid", partial: "beers/beer", locals: { beer: beer_with_attachment }
}
  after_destroy_commit -> { broadcast_remove_to "beers" }
end
