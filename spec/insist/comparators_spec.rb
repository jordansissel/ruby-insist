require "spec_setup"
require "insist"

describe Insist::Comparators do
  subject do
    Insist.new { 30 }
  end

  describe "#==" do
    it "should be OK if the #value is equal" do
      subject == 30
    end

    it "should fail if the #value is not equal" do
      insist { subject == 0 }.raises(Insist::Failure)
    end
  end

  describe "#<=" do
    it "should be OK if the #value is less than or equal" do
      larger = subject.value + 1
      subject <= larger
    end

    it "should fail if the #value is greater" do
      smaller = subject.value - 1
      insist { subject <= smaller }.raises(Insist::Failure)
    end
  end

  describe "#>=" do
    it "should be OK if the #value is greater than or equal" do
      smaller = subject.value - 1
      subject >= smaller
    end

    it "should fail if the #value is lesser" do
      larger = subject.value + 1
      insist { subject >= larger }.raises(Insist::Failure)
    end
  end
end
