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
      requires :page_name, type: String, values: ["pilpres", "janji politik", "tanya", "kuis"]
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
      end
      error!("Record banner info tidak ditemukan", 422) unless banner
      present :banner_info, banner, with: API::V1::Dashboard::BannerInfos::Entities::BannerInfo
    end
  end
end
