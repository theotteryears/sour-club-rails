class Beer < ApplicationRecord
  has_one_attached :image

  # Validations
  validates :name, :brewery, :design, :sourness, presence: true
  validates :design, :sourness, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  # Pagination
  paginates_per 9

  # Callbacks
  after_create_commit :broadcast_creation
  after_destroy_commit :broadcast_removal
  after_update_commit :broadcast_update

  private

  def broadcast_creation
    beer_with_attachment = Beer.includes(image_attachment: :blob).find(id)
    broadcast_prepend_to "beers",
                         target: "beer_grid > div",
                         partial: "beers/beer",
                         locals: { beer: beer_with_attachment }
  end

  def broadcast_removal
    broadcast_remove_to "beers"
  end

  def broadcast_update
    beer_with_attachment = Beer.includes(image_attachment: :blob).find(id)
    broadcast_replace_to "beers",
                         target: ActionView::RecordIdentifier.dom_id(self),
                         partial: "beers/beer",
                         locals: { beer: beer_with_attachment }
  end
end
