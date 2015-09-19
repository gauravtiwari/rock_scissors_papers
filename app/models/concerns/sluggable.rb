module Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_candidates

    def should_generate_new_friendly_id?
      slug.blank? || name_changed?
    end

    #Slug attributes for friendly id
    def slug_candidates
      [:name]
    end
  end

end