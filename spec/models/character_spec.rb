require File.dirname(__FILE__) + '/../spec_helper'

describe Character do

  describe "Armory Links" do
    it "should html escape the character name" do
      character = Character.new(:name => "Øpßurñs")
      character.armory_url.should == "http://www.wowarmory.com/character-sheet.xml?r=The+Forgotten+Coast&n=%C3%98p%C3%9Fur%C3%B1s"
    end
  end

end
