class BannerRekapitulasiSeed < SeedMigration::Migration
  def up
    BannerInfo.create([
    { id: "1f4d3106-f0a3-4ede-a271-441b788f6a6e", page_name: "rekapitulasi", title: "rekapitulasi", body:"rekapitulasi" },
    ])
  end

  def down
    BannerInfo.destroy "1f4d3106-f0a3-4ede-a271-441b788f6a6e"
  end
end
