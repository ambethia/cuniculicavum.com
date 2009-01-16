require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Notification do

  describe ".topic_key" do

    it "should find the topic id from the address" do
      Notification.topic_key("topic-123@example.com").should == 123
    end

    it "should not find an id for other addresses" do
      Notification.topic_key("postmaster@example.com").should be_nil
    end

  end

  describe "#receive" do

    before(:each) do
      @email = File.open(fixture_path + "/emails/simple.email").read
      @topic = stub_model(Topic)
      @user  = stub_model(User)

      User.stub!(:find_by_email).and_return(@user)
      Topic.stub!(:find_by_id).and_return(@topic)
    end

    it "should find the author" do
      User.should_receive(:find_by_email).with("jasper@example.com")
      Notification.receive(@email)
    end

    it "should find the topic" do
      Topic.should_receive(:find_by_id).with(1)
      Notification.receive(@email)
    end

    it "should create a reply from a simple" do
      Reply.should_receive(:create).with(
        :topic  => @topic,
        :author => @user,
        :body   => "A reply to your message."
      )
      Notification.receive(@email)
    end

    it "should create a reply with the first part in a multipart message" do
      Reply.should_receive(:create).with(
        :topic  => @topic,
        :author => @user,
        :body   => "The quick brown fox jumps over the lazy dog"
      )
      Notification.receive(File.open(fixture_path + "/emails/multipart.email").read)
    end

    it "should not include the quoted text in a reply" do
      Reply.should_receive(:create).with(
        :topic  => @topic,
        :author => @user,
        :body   => "I am replying."
      )
      Notification.receive(File.open(fixture_path + "/emails/reply.email").read)
    end

  end

end
