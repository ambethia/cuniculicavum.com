class Registration < ActiveRecord::Base
  belongs_to :character
  belongs_to :event
  
  named_scope :accepted, :conditions => { :status => "attending" }
  
  STATUS_COLORS = {
    "attending"     => "006600",
    "not_attending" => "660000",
    "stand_by"      => "666666"
  }
  
  def self.statuses
    ["attending", "not_attending", "stand_by"]
  end
end
