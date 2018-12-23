class API::V1::Linimasa::Crowlings::Resources::Crowlings < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "crowlings" do
    desc "Tambah Username", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :keywords, type: String, desc: "twitter username ex: @namakukingkong"
      requires :team, type: Integer, values: [1, 2]
    end
    post "twitter/linimasa" do
      crowling = Crowling.new(params)
      unless crowling.save
        error!(crowling.errors.full_messages.join(", "), 422)
      end
      present :crowling, crowling, with: API::V1::Linimasa::Crowlings::Entities::Crowling
    end

    desc "List crowlings", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: 100, max_per_page: 500
    get do
      crowlings = Crowling.all
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
      crowling = Crowling.find(params.id)
      unless crowling.delete
        error!(crowling.errors.full_messages.join(", "), 422)
      end
      response = { message: "Crowling id #{params.id} berhasil dihapus" }
      present response
    end
  end
end
