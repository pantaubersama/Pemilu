class AddBannerInfo < SeedMigration::Migration
  def up
    BannerInfo.create([
      {id: "f84a0010-b981-4d1c-8bb0-9e599eac1c12", page_name: "lapor", title: "Lapor", body:"Lapor"},
      {id: "c89eea96-4616-46a6-a25b-040e5ecf2dfd", page_name: "debat", title: "Debat", body:"Debat"},
      {id: "650a3d88-2f0e-403d-a94f-45ed878779a7", page_name: "tantangan", title: "Tantangan", body:"Tantangan"},
      {id: "90495b56-414d-4865-9765-867ecfb14966", page_name: "perhitungan", title: "Perhitungan", body:"Perhitungan"},
      {id: "8880dbe8-3324-4f7a-b3f6-8e97af355def", page_name: "my_input", title: "My Input", body:"My Input"},
      ])
  end

  def down

  end
end
