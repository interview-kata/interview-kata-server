class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.integer :number
      t.text :title
      t.text :body
      t.jsonb :labels
      t.string :html_url
      t.string :state, limit: 20
      t.boolean :locked
      t.integer :comments_count
      t.jsonb :raw

      t.timestamps
    end
  end
end
