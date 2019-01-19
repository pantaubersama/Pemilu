class API::V1::Dashboard::Linimasa::Resources::Crowlings < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "linimasa/crowling" do
    desc "Tambah Username", headers: AUTHORIZATION_HEADERS
    params do
      requires :keywords, type: String, desc: "twitter username ex: @namakukingkong"
      requires :team, type: Integer, values: [1, 2]
    end
    oauth2
    post "username" do
      authorize_admin!
      crowling = Crowling.new(params)
      unless crowling.save
        error!(crowling.errors.full_messages.join(", "), 422)
      end
      present :crowling, crowling, with: API::V1::Linimasa::Crowlings::Entities::Crowling
    end

    desc "List crowlings", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get do
      authorize_admin!
      crowlings = Crowling.all
      resources = paginate(crowlings)
      present :crowlings, resources, with: API::V1::Linimasa::Crowlings::Entities::Crowling
      present_metas resources
    end

    desc "List trash crowlings", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :trashes do
      authorize_admin!
      crowlings = Crowling.deleted
      resources = paginate(crowlings)
      present :crowlings, resources, with: API::V1::Linimasa::Crowlings::Entities::Crowling
      present_metas resources
    end

    desc "Delete crowling", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
    end
    delete do
      authorize_admin!
      crowling = Crowling.find(params.id)
      unless crowling.delete
        error!(crowling.errors.full_messages.join(", "), 422)
      end
      response = { message: "Crowling id #{params.id} berhasil dihapus" }
      present response
    end

    desc "Detail crowling", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
    end
    get "/:id" do
      authorize_admin!
      res = Crowling.find params[:id]
      present :crowling, res, with: API::V1::Linimasa::Crowlings::Entities::Crowling
    end
    
  end
end
