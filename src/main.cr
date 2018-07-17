require "db"
require "pg"
require "./app"

db = DB.open "postgres://acoshift@localhost:5432/pikkanode_cr"

app = App.new(8080, db)

app.start
