class Character < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :character_class
  validates_presence_of :user_id

  # Crudely converted from WoW UI Source
  CLASS_COLORS = {
   "hunter"       =>"abd473",
   "druid"        =>"ff7c0a",
   "warrior"      =>"c79c6e",
   "shaman"       =>"2459ff",
   "rogue"        =>"fff569",
   "death_knight" =>"c41f3b",
   "paladin"      =>"f58cba",
   "mage"         =>"69ccf0",
   "warlock"      =>"9482c9",
   "priest"       =>"ffffff"
  }

  def self.classes
    CLASS_COLORS.keys.sort
  end
  
  def class_color
    "\##{CLASS_COLORS[character_class]}"
  end

  def armory_url
    "http://www.wowarmory.com/character-sheet.xml?r=The+Forgotten+Coast&n=#{CGI::escape(name)}"
  end

end
