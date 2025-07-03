class Beer < ApplicationRecord
  has_one_attached :image

  after_create_commit -> {
  beer_with_attachment = Beer.includes(image_attachment: :blob).find(id)

  image_url = Rails.application.routes.url_helpers.rails_blob_url(
    beer_with_attachment.image,
    host: Rails.application.routes.default_url_options[:host],
    protocol: Rails.application.routes.default_url_options[:protocol]
  )

  broadcast_prepend_to "beers",
    target: "beer_grid",
    partial: "beers/beer",
    locals: { beer: beer_with_attachment, image_url: image_url }
}
  after_destroy_commit -> { broadcast_remove_to "beers" }
end
