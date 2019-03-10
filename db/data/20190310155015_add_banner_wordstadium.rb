class AddBannerWordstadium < SeedMigration::Migration
  def up
    BannerInfo.create([
      { id: "aff9706e-cb65-48f5-bbd0-de4afbdd7614", page_name: "debat_public", title: "debat public", body: "debat public" },
      { id: "53f65142-f86c-4a6c-befc-bd029ec519c4", page_name: "debat_personal", title: "debat personal", body: "debat personal" },
    ])
  end

  def down
    BannerInfo.destroy "aff9706e-cb65-48f5-bbd0-de4afbdd7614"
    BannerInfo.destroy "53f65142-f86c-4a6c-befc-bd029ec519c4"
  end
end
