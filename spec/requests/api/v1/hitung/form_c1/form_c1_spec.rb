require 'rails_helper'

RSpec.describe "Api::V1::Hitung::FormC1", type: :request do
  before do
    @access_token = SecureRandom.hex
    @file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
    @hitung1 = FactoryBot.create :hitung_real_count, status: "published", user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
    @hitung2 = FactoryBot.create :hitung_real_count, status: "published", user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
  end

  describe "Create form C1 presiden" do
    it "success" do
      response, json_response = create_c1 "presiden"

      expect(response.status).to eq(200)
      expect(@hitung1.forms.presiden.map(&:form_c1_type)).to eq(["presiden"])
      expect(json_response[:data][:form_c1][:form_c1_type]).to eq("presiden")
      expect(json_response[:data][:form_c1][:aggregates][:a3_total]).to eq(3)
      expect(json_response[:data][:form_c1][:aggregates][:a4_total]).to eq(7)
      expect(json_response[:data][:form_c1][:aggregates][:a_dpk_total]).to eq(11)
      expect(json_response[:data][:form_c1][:aggregates][:pemilih_laki_laki_total]).to eq(9)
      expect(json_response[:data][:form_c1][:aggregates][:pemilih_perempuan_total]).to eq(12)
      expect(json_response[:data][:form_c1][:aggregates][:pemilih_total]).to eq(21)
      expect(json_response[:data][:form_c1][:aggregates][:c7_dpt_total]).to eq(15)
      expect(json_response[:data][:form_c1][:aggregates][:c7_dptb_total]).to eq(19)
      expect(json_response[:data][:form_c1][:aggregates][:c7_dpk_total]).to eq(23)
      expect(json_response[:data][:form_c1][:aggregates][:c7_laki_laki_hak_pilih_total]).to eq(27)
      expect(json_response[:data][:form_c1][:aggregates][:c7_perempuan_hak_pilih_total]).to eq(30)
      expect(json_response[:data][:form_c1][:aggregates][:c7_hak_pilih_total]).to eq(57)
      expect(json_response[:data][:form_c1][:aggregates][:disabilitas_terdaftar_total]).to eq(27)
      expect(json_response[:data][:form_c1][:aggregates][:disabilitas_hak_pilih_total]).to eq(31)
      expect(json_response[:data][:form_c1][:aggregates][:total_suara]).to eq(54)
    end

    it "should fail" do
      response, json_response = create_c1 "presiden", @hitung2.id

      expect(response.status).to eq(404)
    end

  end

  describe "Create 5 form C1" do
    it "success" do
      create_c1 "presiden"
      create_c1 "dpr"
      create_c1 "provinsi"
      create_c1 "kabupaten"
      create_c1 "dpd"
      expect(@hitung1.forms.size).to eq(5)
      expect(@hitung1.forms.map(&:form_c1_type)).to eq(["presiden", "dpr", "provinsi", "kabupaten", "dpd"])
    end
  end

  def create_c1 form_type, hitung_id = @hitung1.id
    put "/hitung/v1/form_c1/", headers: stub_auth_headers(@access_token),
      params: {
        hitung_real_count_id: hitung_id,
        form_c1_type: form_type,
        a3_laki_laki: 1,
        a3_perempuan: 2,
        a4_laki_laki: 3,
        a4_perempuan: 4,
        a_dpk_laki_laki: 5,
        a_dpk_perempuan: 6,
        c7_dpt_laki_laki: 7,
        c7_dpt_perempuan: 8,
        c7_dptb_laki_laki: 9,
        c7_dptb_perempuan: 10,
        c7_dpk_laki_laki: 11,
        c7_dpk_perempuan: 12,
        disabilitas_terdaftar_laki_laki: 13,
        disabilitas_terdaftar_perempuan: 14,
        disabilitas_hak_pilih_laki_laki: 15,
        disabilitas_hak_pilih_perempuan: 16,
        surat_dikembalikan: 17,
        surat_tidak_digunakan: 18,
        surat_digunakan: 19,
      }
    [response, json_response]
  end

end
