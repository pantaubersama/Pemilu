require "rails_helper"

RSpec.describe "Persentase perhitungan caleg", type: :request do

  before do
    @access_token = SecureRandom.hex
    populate_region_sumsel
    @user1 = FactoryBot.create :user, id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
    @user2 = FactoryBot.create :user, id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
    @region_sumsel = {
      province_code: 16,
      regency_code: 1606,
      district_code: 160601,
      village_code: 1606011010,
    }

    # Create DAPIL
    @dapil1 = FactoryBot.create(:dapil, id: 1, nama: "SUMATERA SELATAN", tingkat: 3, idWilayah: Province.last.id_wilayah)

    @dapil2 = FactoryBot.create(:dapil, id: 2, nama: "SUMATERA SELATAN I", idWilayah: Regency.last.id_wilayah, tingkat: 0)
    FactoryBot.create(:dapil_wilayah, id: 3, namaWilayah: "MUSI BANYUASIN", idWilayah: Regency.last.id_wilayah, idDapil: @dapil2.id)

    @dapil3 = FactoryBot.create(:dapil, id: 4, nama: "SUMATERA SELATAN I", idWilayah: Regency.last.id_wilayah, tingkat: 1)
    FactoryBot.create(:dapil_wilayah, id: 5, namaWilayah: "MUSI BANYUASIN", idWilayah: Regency.last.id_wilayah, idDapil: @dapil3.id)

    @dapil4 = FactoryBot.create(:dapil, id: 6, nama: "MUSI BANYUASIN 1", tingkat: 2)
    FactoryBot.create(:dapil_wilayah, id: 7, namaWilayah: "SEKAYU", idWilayah: District.last.id_wilayah, idDapil: @dapil4.id)

    # Create Political Party
    @p1 = FactoryBot.create :political_party
    @p2 = FactoryBot.create :political_party
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/1d510eef-9f93-4928-9da1-1adb4f76ec2e/5-PERHITUNGAN-explore-data-DPR-RI?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/c0959794-e28e-4831-9a4b-29115182cf95/5-PERHITUNGAN-explore-data-DPD?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/f0b9def0-0d56-4b78-9005-5f83b1ac4aea/5-PERHITUNGAN-explore-data-DPRD-provinsi-?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/baf1b2cd-d9dd-48b2-9489-af70f6b73ca6/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/provinces" do
    it "should return 200" do
      get "/hitung/v1/provinces"
      expect(response.status).to eq(200)
      expect(json_response[:data][:provinces][0][:name]).to eq("SUMATERA SELATAN")
    end
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/c75c43c2-1fcf-455d-9778-5818710e3de1/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] /hitung/v1/regencies" do
    it "should return 200" do
      get "/hitung/v1/regencies?page=1&province_code=16"
      expect(response.status).to eq(200)
      expect(json_response[:data][:regencies][0][:name]).to eq("MUSI BANYUASIN")
    end
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/4b9c21bc-241b-40d9-8376-15066fa51b41/5-PERHITUNGAN-explore-data-DPR-RI-Dapil?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/163d3adc-235b-46d3-ab42-203e90f1b1c4/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-?fullscreen
  describe "[GET] /hitung/v1/dapils/region" do
    describe "DPD" do
      context "when tingkat is DPD and province not found" do
        it "should error return 422 and show error messages" do
          get "/hitung/v1/dapils/region", params: {
                                              province_code: 2,
                                              regency_code: Regency.last.code,
                                              district_code: District.last.code,
                                              tingkat: "dpd",
                                            }
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)["error"]["errors"]).to eq(["Provinsi tidak ditemukan"])
        end
      end

      context "when tingkat is DPD and regency not found" do
        it "should error return 422 and show error messages" do
          get "/hitung/v1/dapils/region", params: {
                                              province_code: Province.last.code,
                                              regency_code: 1,
                                              district_code: District.last.code,
                                              tingkat: "dpd",
                                            }
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)["error"]["errors"]).to eq(["Kabupaten tidak ditemukan"])
        end
      end

      context "when tingkat is DPD and district not found" do
        it "should error return 422 and show error messages" do
          get "/hitung/v1/dapils/region", params: {
                                              province_code: Province.last.code,
                                              regency_code: Regency.last.code,
                                              district_code: 212,
                                              tingkat: "dpd",
                                            }
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)["error"]["errors"]).to eq(["Kecamatan tidak ditemukan"])
        end
      end

      context "when tingkat is DPD and province is sumatera selatan" do
        it "should return 200 and dapil is SUMATERA SELATAN" do
          # FactoryBot.create(:dapil, nama: "SUMATERA SELATAN", tingkat: "dpd", idWilayah: Province.last.id_wilayah)
          get "/hitung/v1/dapils/region", params: {
                                              province_code: Province.last.code,
                                              regency_code: Regency.last.code,
                                              district_code: District.last.code,
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
          # dapil = FactoryBot.create(:dapil, nama: "SUMATERA SELATAN I", idWilayah: Regency.last.id_wilayah, tingkat: 0)
          # FactoryBot.create(:dapil_wilayah, namaWilayah: "MUSI BANYUASIN", idWilayah: Regency.last.id_wilayah, idDapil: dapil.id)
          get "/hitung/v1/dapils/region", params: {
                                              province_code: Province.last.code,
                                              regency_code: Regency.last.code,
                                              district_code: District.last.code,
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
          # dapil = FactoryBot.create(:dapil, nama: "SUMATERA SELATAN  9", tingkat: 1)
          # FactoryBot.create(:dapil_wilayah, namaWilayah: "MUSI BANYUASIN", idWilayah: Regency.last.id_wilayah, idDapil: dapil.id)
          get "/hitung/v1/dapils/region", params: {
                                              province_code: Province.last.code,
                                              regency_code: Regency.last.code,
                                              district_code: District.last.code,
                                              tingkat: "provinsi",
                                            }

          expect(response.status).to eq(200)
          expect(json_response[:data][:nama]).to eq("SUMATERA SELATAN I")
          expect(json_response[:data][:tingkat]).to eq("provinsi")
        end
      end
    end

    describe "DPRD KAB" do
      context "when tingkat is DPRD KAB and district is Sekayu" do
        it "should return 200 and dapil is MUSI BANYUASIN 1" do
          # dapil = FactoryBot.create(:dapil, nama: "MUSI BANYUASIN 1", tingkat: 2)
          # FactoryBot.create(:dapil_wilayah, namaWilayah: "SEKAYU", idWilayah: District.last.id_wilayah, idDapil: dapil.id)
          get "/hitung/v1/dapils/region", params: {
                                              province_code: Province.last.code,
                                              regency_code: Regency.last.code,
                                              district_code: District.last.code,
                                              tingkat: "kabupaten",
                                            }

          expect(response.status).to eq(200)
          expect(json_response[:data][:nama]).to eq("MUSI BANYUASIN 1")
          expect(json_response[:data][:tingkat]).to eq("kabupaten")
        end
      end
    end

  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/88e4a752-682d-49b6-956a-f0edff605321/5-PERHITUNGAN-explore-data-DPR-RI-Dapil-DKI-JAKART?fullscreen
  describe "[GET] Persentase DPR RI /hitung/v1/summary/candidates/show?dapil_id=1&level=0" do
    context "When a TPS has multiple votes" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 1, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil2.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil2.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 100, },
            { id: @candidate2.id, total_vote: 200, },
          ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 150 },
            { id: @candidate2.id, total_vote: 250 }
          ]
        parties1 = [
          { id: @p1.id, total_vote: 10 },
          { id: @p2.id, total_vote: 20 }
        ]
        parties2 = [
          { id: @p1.id, total_vote: 15 },
          { id: @p2.id, total_vote: 25 }
        ]
        build_calculation @real_count1, "dpr", 10, candidates1, parties1
        build_calculation @real_count2, "dpr", 10, candidates2, parties2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil2.id}&level=0"
        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(perc_1).to eq(2.525)
        expect(json_response[:data][:valid_vote]).to eq(386)

        # Valid Vote Candidate 1
        expect(json_response[:data][:percentages][0][:pv]).to eq(13)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(125)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(138)
        expect(perc_2).to eq(34.848)

        # Valid Vote Candidate 2
        expect(json_response[:data][:percentages][1][:pv]).to eq(23)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(225)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(248)
        expect(perc_3).to eq(62.626)

        expect(total_percentage.ceil).to eq(100)
      end
    end

    context "Summary for All TPS" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 2, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil2.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil2.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 100, },
            { id: @candidate2.id, total_vote: 200, },
          ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 150 },
            { id: @candidate2.id, total_vote: 250 }
          ]
        parties1 = [
          { id: @p1.id, total_vote: 10 },
          { id: @p2.id, total_vote: 20 }
        ]
        parties2 = [
          { id: @p1.id, total_vote: 15 },
          { id: @p2.id, total_vote: 25 }
        ]
        build_calculation @real_count1, "dpr", 10, candidates1, parties1
        build_calculation @real_count2, "dpr", 10, candidates2, parties2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil2.id}&level=0"
        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(20)
        expect(perc_1).to eq(2.532)
        expect(json_response[:data][:valid_vote]).to eq(770)

        # Valid Vote Candidate 1
        expect(json_response[:data][:percentages][0][:pv]).to eq(25)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(250)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(275)
        expect(perc_2).to eq(34.81)

        # Valid Vote Candidate 2
        expect(json_response[:data][:percentages][1][:pv]).to eq(45)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(450)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(495)
        expect(perc_3).to eq(62.658)

        expect(total_percentage.ceil).to eq(100)
      end
    end
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/ca77829d-106b-488b-9c75-80282d240fe2/5-PERHITUNGAN-explore-data-DPD-DKI-Jakarta-01?fullscreen
  describe "[GET] Persentase DPD /hitung/v1/summary/candidates/show?dapil_id=2&level=3" do
    context "When a TPS has multiple votes" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 1, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil1.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil1.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 10, },
            { id: @candidate2.id, total_vote: 20, },
          ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 15 },
            { id: @candidate2.id, total_vote: 25 }
          ]
        build_calculation @real_count1, "dpd", 10, candidates1
        build_calculation @real_count2, "dpd", 10, candidates2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil1.id}&level=3"
        expect(response.status).to eq(200)

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(perc_1).to eq(21.739)
        expect(json_response[:data][:valid_vote]).to eq(36)

        # Valid Vote Candidate 1
        expect(json_response[:data][:percentages][0][:cv]).to eq(13)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(13)
        expect(perc_2).to eq(28.261)

        # Valid Vote Candidate 2
        expect(json_response[:data][:percentages][1][:cv]).to eq(23)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(23)
        expect(perc_3).to eq(50.0)

        expect(total_percentage.ceil).to eq(100)
      end
    end
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/1deb1e05-69e1-4025-9d99-7cbcf0546264/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-DKI?fullscreen
  describe "[GET] Persentase DPRD Provinsi /hitung/v1/summary/candidates/show?dapil_id=XX&level=1" do
    context "When a TPS has multiple votes" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 1, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil3.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil3.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 10, },
            { id: @candidate2.id, total_vote: 20, },
          ]
        parties1 = [
          { id: @p1.id, total_vote: 10 },
          { id: @p2.id, total_vote: 20 }
        ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 15 },
            { id: @candidate2.id, total_vote: 25 }
          ]
        parties2 = [
          { id: @p1.id, total_vote: 15 },
          { id: @p2.id, total_vote: 25 }
        ]
        build_calculation @real_count1, "provinsi", 10, candidates1, parties1
        build_calculation @real_count2, "provinsi", 10, candidates2, parties2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil3.id}&level=1"
        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(perc_1).to eq(12.195)
        expect(json_response[:data][:valid_vote]).to eq(72)

        # Valid Vote Candidate 1
        expect(json_response[:data][:percentages][0][:pv]).to eq(13)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(13)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(26)
        expect(perc_2).to eq(31.707)

        # Valid Vote Candidate 2
        expect(json_response[:data][:percentages][1][:pv]).to eq(23)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(23)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(46)
        expect(perc_3).to eq(56.098)

        expect(total_percentage.ceil).to eq(100)
      end
    end

    context "Summary for All TPS" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 2, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil3.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil3.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 10, },
            { id: @candidate2.id, total_vote: 20, },
          ]
        parties1 = [
          { id: @p1.id, total_vote: 10 },
          { id: @p2.id, total_vote: 20 }
        ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 15 },
            { id: @candidate2.id, total_vote: 25 }
          ]
        parties2 = [
          { id: @p1.id, total_vote: 15 },
          { id: @p2.id, total_vote: 25 }
        ]
        build_calculation @real_count1, "provinsi", 10, candidates1, parties1
        build_calculation @real_count2, "provinsi", 10, candidates2, parties2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil3.id}&level=1"

        sorted_json = json_response[:data][:percentages].sort_by { |val| val[:id].to_i }

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = sorted_json[0][:percentage]
        perc_3 = sorted_json[1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(20)
        expect(perc_1).to eq(12.5)
        expect(json_response[:data][:valid_vote]).to eq(140)

        # Valid Vote Candidate 1
        expect(sorted_json[0][:pv]).to eq(25)
        expect(sorted_json[0][:candidates][0][:cv]).to eq(25)
        expect(sorted_json[0][:total_vote]).to eq(50)
        expect(perc_2).to eq(31.25)

        # Valid Vote Candidate 2
        expect(sorted_json[1][:pv]).to eq(45)
        expect(sorted_json[1][:candidates][0][:cv]).to eq(45)
        expect(sorted_json[1][:total_vote]).to eq(90)
        expect(perc_3).to eq(56.25)

        expect(total_percentage.ceil).to eq(100)
      end
    end
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/187f3210-1d7c-4393-9947-1357923cdb3e/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] Persentase DPRD Kabupaten /hitung/v1/summary/candidates/show?dapil_id=XX&level=2" do
    context "When a TPS has multiple votes" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 1, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil4.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil4.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 100, },
            { id: @candidate2.id, total_vote: 200, },
          ]
        parties1 = [
          { id: @p1.id, total_vote: 10 },
          { id: @p2.id, total_vote: 20 }
        ]
        parties2 = [
          { id: @p1.id, total_vote: 15 },
          { id: @p2.id, total_vote: 25 }
        ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 150 },
            { id: @candidate2.id, total_vote: 250 }
          ]
        build_calculation @real_count1, "kabupaten", 10, candidates1, parties1
        build_calculation @real_count2, "kabupaten", 10, candidates2, parties2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil4.id}&level=2"
        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(perc_1).to eq(2.525)
        expect(json_response[:data][:valid_vote]).to eq(386)

        # Valid Vote Candidate 1
        expect(json_response[:data][:percentages][0][:pv]).to eq(13)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(125)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(138)
        expect(perc_2).to eq(34.848)

        # Valid Vote Candidate 2
        expect(json_response[:data][:percentages][1][:pv]).to eq(23)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(225)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(248)
        expect(perc_3).to eq(62.626)

        expect(total_percentage.ceil).to eq(100)
      end
    end

    context "Summary for ALL TPS" do
      before do
        @real_count1 = populate_real_count @user1, 1, @region_sumsel
        @real_count2 = populate_real_count @user1, 2, @region_sumsel
        @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil4.id)
        @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil4.id)
        candidates1 = [
            { id: @candidate1.id, total_vote: 100, },
            { id: @candidate2.id, total_vote: 200, },
          ]
        parties1 = [
          { id: @p1.id, total_vote: 10 },
          { id: @p2.id, total_vote: 20 }
        ]
        parties2 = [
          { id: @p1.id, total_vote: 15 },
          { id: @p2.id, total_vote: 25 }
        ]
        candidates2 = [
            { id: @candidate1.id, total_vote: 150 },
            { id: @candidate2.id, total_vote: 250 }
          ]
        build_calculation @real_count1, "kabupaten", 10, candidates1, parties1
        build_calculation @real_count2, "kabupaten", 10, candidates2, parties2
      end
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil4.id}&level=2"

        sorted_json = json_response[:data][:percentages].sort_by { |val| val[:id].to_i }

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = sorted_json[0][:percentage]
        perc_3 = sorted_json[1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        # Invalid Vote
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(20)
        expect(perc_1).to eq(2.532)
        expect(json_response[:data][:valid_vote]).to eq(770)

        # Valid Vote Candidate 1
        expect(sorted_json[0][:pv]).to eq(25)
        expect(sorted_json[0][:candidates][0][:cv]).to eq(250)
        expect(sorted_json[0][:total_vote]).to eq(275)
        expect(perc_2).to eq(34.81)

        # Valid Vote Candidate 2
        expect(sorted_json[1][:pv]).to eq(45)
        expect(sorted_json[1][:candidates][0][:cv]).to eq(450)
        expect(sorted_json[1][:total_vote]).to eq(495)
        expect(perc_3).to eq(62.658)

        expect(total_percentage.ceil).to eq(100)
      end
    end

  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/8c38c7e7-5812-44b6-b513-5cc0bdda0a48/5-PERHITUNGAN-explore-data-DPR-RI-Dapil-DKI-JAKART?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/47a15c15-1ced-4171-acfc-c6d541cca844/5-PERHITUNGAN-explore-data-DPD-DKI-Jakarta-01-user?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/cf7e253e-9b3b-45fb-b819-40667a71fda0/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-DKI?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/3777025d-f6a3-49d8-b238-6c037a89e7ad/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] TPS List /hitung/v1/real_counts?dapil_id=XX by Dapil ID" do
    before do
      @real_count1 = populate_real_count @user1, 1, @region_sumsel
      @real_count2 = populate_real_count @user1, 2, @region_sumsel
      @candidate1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil4.id)
      @candidate2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil4.id)
      candidates1 = [
          { id: @candidate1.id, total_vote: 100, },
          { id: @candidate2.id, total_vote: 200, },
        ]
      parties1 = [
        { id: @p1.id, total_vote: 10 },
        { id: @p2.id, total_vote: 20 }
      ]
      parties2 = [
        { id: @p1.id, total_vote: 15 },
        { id: @p2.id, total_vote: 25 }
      ]
      candidates2 = [
          { id: @candidate1.id, total_vote: 150 },
          { id: @candidate2.id, total_vote: 250 }
        ]
      build_calculation @real_count1, "kabupaten", 10, candidates1, parties1
      build_calculation @real_count2, "kabupaten", 10, candidates2, parties2
    end
    it "success" do
      get "/hitung/v1/real_counts?dapil_id=#{@dapil4.id}"
      expect(json_response[:data][:real_counts][0][:id]).to eq(@real_count2.id)
      expect(json_response[:data][:real_counts][1][:id]).to eq(@real_count1.id)
      expect(json_response[:data][:real_counts][0][:tps]).to eq(2)
      expect(json_response[:data][:real_counts][1][:tps]).to eq(1)
      expect(json_response[:data][:real_counts].map {|a| a[:province_code] }.uniq.join.to_i).to eq(16)
      expect(json_response[:data][:real_counts].map {|a| a[:province] }.map {|v| v[:name] }.uniq.join).to eq("SUMATERA SELATAN")
      expect(json_response[:data][:real_counts].map {|a| a[:regency] }.map {|v| v[:name] }.uniq.join).to eq("MUSI BANYUASIN")
      expect(json_response[:data][:real_counts].map {|a| a[:district] }.map {|v| v[:name] }.uniq.join).to eq("SEKAYU")
      expect(json_response[:data][:real_counts].map {|a| a[:village] }.map {|v| v[:name] }.uniq.join).to eq("Serasan Jaya")
    end
  end

  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/45c3f244-8650-4fca-b3fd-3a042189f792/5-PERHITUNGAN-explore-data-DPR-RI-Dapil-DKI-JAKART?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/fb09a0ed-c558-4b81-bb84-9a7c3556bb45/5-PERHITUNGAN-explore-data-DPD-DKI-Jakarta-01-user?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/37396cb6-f995-4613-a73a-231e2459cc7a/5-PERHITUNGAN-explore-data-DPRD-provinsi-Dapil-DKI?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/5f1131fa-4ed2-4638-9dfa-f74857300655/5-PERHITUNGAN-explore-data-DPRD-kabupaten-kota-Kab?fullscreen
  describe "[GET] Perhitungan per TPS /hitung/v1/summary/candidates/show?hitung_real_count_id=YOUR_UUID&dapil_id=XX&level=X" do
    before do
      @real_count1 = populate_real_count @user1, 1, @region_sumsel

      @candidate_dpr_ri1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil2.id)
      @candidate_dpr_ri2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil2.id)

      @candidate_dprd_prov1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil3.id)
      @candidate_dprd_prov2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil3.id)

      @candidate_dprd_kab1 = FactoryBot.create(:candidate, political_party_id: @p1.id,  electoral_district_id: @dapil4.id)
      @candidate_dprd_kab2 = FactoryBot.create(:candidate, political_party_id: @p2.id, electoral_district_id: @dapil4.id)

      @candidate_dpd1 = FactoryBot.create(:candidate, political_party_id: nil,  electoral_district_id: @dapil1.id)
      @candidate_dpd2 = FactoryBot.create(:candidate, political_party_id: nil, electoral_district_id: @dapil1.id)

      @candidates_dpr_ri = [
        { id: @candidate_dpr_ri1.id, total_vote: 100, },
        { id: @candidate_dpr_ri2.id, total_vote: 200, },
      ]
      @candidates_dprd_prov = [
        { id: @candidate_dprd_prov1.id, total_vote: 100, },
        { id: @candidate_dprd_prov2.id, total_vote: 200, },
      ]
      @candidates_drpd_kab = [
          { id: @candidate_dprd_kab1.id, total_vote: 100, },
          { id: @candidate_dprd_kab2.id, total_vote: 200, },
      ]
      @candidates_dpd = [
          { id: @candidate_dpd1.id, total_vote: 100, },
          { id: @candidate_dpd2.id, total_vote: 200, },
      ]
      @parties1 = [
        { id: @p1.id, total_vote: 10 },
        { id: @p2.id, total_vote: 20 }
      ]

      build_calculation @real_count1, "dpr", 10, @candidates_dpr_ri, @parties1
      build_calculation @real_count1, "provinsi", 10, @candidates_dprd_prov, @parties1
      build_calculation @real_count1, "kabupaten", 10, @candidates_drpd_kab, @parties1
      build_calculation @real_count1, "dpd", 10, @candidates_dpd

    end

    context "When Level DPR RI" do
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil2.id}&level=0&hitung_real_count_id=#{@real_count1.id}"
        expect(response.status).to eq(200)
        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(json_response[:data][:valid_vote]).to eq(330)

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        expect(json_response[:data][:percentages][0][:candidates][0][:name]).to eq(@candidate_dpr_ri1.name)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(100)
        expect(json_response[:data][:percentages][0][:pv]).to eq(10)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(110)
        expect(perc_2).to eq(32.353)

        expect(json_response[:data][:percentages][1][:candidates][0][:name]).to eq(@candidate_dpr_ri2.name)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(200)
        expect(json_response[:data][:percentages][1][:pv]).to eq(20)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(220)
        expect(perc_3).to eq(64.706)
      end
    end

    context "When Level DPRD Provinsi" do
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil3.id}&level=1&hitung_real_count_id=#{@real_count1.id}"
        expect(response.status).to eq(200)

        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(json_response[:data][:valid_vote]).to eq(330)

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        expect(json_response[:data][:percentages][0][:candidates][0][:name]).to eq(@candidate_dprd_prov1.name)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(100)
        expect(json_response[:data][:percentages][0][:pv]).to eq(10)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(110)
        expect(perc_2).to eq(32.353)

        expect(json_response[:data][:percentages][1][:candidates][0][:name]).to eq(@candidate_dprd_prov2.name)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(200)
        expect(json_response[:data][:percentages][1][:pv]).to eq(20)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(220)
        expect(perc_3).to eq(64.706)
      end
    end

    context "When Level Kabupaten" do
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil4.id}&level=2&hitung_real_count_id=#{@real_count1.id}"
        expect(response.status).to eq(200)

        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(json_response[:data][:valid_vote]).to eq(330)

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        expect(json_response[:data][:percentages][0][:candidates][0][:name]).to eq(@candidate_dprd_kab1.name)
        expect(json_response[:data][:percentages][0][:candidates][0][:cv]).to eq(100)
        expect(json_response[:data][:percentages][0][:pv]).to eq(10)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(110)
        expect(perc_2).to eq(32.353)

        expect(json_response[:data][:percentages][1][:candidates][0][:name]).to eq(@candidate_dprd_kab2.name)
        expect(json_response[:data][:percentages][1][:candidates][0][:cv]).to eq(200)
        expect(json_response[:data][:percentages][1][:pv]).to eq(20)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(220)
        expect(perc_3).to eq(64.706)

        expect(total_percentage).to eq(100)
      end
    end

    context "When Level DPD" do
      it "success" do
        get "/hitung/v1/summary/candidates/show?dapil_id=#{@dapil1.id}&level=3&hitung_real_count_id=#{@real_count1.id}"
        expect(response.status).to eq(200)

        expect(json_response[:data][:invalid_vote][:total_vote]).to eq(10)
        expect(json_response[:data][:valid_vote]).to eq(300)

        perc_1 = json_response[:data][:invalid_vote][:percentage]
        perc_2 = json_response[:data][:percentages][0][:percentage]
        perc_3 = json_response[:data][:percentages][1][:percentage]
        total_percentage = perc_1 + perc_2 + perc_3

        expect(json_response[:data][:percentages][0][:name]).to eq(@candidate_dpd1.name)
        expect(json_response[:data][:percentages][0][:cv]).to eq(100)
        expect(json_response[:data][:percentages][0][:total_vote]).to eq(100)
        expect(perc_2).to eq(32.258)

        expect(json_response[:data][:percentages][1][:name]).to eq(@candidate_dpd2.name)
        expect(json_response[:data][:percentages][1][:cv]).to eq(200)
        expect(json_response[:data][:percentages][1][:total_vote]).to eq(200)
        expect(perc_3).to eq(64.516)

        expect(total_percentage).to eq(100)
      end
    end

  end

  def populate_region_sumsel
    FactoryBot.create :province, id: 16, code: 16, name: "SUMATERA SELATAN", level: 1, id_wilayah: 17404
    FactoryBot.create :regency, id: 1606, province_id: 16, code: 1606, name: "MUSI BANYUASIN", level: 2, id_wilayah: 18942, id_parent: 17404
    FactoryBot.create :district, id: 160601, regency_code: 1606, code: 160601, name: "SEKAYU", id_parent: 18942, id_wilayah: 18943, level: 3
    FactoryBot.create :village, id: 1606011010, code: 1606011010, district_code: 160601, name: "Serasan Jaya"
  end

  def populate_real_count user, tps, region
    FactoryBot.create :hitung_real_count, tps: tps,
                                          status: "published",
                                          user_id: user.id,
                                          province_code: region[:province_code],
                                          regency_code: region[:regency_code],
                                          district_code: region[:district_code],
                                          village_code: region[:village_code]
  end

  def build_calculation(real_count, calculation_type, invalid_vote, candidates, parties = nil)
    p = {
      hitung_real_count_id: real_count.id,
      calculation_type: calculation_type,
      invalid_vote: invalid_vote,
      candidates: candidates,
    }
    p[:parties] = parties if parties.present?
    put "/hitung/v1/calculations/", headers: stub_auth_headers(@access_token),
                                  params: p
    [response, json_response]
  end

end
