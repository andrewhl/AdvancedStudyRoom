class RemoveOldAuthenticationSystem < ActiveRecord::Migration
  def up
    users = User.where("password_digest IS NOT NULL OR password_digest <> ''")
    users.find_each do |user|
      user.update_attributes(
        { encrypted_password: user[:password_digest],
          confirmed_at: user.confirmed_at || Time.current },
        { without_protection: true })
    end
    remove_column :users, :password_digest
  end

  def down
    add_column :users, :password_digest, :string
    ActiveRecord::Base.connection.update_sql(
      "UPDATE users
        SET password_digest = encrypted_password, confirmed_at = NULL, encrypted_password = ''
        WHERE created_at < '2013-05-29'")
  end
end
