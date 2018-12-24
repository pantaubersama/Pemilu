# This migration creates the `versions` table, the only schema PT requires.
# All other migrations PT provides are optional.
class ChangeItemIdType< ActiveRecord::Migration[5.2]
  def change
    execute 'ALTER TABLE "versions" ALTER COLUMN "item_id" SET DATA TYPE UUID USING "item_id"::UUID;'
  end
end
