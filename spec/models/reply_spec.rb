require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Reply do

  before(:each) do
    @topic = stub_model(Topic, :subject => "Subject")
    @reply = stub_model(Reply, :topic => @topic)
  end

  describe "#mail_subject" do

    it "should be regarding the topic's subject" do
      @reply.mail_subject.should == "Re: [Cuniculi Cavum] Subject"
    end

  end

end
