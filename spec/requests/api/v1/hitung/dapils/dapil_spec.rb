require "rails_helper"

RSpec.describe "API::V1::Hitung::Dapils", type: :request do

  let(:province) { FactoryBot.create(:province, code: 16, name: "SUMATERA SELATAN", id_wilayah: 17404) }
  let(:regency) { FactoryBot.create(:regency, name: "MUSI BANYUASIN", code: 1606, id_wilayah: 18942, province_id: province.id) }
  let(:district) { FactoryBot.create(:district, regency_code: regency.code, name: "SEKAYU", id_wilayah: 18943) }

  describe "[GET] /hitung/v1/dapils/region" do
    describe "DPD" do
      context "when tingkat is DPD and province not found" do
        it "should error return 422" do
          FactoryBot.create(:province)
          get "/hitung/v1/dapils/region", params: {
                                             province_code: 2,
                                             regency_code: 1,
                                             district_code: 1,
                                             tingkat: "dpd",
                                           }
          expect(response.status).to eq(422)
        end
      end

      context "when tingkat is DPD and province is sumatera selatan" do
        it "should return 200 and dapil is SUMATERA SELATAN" do
          FactoryBot.create(:dapil, nama: "SUMATERA SELATAN", tingkat: "dpd", idWilayah: province.id_wilayah)
          get "/hitung/v1/dapils/region", params: {
                                             province_code: province.code,
                                             regency_code: regency.code,
                                             district_code: district.code,
                                             tingkat: "dpd",
                                           }
          expect(response.status).to eq(200)
          expect(json_response[:data][:nama]).to eq("SUMATERA SELATAN")
          expect(json_response[:data][:tingkat]).to eq("dpd")
          expect(json_response[:data][:idWilayah]).to eq(17404)
        end
      end
    end

    describe "DPR" do
      context "when tingkat is DPR and regency is Musi Banyuasin" do
        it "should return 200 and dapil is SUMATERA SELATAN I" do
          dapil = FactoryBot.create(:dapil, nama: "SUMATERA SELATAN I", idWilayah: regency.id_wilayah, tingkat: 0)
          FactoryBot.create(:dapil_wilayah, namaWilayah: "MUSI BANYUASIN", idWilayah: regency.id_wilayah, idDapil: dapil.id)
          get "/hitung/v1/dapils/region", params: {
                                             province_code: province.code,
                                             regency_code: regency.code,
                                             district_code: district.code,
                                             tingkat: "dpr",
                                           }

          expect(response.status).to eq(200)
          expect(json_response[:data][:nama]).to eq("SUMATERA SELATAN I")
          expect(json_response[:data][:tingkat]).to eq("dpr")
        end
      end
    end

    describe "DPRD PROV" do
      context "when tingkat is DPRD PROV and regency is Musi Banyuasin" do
        it "should return 200 and dapil is SUMATERA SELATAN  9" do
          dapil = FactoryBot.create(:dapil, nama: "SUMATERA SELATAN  9", tingkat: 1)
          FactoryBot.create(:dapil_wilayah, namaWilayah: "MUSI BANYUASIN", idWilayah: regency.id_wilayah, idDapil: dapil.id)
          get "/hitung/v1/dapils/region", params: {
                                             province_code: province.code,
                                             regency_code: regency.code,
                                             district_code: district.code,
                                             tingkat: "provinsi",
                                           }

          expect(response.status).to eq(200)
          expect(json_response[:data][:nama]).to eq("SUMATERA SELATAN  9")
          expect(json_response[:data][:tingkat]).to eq("provinsi")
        end
      end
    end

    describe "DPRD KAB" do
      context "when tingkat is DPRD KAB and district is Sekayu" do
        it "should return 200 and dapil is MUSI BANYUASIN 1" do
          dapil = FactoryBot.create(:dapil, nama: "MUSI BANYUASIN 1", tingkat: 2)
          FactoryBot.create(:dapil_wilayah, namaWilayah: "SEKAYU", idWilayah: district.id_wilayah, idDapil: dapil.id)
          get "/hitung/v1/dapils/region", params: {
                                             province_code: province.code,
                                             regency_code: regency.code,
                                             district_code: district.code,
                                             tingkat: "kabupaten",
                                           }

          expect(response.status).to eq(200)
          expect(json_response[:data][:nama]).to eq("MUSI BANYUASIN 1")
          expect(json_response[:data][:tingkat]).to eq("kabupaten")
        end
      end
    end
  end

  describe "GET /hitung/v1/dapils" do
    describe "DPD" do
      before do
        FactoryBot.create(:dapil,id: 1, tingkat: 3)
        FactoryBot.create(:dapil,id: 2, tingkat: 3)
        FactoryBot.create(:dapil,id: 3, tingkat: 3)
        FactoryBot.create(:dapil,id: 4, tingkat: 3)
      end
      it "success" do
        get "/hitung/v1/dapils", params: {
          tingkat: "dpd"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:dapils].size).to eq(4)
      end
    end

    describe "DPR" do
      context "when not input province" do
        it "should return 422" do
          get "/hitung/v1/dapils", params: {
            tingkat: "dpr"
          }
          expect(response.status).to eq(422)
        end
      end
      context "when input province code" do
        before do
         @province = FactoryBot.create(:province, code: 10)
         FactoryBot.create(:dapil,id:1, tingkat: 0, idWilayah: @province.id_wilayah)
         FactoryBot.create(:dapil,id:2, tingkat: 0, idWilayah: @province.id_wilayah)
         FactoryBot.create(:dapil,id:3, tingkat: 0, idWilayah: @province.id_wilayah)
        end
        it "should return 200" do
          get "/hitung/v1/dapils", params: {
            province_code: @province.code,
            tingkat: "dpr"
          }
          expect(response.status).to eq(200)
          expect(json_response[:data][:dapils].size).to eq(3)
        end
      end
    end

    describe "Provinsi" do
      context "when not input province" do
        it "should return 422" do
          get "/hitung/v1/dapils", params: {
            tingkat: "provinsi"
          }
          expect(response.status).to eq(422)
        end
      end
      context "when input province code" do
        before do
         @province = FactoryBot.create(:province, code: 10)
         FactoryBot.create(:dapil,id:1, tingkat: 1, idWilayah: @province.id_wilayah)
         FactoryBot.create(:dapil,id:2, tingkat: 1, idWilayah: @province.id_wilayah)
         FactoryBot.create(:dapil,id:3, tingkat: 1, idWilayah: @province.id_wilayah)
        end
        it "should return 200" do
          get "/hitung/v1/dapils", params: {
            province_code: @province.code,
            tingkat: "provinsi"
          }
          expect(response.status).to eq(200)
          expect(json_response[:data][:dapils].size).to eq(3)
        end
      end
    end

    describe "Kabupaten" do
      context "when not input regency code" do
        it "should return 422" do
          get "/hitung/v1/dapils", params: {
            tingkat: "kabupaten"
          }
          expect(response.status).to eq(422)
        end
      end

      context "when input regency code" do
        before do
          @province = FactoryBot.create(:province, code: 10)
          @regency = FactoryBot.create(:regency, code: 1606, province_id: @province.id)
          FactoryBot.create(:dapil,id:1, tingkat: 2, idWilayah: @regency.id_wilayah)
          FactoryBot.create(:dapil,id:2, tingkat: 2, idWilayah: @regency.id_wilayah)
          FactoryBot.create(:dapil,id:3, tingkat: 2, idWilayah: @regency.id_wilayah)
        end
        it "should return 200" do
          get "/hitung/v1/dapils", params: {
            regency_code: @regency.code,
            tingkat: "kabupaten"
          }
          expect(response.status).to eq(200)
          expect(json_response[:data][:dapils].size).to eq(3)
        end
      end
    end
  end


end
