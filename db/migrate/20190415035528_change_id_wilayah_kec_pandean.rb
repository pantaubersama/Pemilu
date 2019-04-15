class ChangeIdWilayahKecPandean < ActiveRecord::Migration[5.2]
  def up
    d = District.find_by id_wilayah: 930149
    d.update_attributes!(id_wilayah: 51350)
  end

  def down
    d = District.find_by id_wilayah: 51350
    d.update_attributes!(id_wilayah: 930149)
  end
end
