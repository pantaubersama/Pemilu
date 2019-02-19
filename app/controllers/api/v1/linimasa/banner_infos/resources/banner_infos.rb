class API::V1::Linimasa::BannerInfos::Resources::BannerInfos < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "banner_infos" do
    desc "List banner", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    get do
      banners = BannerInfo.all
      present :banner_infos, banners, with: API::V1::Dashboard::BannerInfos::Entities::BannerInfo
    end

    desc "Get banner by page name", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      requires :page_name, type: String, values: ["pilpres", "janji politik", "tanya", "kuis","lapor", "debat", "tantangan", "perhitungan","my_input", "rekapitulasi"]
    end
    get :show do
      banner = nil
      if params.page_name.eql?("pilpres")
        banner = BannerInfo.find("ade8d637-e85e-4726-8005-6cede80ea860")
      elsif params.page_name.eql?("janji politik")
        banner = BannerInfo.find("5d01f7ab-4c90-4199-999b-da5287d06a88")
      elsif params.page_name.eql?("tanya")
        banner = BannerInfo.find("a22d2acd-7eda-4a7a-95a0-931abf5db8e3")
      elsif params.page_name.eql?("kuis")
        banner = BannerInfo.find("9b98ac07-3208-4d60-976e-49ace39e38a7")
      elsif params.page_name.eql?("lapor")
        banner = BannerInfo.find("f84a0010-b981-4d1c-8bb0-9e599eac1c12")
      elsif params.page_name.eql?("debat")
        banner = BannerInfo.find("c89eea96-4616-46a6-a25b-040e5ecf2dfd")
      elsif params.page_name.eql?("tantangan")
        banner = BannerInfo.find("650a3d88-2f0e-403d-a94f-45ed878779a7")
      elsif params.page_name.eql?("perhitungan")
        banner = BannerInfo.find("90495b56-414d-4865-9765-867ecfb14966")
      elsif params.page_name.eql?("my_input")
        banner = BannerInfo.find("8880dbe8-3324-4f7a-b3f6-8e97af355def")
      elsif params.page_name.eql?("rekapitulasi")
        banner = BannerInfo.find("1f4d3106-f0a3-4ede-a271-441b788f6a6e")
      end
      error!("Record banner info tidak ditemukan", 422) unless banner
      present :banner_info, banner, with: API::V1::Dashboard::BannerInfos::Entities::BannerInfo
    end
  end
end
