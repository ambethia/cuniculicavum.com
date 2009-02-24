class Event < ActiveRecord::Base
  belongs_to :raid
  
  def title
    if self[:title].blank?
      raid ? raid.title : "Untitled Event"
    else
      self[:title]
    end
  end
end
