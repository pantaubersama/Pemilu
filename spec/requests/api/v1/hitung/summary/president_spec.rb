
require "rails_helper"

RSpec.describe "Persentase perhitungan presiden", type: :request do
  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/f1b7208a-0bcb-4edb-ac27-015d49340012/5-REKAPITULASI-Rekapitulasi?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/9d5c9f28-1fd5-43da-9ca9-1d2ae95bb232/5-PERHITUNGAN-explore-data-presiden-?fullscreen
  describe "[GET] /hitung/v1/summary/president/show?level=0" do
    pending "Test me please"
  end

  describe "[GET] /hitung/v1/summary/president/list?level=0" do
    pending "Test me please"
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/9c851e22-4770-400d-b617-34102b8472b0/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/62f26e41-bd30-49ee-a4bb-475cc61e4c59/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/summary/president/list?level=1" do
    pending "Test me please"
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/06d6f44f-400f-4b29-ba62-609d20190202/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-1?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/039e54e1-9739-4cc1-aec4-2e6c1a384c0a/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/summary/president/list?level=2" do
    pending "Test me please"
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/28730419-a4ce-4521-9064-35dad7120943/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-2?fullscreen
  describe "[GET] /hitung/v1/summary/president/list?level=3" do
    pending "Test me please"
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/904ef1f9-20f8-41b7-b210-e301f3da09ba/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-4?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/f39bab29-8bc1-4fd3-a020-62ecec588bdd/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/real_counts?page=1&village_code=3375011004" do
    pending "Test me please"
  end

  # https://xd.adobe.com/view/91d02c33-58cd-442c-7d01-900a7724345b-e7e1/screen/c907ca27-3466-4872-8c9f-7cb24c6f11af/5-REKAPITULASI-Rekapitulasi-view-Yogyakarta-3?fullscreen
  # https://xd.adobe.com/view/84d8fe59-666f-4491-6a46-f8403070acf0-f2e9/screen/fce440ba-6cd4-4dcd-b6f5-67e3281ae661/5-PERHITUNGAN-explore-data-presiden-kabupaten-kota?fullscreen
  describe "[GET] /hitung/v1/real_counts/YOUR_UUID" do
    pending "Test me please"
  end

  describe "[GET] /hitung/v1/form_c1?hitung_real_count_id=YOUR_UUID&form_c1_type=presiden" do
    pending "Test me please"
  end

  describe "[GET] /hitung/v1/images?image_type=c1_presiden" do
    pending "Test me please"
  end

end
