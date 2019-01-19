class KenalanSeed < SeedMigration::Migration
  def up
    Kenalan.create!([
                        { id: "c46bae56-8c87-4f54-8328-b959d89c931f", text: 'Melakukan Verifikasi' },
                        { id: "9bbc974c-dab4-4467-ac5f-84e8a8d56b1c", text: 'Lengkapi Biodata' },
                        { id: "c3fded37-5b4b-4a81-aee7-ee24d845b5e8", text: 'Lengkapi Data Lapor' },
                        { id: "231cbadc-a856-4723-93a9-bb79915dd40d", text: 'Tanya Presiden' },
                        { id: "f2596bdb-90ba-41e9-8c39-11c891c68f1f", text: 'Ikuti Quiz' },
                        { id: "e27b16e8-f585-448b-afbc-0219c48471d6", text: 'Kunjungi Janji Politik' },
                        { id: "16fc11b3-c5a4-491c-81f4-cd6cdca1ed1e", text: 'Ikuti Word Stadium' },
                        { id: "2022ad13-d602-4eba-9cf1-9ef2ea0e158d", text: 'Kontribusi Lapor' },
                        { id: "8706f239-09ad-47b3-b8bb-a3a37439c519", text: 'Kontribusi Perhitungan' },
                        { id: "6c5ffd3d-219a-43e0-8035-c71af1459658", text: 'Baca Pantau Bersama' }
                    ])
  end

  def down

  end
end
