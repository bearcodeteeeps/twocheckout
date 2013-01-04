require 'spec_helper'
require 'date'

module Twocheckout
  class Person < HashObject
    def full_name
      "#{first_name} #{last_name}"
    end

    def birth_date
      Date.parse(@hash['birth_date'])
    end
  end

  describe HashObject do
    let (:vito) do
      Person.new({
        'first_name' => 'Vito',
        'last_name' => 'Corleone',
        'address' => {
          'city' => 'New York',
          'state' => 'NY',
        },
        'birth_date' => "1891-12-07",
        'children' => [
          { 'name' => 'Sonny', 'gender' => 'male' },
          { 'name' => 'Fredo', 'gender' => 'male' },
          { 'name' => 'Michael', 'gender' => 'male' },
          { 'name' => 'Connie', 'gender' => 'female' },
        ]
      })
    end

    it "should recognize keys in the hash as methods" do
      vito.should respond_to(:first_name)
      vito.should respond_to(:last_name)
      vito.should respond_to(:address)
      vito.should respond_to(:birth_date)

      vito.should_not respond_to(:age)
      lambda { vito.age }.should raise_error(NoMethodError)

      vito.first_name.should == 'Vito'
      vito.last_name.should == 'Corleone'
    end

    it "should recognize nested hashes and return them as hash objects too" do
      vito.address.should be_a(HashObject)
      vito.address.should respond_to(:city)
      vito.address.should respond_to(:state)

      vito.address.should_not respond_to(:province)
      lambda { vito.address.province }.should raise_error(NoMethodError)

      vito.address.city.should == 'New York'
      vito.address.state.should == 'NY'
    end

    it "should recognize hashes within nested arrays and return them as hash objects too" do
      vito.children.should be_a(Array)
      vito.children.each do |child|
        child.should be_a(HashObject)
        child.should respond_to(:name)
        child.should respond_to(:gender)
        child.should_not respond_to(:age)
        lambda { child.age }.should raise_error(NoMethodError)
      end
      vito.children.map(&:name).should == %w(Sonny Fredo Michael Connie)
      vito.children.map(&:gender).should == %w(male male male female)
    end

    it "should allow subclasses to define methods modifying or adding behavior" do
      vito.birth_date.should be_a(Date)
      vito.birth_date.should_not == "1891-12-07"
      vito.birth_date.should == Date.parse("1891-12-07")

      lambda { vito.full_name }.should_not raise_error(NoMethodError)
      vito.should respond_to(:full_name)
      vito.full_name.should == 'Vito Corleone'
    end
  end
end
