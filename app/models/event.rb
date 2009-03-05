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

  def loot_council_url
    characters = CGI::escape(registrations.accepted.map { |r| r.character.name }.join(" "))
    raid_name  = raid ? CGI::escape(raid.title) : ""
    
    "http://loot-council.appspot.com/lootcouncil?characters=#{characters}&realm=The+Forgotten+Coast&region=us&site=Wowhead&raid=#{raid_name}&difficulty=Normal"
  end

end
