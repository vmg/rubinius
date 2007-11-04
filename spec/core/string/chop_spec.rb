require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes.rb'

describe "String#chop" do
  it "returns a new string with the last character removed" do
    "hello\n".chop.should == "hello"
    "hello\x00".chop.should == "hello"
    "hello".chop.should == "hell"
    
    ori_str = ""
    256.times { |i| ori_str << i }
    
    str = ori_str
    256.times do |i|
      str = str.chop
      str.should == ori_str[0, 255 - i]
    end
  end
  
  it "removes both characters if the string ends with \\r\\n" do
    "hello\r\n".chop.should == "hello"
    "hello\r\n\r\n".chop.should == "hello\r\n"
    "hello\n\r".chop.should == "hello\n"
    "hello\n\n".chop.should == "hello\n"
    "hello\r\r".chop.should == "hello\r"
    
    "\r\n".chop.should == ""
  end
  
  it "returns an empty string when applied to an empty string" do
    "".chop.should == ""
  end

  it "taints result when self is tainted" do
    "hello".taint.chop.tainted?.should == true
    "".taint.chop.tainted?.should == true
  end
  
  it "returns subclass instances when called on a subclass" do
    MyString.new("hello\n").chop.class.should == MyString
    MyString.new("hello").chop.class.should == MyString
    MyString.new("").chop.class.should == MyString
  end
end

describe "String#chop!" do
  it "behaves just like chop, but in-place" do
    ["hello\n", "hello\r\n", "hello", ""].each do |base|
      str = base.dup
      str.chop!
      
      str.should == base.chop
    end
  end

  it "returns self if modifications were made" do
    ["hello", "hello\r\n"].each do |s|
      s.chop!.equal?(s).should == true
    end
  end

  it "returns nil when called on an empty string" do
    "".chop!.should == nil
  end
  
  compliant :mri, :jruby do
    it "raises a TypeError when self is frozen" do
      a = "string\n\r"
      a.freeze
      should_raise(TypeError) { a.chop! }

      a = ""
      a.freeze
      a.chop! # ok, no change
    end
  end
end
