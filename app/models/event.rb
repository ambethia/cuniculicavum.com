class Event < ActiveRecord::Base
  belongs_to :raid
  has_many :registrations
  
  def title
    if self[:title].blank?
      raid ? raid.title : "Untitled Event"
    else
      self[:title]
    end
  end
end
