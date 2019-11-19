require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/Property')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new


class PropertyTest < MiniTest::Test

  def test_can_create_new_property
    property_details = {
      'address' => 'Clockwise, 77, Renfrew St, Glasgow G2 3BZ',
      'value' => 3000,
      'num_of_bedrooms' => 3,
      'year_built' => 2018
    }
    new_property = Property.new(property_details)
    assert_equal('Clockwise, 77, Renfrew St, Glasgow G2 3BZ', new_property.address)
  end


end
