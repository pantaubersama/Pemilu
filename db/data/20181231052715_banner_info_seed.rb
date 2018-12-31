class BannerInfoSeed < SeedMigration::Migration
  def up
    BannerInfo.create!([
                           { id: "ade8d637-e85e-4726-8005-6cede80ea860", page_name: "pilpres", title: "Judul banner pilpres", body: "Body banner pilpres" },
                           { id: "5d01f7ab-4c90-4199-999b-da5287d06a88", page_name: "janji politik", title: "Judul banner 'janji politik'", body: "Body banner 'janji politik'" },
                           { id: "a22d2acd-7eda-4a7a-95a0-931abf5db8e3", page_name: "tanya", title: "Judul banner tanya", body: "Body banner tanya" },
                           { id: "9b98ac07-3208-4d60-976e-49ace39e38a7", page_name: "kuis", title: "Judul banner kuis", body: "Body banner kuis" },
                       ])
  end

  def down
    BannerInfo.destroy_all
  end
end
