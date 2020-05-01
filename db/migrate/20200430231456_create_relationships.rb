class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      # to_table: :usersの記述によってusersテーブルと関連付を行う,これが無いとfollowsテーブルと関連付しようとしてしまいエラーになる
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      
      # この記述により2つのカラムuser_id,follow_idは重複しないようにしている
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
