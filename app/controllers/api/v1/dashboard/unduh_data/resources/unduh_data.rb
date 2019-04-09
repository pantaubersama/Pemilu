module API::V1::Dashboard::UnduhData::Resources
  class UnduhData < API::V1::ApplicationResource
    helpers API::V1::Helpers
    before do
      authorize_admin!
    end
    resource "unduh_data" do
      desc "list request unduh data" do
        detail "list request unduh data"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      get "/list_request" do
        unduh_datas = RequestDatum.all.order("created_at desc")
        resources = paginate(unduh_datas)
        present :unduh_datas, resources
        present_metas resources
      end

      desc "show request unduh data" do
        detail "show request unduh data"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      get "/request/:id" do
        r = RequestDatum.find params.id
        present :unduh_data, r
      end

    end
  end
end
