CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.asset_host = ENV['BASE_URL'] || "lvh.me:3000"
    config.storage    = :file
  elsif Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
        provider:              "AWS",
        aws_access_key_id:     ENV['AWS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_KEY_SECRET'],
        region:                "ap-southeast-1"
    }
    config.fog_directory   = ENV['AWS_BUCKET_NAME']
    config.cache_dir       = "#{Rails.root}/tmp/uploads"
    config.storage         = :fog
  end
end
