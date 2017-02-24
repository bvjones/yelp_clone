class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # def build_review(review_params, current_user)
  #   review = reviews.new(review_params)
  #   review.user = current_user
  #   review
  # end

  has_many :reviews do
    def build_with_user(attributes = {}, user)
      attributes[:user] ||= user
      build(attributes)
    end
  end
end
