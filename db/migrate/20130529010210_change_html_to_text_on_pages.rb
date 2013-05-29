class ChangeHtmlToTextOnPages < ActiveRecord::Migration
  def up
    change_column :pages, :html, :text
  end

  def down
    change_column :pages, :html, :string
  end
end
