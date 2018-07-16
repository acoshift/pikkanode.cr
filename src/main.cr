require "./app"
require "db"
require "pg"

db = DB.open "postgres://acoshift@localhost:5432/pikkanode_cr"

app = Pikkanode::App.new(8080, db)

app.start
