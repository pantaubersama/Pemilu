
require "rails_helper"

RSpec.describe "Persentase perhitungan presiden", type: :request do
  before do
    populate_region
    populate_region_sumsel
    populate_region_jateng
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @user3 = FactoryBot.create(:user)
    @user4 = FactoryBot.create(:user)
    @region_aceh = {
      province_code: 92,
      regency_code: 9291,
      district_code: 927110,
      village_code: 9271101004
    }
    @region_sumsel = {
      province_code: 16,
      regency_code: 1606,
      district_code: 160601,
      village_code: 1606011010
    }
    @region_jateng = {
      province_code: 33,
      regency_code: 3326,
      district_code: 337501,
      village_code: 3375011006
    }
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/f1b7208a-0bcb-4edb-ac27-015d49340012/5-REKAPITULASI-Rekapitulasi?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/9d5c9f28-1fd5-43da-9ca9-1d2ae95bb232/5-PERHITUNGAN-explore-data-presiden-?fullscreen
  describe "[GET] /hitung/v1/summary/president/show?level=0" do
    before do
      calculation @user1, 1, 10, 50, 0, @region_aceh
      calculation @user2, 2, 20, 20, 0, @region_aceh
    end
    it "success" do
      get "/hitung/v1/summary/president/show?level=0"
      expect(response.status).to eq(200)
      expect(json_response[:data][:percentage][:summary_type]).to eq("all")
      expect(json_response[:data][:percentage][:candidates].size).to eq(2)
      expect(json_response[:data][:percentage][:candidates][0][:id]).to eq(1)
      expect(json_response[:data][:percentage][:candidates][0][:total_vote]).to eq(30)
      expect(json_response[:data][:percentage][:candidates][0][:percentage]).to eq(30)
      expect(json_response[:data][:percentage][:candidates][1][:id]).to eq(2)
      expect(json_response[:data][:percentage][:candidates][1][:total_vote]).to eq(70)
      expect(json_response[:data][:percentage][:candidates][1][:percentage]).to eq(70)
      expect(json_response[:data][:percentage][:total_vote]).to eq(100)
    end
  end

  describe "[GET] /hitung/v1/summary/president/list?level=0" do
    before do
      calculation @user1, 1, 20, 70, 10, @region_sumsel
      calculation @user2, 2, 50, 30, 20, @region_sumsel
      calculation @user3, 1, 10, 50, 0, @region_aceh
      calculation @user4, 2, 20, 20, 0, @region_aceh
    end
    it "sucess" do
      get "/hitung/v1/summary/president/list?level=0"
      expect(response.status).to eq(200)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:id]).to eq(1)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:total_vote]).to eq(70)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:percentage]).to eq(35)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:id]).to eq(2)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:total_vote]).to eq(100)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:percentage]).to eq(50)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:total_vote]).to eq(30)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:percentage]).to eq(15)
      expect(json_response[:data][:percentages][0][:percentage][:total_vote]).to eq(200)
    end
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/9c851e22-4770-400d-b617-34102b8472b0/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/62f26e41-bd30-49ee-a4bb-475cc61e4c59/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/summary/president/list?level=1" do
    it "return 404" do
      get "/hitung/v1/summary/president/list?level=1"
      expect(response.status).to eq(404)
    end
    before do
      calculation @user1, 1, 20, 70, 10, @region_sumsel
      calculation @user2, 2, 50, 30, 20, @region_sumsel
    end
    it "success" do
      get "/hitung/v1/summary/president/list?level=1", params:{
        region: 16
      }
      expect(response.status).to eq(200)
      expect(json_response[:data][:percentages][0][:region][:province_id]).to eq(16)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:id]).to eq(1)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:total_vote]).to eq(70)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:percentage]).to eq(35)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:id]).to eq(2)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:total_vote]).to eq(100)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:percentage]).to eq(50)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:total_vote]).to eq(30)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:percentage]).to eq(15)
      expect(json_response[:data][:percentages][0][:percentage][:total_vote]).to eq(200)
    end
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/06d6f44f-400f-4b29-ba62-609d20190202/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-1?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/039e54e1-9739-4cc1-aec4-2e6c1a384c0a/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/summary/president/list?level=2" do
    it "return 404" do
      get "/hitung/v1/summary/president/list?level=2"
      expect(response.status).to eq(404)
    end
    before do
      calculation @user1, 1, 20, 70, 10, @region_sumsel
      calculation @user2, 2, 50, 30, 20, @region_sumsel
    end
    it "success" do
      get "/hitung/v1/summary/president/list?level=2", params: {
        region: 1606
      }
      expect(response.status).to eq(200)
      expect(json_response[:data][:region][:id]).to eq(1606)
      expect(json_response[:data][:percentages][0][:percentage][:summary_type]).to eq("district")
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:id]).to eq(1)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:total_vote]).to eq(70)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:percentage]).to eq(35)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:id]).to eq(2)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:total_vote]).to eq(100)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:percentage]).to eq(50)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:total_vote]).to eq(30)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:percentage]).to eq(15)
      expect(json_response[:data][:percentages][0][:percentage][:total_vote]).to eq(200)
    end
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/28730419-a4ce-4521-9064-35dad7120943/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-2?fullscreen
  describe "[GET] /hitung/v1/summary/president/list?level=3" do
    it "return 404" do
      get "/hitung/v1/summary/president/list?level=3"
      expect(response.status).to eq(404)
    end
    before do
      calculation @user1, 1, 20, 70, 10, @region_sumsel
      calculation @user2, 2, 50, 30, 20, @region_sumsel
    end
    it "sucess" do
      get "/hitung/v1/summary/president/list?level=3", params: {
        region: 160601
      }
      expect(response.status).to eq(200)
      expect(json_response[:data][:region][:id]).to eq(160601)
      expect(json_response[:data][:percentages][0][:percentage][:summary_type]).to eq("village")
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:id]).to eq(1)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:total_vote]).to eq(70)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][0][:percentage]).to eq(35)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:id]).to eq(2)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:total_vote]).to eq(100)
      expect(json_response[:data][:percentages][0][:percentage][:candidates][1][:percentage]).to eq(50)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:total_vote]).to eq(30)
      expect(json_response[:data][:percentages][0][:percentage][:invalid_vote][:percentage]).to eq(15)
      expect(json_response[:data][:percentages][0][:percentage][:total_vote]).to eq(200)
    end
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/904ef1f9-20f8-41b7-b210-e301f3da09ba/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-4?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/f39bab29-8bc1-4fd3-a020-62ecec588bdd/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/real_counts?page=1&village_code=1606011010" do
    before do
      calculation @user1, 1, 20, 70, 10, @region_sumsel
      calculation @user2, 2, 50, 30, 20, @region_sumsel
    end
    it "success return 200" do
      get "/hitung/v1/real_counts?page=1&village_code=1606011010"
      expect(response.status).to eq(200)
      expect(json_response[:data][:real_counts].size).to eq(2)
      expect(json_response[:data][:real_counts][0][:village_code]).to eq(1606011010)
    end
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/c907ca27-3466-4872-8c9f-7cb24c6f11af/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-3?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/fce440ba-6cd4-4dcd-b6f5-67e3281ae661/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/real_counts/YOUR_UUID" do
    before do
      populate_real_count @user1, 1, @region_sumsel
    end
    it "success return 200" do
      get "/hitung/v1/real_counts/#{@real_count2.id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:real_count][:id]).to eq(@real_count2.id)
      expect(json_response[:data][:real_count][:user][:id]).to eq(@user1.id)
    end
  end

  describe "[GET] /hitung/v1/form_c1?hitung_real_count_id=YOUR_UUID&form_c1_type=presiden" do
    before do
      populate_real_count @user1, 1, @region_sumsel
      @formC1 = FactoryBot.create(:hitung_form_c1, hitung_real_count_id: @real_count2.id, form_c1_type: "presiden")
    end
    it "sucess return 200" do
      get "/hitung/v1/form_c1?hitung_real_count_id=#{@real_count2.id}&form_c1_type=presiden"
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] /hitung/v1/images?image_type=c1_presiden" do
    it "return 200" do
      get "/hitung/v1/images?image_type=c1_presiden"
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] Persentase perseorangan /hitung/v1/summary/president/show?level=6&region=3375011006&tps=1&hitung_real_count_id=YOUR_UUID" do
    it "return 404" do
      get "/hitung/v1/summary/president/show?level=6&region=3375011006&tps=1&hitung_real_count_id="
      expect(response.status).to eq(404)
    end
    before do
      populate_real_count @user1, 1, @region_jateng
    end
    it "success return 200" do
      get "/hitung/v1/summary/president/show?level=6&region=3375011006&tps=1&hitung_real_count_id=#{@real_count2.id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:region][:id]).to eq(@region_jateng[:village_code])
      expect(json_response[:data][:tps]).to eq(1)
      expect(json_response[:data][:user][:full_name]).to eq(@user1.full_name)
      expect(json_response[:data][:percentage]).to eq(nil)
    end
  end

  def calculation user, tps, vote_candidate_1, vote_candidate_2, invalid_vote=0, region=nil
    @real_count = FactoryBot.create :hitung_real_count, tps: tps, status: "published", user_id: user.id, province_code: region[:province_code], regency_code: region[:regency_code], district_code: region[:district_code], village_code: region[:village_code]
    @calculation = FactoryBot.create(:hitung_calculation, hitung_real_count_id: @real_count.id, calculation_type: 4, invalid_vote: invalid_vote)
    @calculation_detail= FactoryBot.create(:hitung_calculation_detail, hitung_real_count_id: @real_count.id, hitung_calculation_id: @calculation.id, actor_type: "President", actor_id: 1, total_vote: vote_candidate_1)
    @calculation_detail2= FactoryBot.create(:hitung_calculation_detail, hitung_real_count_id: @real_count.id, hitung_calculation_id: @calculation.id, actor_type: "President", actor_id: 2, total_vote: vote_candidate_2)
  end

  def populate_real_count user, tps, region
    @real_count2 = FactoryBot.create :hitung_real_count, tps: tps, status: "published", user_id: user.id, province_code: region[:province_code], regency_code: region[:regency_code], district_code: region[:district_code], village_code: region[:village_code]
  end

  def populate_region_sumsel
    FactoryBot.create :province, id: 16, code: 16, name: "SUMATERA SELATAN", level: 1, id_wilayah: 17404
    FactoryBot.create :regency, id: 1606, province_id: 16, code: 1606, name: "MUSI BANYUASIN", level: 2, id_wilayah: 18942, id_parent: 17404
    FactoryBot.create :regency, id: 1604, province_id: 16, code: 1604, name: "LAHAT", level: 2, id_wilayah: 18244, id_parent: 17404
    FactoryBot.create :regency, id: 1671, province_id: 16, code: 1671, name: "KOTA PALEMBANG", level: 2, id_wilayah: 20512, id_parent: 17404
    FactoryBot.create :district, id: 160601, regency_code: 1606, code: 160601, name: "SEKAYU", id_parent: 18942, id_wilayah: 18943, level: 3
    FactoryBot.create :district, id: 160602, regency_code: 1606, code: 160602, name: "LAIS", id_parent: 18942, id_wilayah: 18958, level: 3
    FactoryBot.create :village, id: 1606011010, code: 1606011010, district_code: 160601, name: "Serasan Jaya"
    FactoryBot.create :village, id: 1606011009, code: 1606011009, district_code: 160601, name: "Kayu Ara"
  end

  def populate_region_jateng
    FactoryBot.create :province, id: 33, code: 33, name: "JAWA TENGAH", level: 1, id_wilayah: 32676
    FactoryBot.create :regency, id: 3375, province_id: 33, code: 3375, name: "PEKALONGAN", level: 2, id_wilayah: 41779, id_parent: 32676
    FactoryBot.create :district, id: 337501, regency_code: 3375, code: 337501, name: "PEKALONGAN BARAT", id_parent: 41779, id_wilayah: 41780, level: 3
    FactoryBot.create :village, id: 3375011006, code: 3375011006, district_code: 337501, name: "Bendan Kergon"
  end

end
