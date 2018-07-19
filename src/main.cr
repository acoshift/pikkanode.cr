require "db"
require "pg"
require "./app"

db = DB.open "postgres://acoshift@localhost:5432/pikkanode_cr"
repo = Repository.new db

app = App.new(8080, repo)

app.start
