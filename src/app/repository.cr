class Repository
  def initialize(@db : DB::Database) end

  def register_user(username : String, hashed_password : String)
    begin
      @db.exec "
        insert into users
          (username, password)
        values
          ($1, $2)
      ", username, hashed_password
    rescue ex
      return false if ex.message == "duplicate key value violates unique constraint \"users_username_idx\""
      raise ex
    end
    true
  end

  def find_user_by_username(username : String)
    @db.query_one? "
      select
        id, password
      from users
      where username = $1
    ", username, as: { user_id: String, password: String }
  end

  def register_token(tk : Token)
    @db.exec "
      insert into tokens
        (id, data)
      values
        ($1, $2)
    ", tk.id, tk.to_json
  end

  def remove_token(token_id : String)
    @db.exec "delete from tokens where id = $1", token_id
  end
end