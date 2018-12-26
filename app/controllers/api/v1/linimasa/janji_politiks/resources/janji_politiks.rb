class API::V1::Linimasa::JanjiPolitiks::Resources::JanjiPolitiks < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "janji_politiks" do
    desc "List janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: 100, max_per_page: 500
    get do
      resources = paginate(JanjiPolitik.all)
      present :janji_politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
      present_metas resources
    end

    desc "Create janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :title, type: String
      requires :body, type: String
      optional :image, type: File
    end
    post do
      authorize_eligible_user!
      resources = JanjiPolitik.new(params.merge({ user_id: current_user.id }))
      unless resources.save
        error!(resources.errors.full_messages.join(", "), 422)
      end
      present :janji_politik, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
    end

    desc "Upload image janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
      optional :image, type: File
    end
    put do
      authorize_eligible_user!
      resources      = JanjiPolitik.find_by(id: params.id, user_id: current_user.id)
      resource.image = params.image
      unless resources.save
        error!(resources.errors.full_messages.join(", "), 422)
      end
      present :janji_politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
    end

    desc "Delete janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
    end
    delete do
      authorize_eligible_user!
      resources = JanjiPolitik.find_by(id: params.id, user_id: current_user.id)
      unless resources.delete
        error!(resources.errors.full_messages.join(", "), 422)
      end
      response = { message: "Janji Politik id `#{params.id}` berhasil dihapus" }
      present response
    end
  end
end
