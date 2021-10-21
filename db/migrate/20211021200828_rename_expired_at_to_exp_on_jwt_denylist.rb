class RenameExpiredAtToExpOnJwtDenylist < ActiveRecord::Migration[6.1]
  def change
    rename_column :jwt_denylist, :expired_at, :exp
  end
end
