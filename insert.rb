require 'sequel'
DB = Sequel.connect('postgres://postgres:postgres@postgres:5432/postgres')

items = DB[:items]
items.insert(:name => 'abc', :price => rand * 100)
