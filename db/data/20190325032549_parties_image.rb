class PartiesImage < SeedMigration::Migration
  def up
    PoliticalParty.find_by(serial_number: 1).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/1.jpeg')))
    })

    PoliticalParty.find_by(serial_number: 2).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/2.jpg')))
    })

    PoliticalParty.find_by(serial_number: 3).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/3.jpg')))
    })

    PoliticalParty.find_by(serial_number: 4).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/4.jpg')))
    })

    PoliticalParty.find_by(serial_number: 5).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/5.jpg')))
    })

    PoliticalParty.find_by(serial_number: 6).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/6.jpg')))
    })

    PoliticalParty.find_by(serial_number: 7).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/7.jpg')))
    })

    PoliticalParty.find_by(serial_number: 8).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/8.jpg')))
    })

    PoliticalParty.find_by(serial_number: 9).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/9.JPG')))
    })

    PoliticalParty.find_by(serial_number: 10).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/10.jpg')))
    })

    PoliticalParty.find_by(serial_number: 11).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/11.jpeg')))
    })

    PoliticalParty.find_by(serial_number: 12).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/12.jpg')))
    })

    PoliticalParty.find_by(serial_number: 13).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/13.jpg')))
    })

    PoliticalParty.find_by(serial_number: 14).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/14.jpg')))
    })

    PoliticalParty.find_by(serial_number: 15).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/15.jpg')))
    })

    PoliticalParty.find_by(serial_number: 16).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/16.jpg')))
    })

    PoliticalParty.find_by(serial_number: 17).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/17.jpg')))
    })

    PoliticalParty.find_by(serial_number: 18).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/18.jpg')))
    })

    PoliticalParty.find_by(serial_number: 19).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/19.jpg')))
    })

    PoliticalParty.find_by(serial_number: 20).update_attributes({
      logo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/20.jpg')))
    })
  end

  def down

  end
end
