class IdWilayahForVillage < SeedMigration::Migration
  def up
    parser = Parser::DapilWilayahKabupaten.new "/data_wilayah_kab"
    parser.parse
  end

  def down

  end
end
