require File.dirname(__FILE__) + '/../spec_helper'

describe Topic do

  before(:each) do
    @topic = stub_model(Topic, :subject => "Subject")
  end

  describe "#mail_subject" do

    it "should be regarding the topic's subject" do
      @topic.mail_subject.should == "[Cuniculi Cavum] Subject"
    end

  end

end
