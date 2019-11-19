require('pry')
require_relative('models/property')

Property.delete_all()

property1 = Property.new({
  'address' => 'Clockwise, 77, Renfrew St, Glasgow G2 3BZ',
  'value' => 3000,
  'num_of_bedrooms' => 3,
  'year_built' => 2018
  })

property2 = Property.new({
  'address' => '309a Sauchiehall St, Glasgow G2 3HW',
  'value' => 500000,
  'num_of_bedrooms' => 5,
  'year_built' => 2012
  })

property1.save()
property2.save()

binding.pry
nil
