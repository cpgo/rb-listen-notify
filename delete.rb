require 'sequel'
DB = Sequel.connect('postgres://postgres:postgres@postgres:5432/postgres')

items = DB[:items].delete

"this will be commented by pronto, by the rest of the violations wont"
