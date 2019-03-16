require "rails_helper"

RSpec.describe "Persentase perhitungan caleg", type: :request do
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/1d510eef-9f93-4928-9da1-1adb4f76ec2e/5-PERHITUNGAN-explore-data-DPR-RI?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/c0959794-e28e-4831-9a4b-29115182cf95/5-PERHITUNGAN-explore-data-DPD?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/f0b9def0-0d56-4b78-9005-5f83b1ac4aea/5-PERHITUNGAN-explore-data-DPRD-provinsi-?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/baf1b2cd-d9dd-48b2-9489-af70f6b73ca6/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/provinces" do
    puts "Same as API::V1::Hitung::Provinces"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/c75c43c2-1fcf-455d-9778-5818710e3de1/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] /hitung/v1/regencies" do
    puts "same as API::V1::Hitung::Regencies"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/4b9c21bc-241b-40d9-8376-15066fa51b41/5-PERHITUNGAN-explore-data-DPR-RI-Dapil?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/163d3adc-235b-46d3-ab42-203e90f1b1c4/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-?fullscreen
  describe "[GET] /hitung/v1/dapils/region" do
    puts "same as API::V1::Hitung::Dapils"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/88e4a752-682d-49b6-956a-f0edff605321/5-PERHITUNGAN-explore-data-DPR-RI-Dapil-DKI-JAKART?fullscreen
  describe "[GET] Persentase DPR RI /hitung/v1/summary/candidates/show?dapil_id=41&level=0" do
    pending "test me please"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/ca77829d-106b-488b-9c75-80282d240fe2/5-PERHITUNGAN-explore-data-DPD-DKI-Jakarta-01?fullscreen
  describe "[GET] Persentase DPD /hitung/v1/summary/candidates/show?dapil_id=XX&level=3" do
    pending "test me please"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/1deb1e05-69e1-4025-9d99-7cbcf0546264/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-DKI?fullscreen
  describe "[GET] Persentase DPRD Provinsi /hitung/v1/summary/candidates/show?dapil_id=XX&level=1" do
    pending "test me please"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/187f3210-1d7c-4393-9947-1357923cdb3e/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] Persentase DPRD Kabupaten /hitung/v1/summary/candidates/show?dapil_id=XX&level=2" do
    pending "test me please"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/8c38c7e7-5812-44b6-b513-5cc0bdda0a48/5-PERHITUNGAN-explore-data-DPR-RI-Dapil-DKI-JAKART?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/47a15c15-1ced-4171-acfc-c6d541cca844/5-PERHITUNGAN-explore-data-DPD-DKI-Jakarta-01-user?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/cf7e253e-9b3b-45fb-b819-40667a71fda0/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-DKI?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/3777025d-f6a3-49d8-b238-6c037a89e7ad/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] TPS List /hitung/v1/real_counts?dapil_id=XX by Dapil ID" do
    pending "test me please"
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/45c3f244-8650-4fca-b3fd-3a042189f792/5-PERHITUNGAN-explore-data-DPR-RI-Dapil-DKI-JAKART?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/fb09a0ed-c558-4b81-bb84-9a7c3556bb45/5-PERHITUNGAN-explore-data-DPD-DKI-Jakarta-01-user?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/37396cb6-f995-4613-a73a-231e2459cc7a/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-DKI?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/5f1131fa-4ed2-4638-9dfa-f74857300655/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] Perhitungan per TPS /hitung/v1/summary/candidates/show?hitung_real_count_id=YOUR_UUID&dapil_id=XX&level=X" do
    pending "test me please"
  end
end
