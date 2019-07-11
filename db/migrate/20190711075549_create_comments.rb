class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :comment_id
      t.references :issue, foreign_key: true
      t.text :html_url
      t.jsonb :user
      t.text :body

      t.timestamps
    end
  end
end
