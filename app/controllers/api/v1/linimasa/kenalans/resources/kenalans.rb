class API::V1::Linimasa::Kenalans::Resources::Kenalans < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "kenalans" do
    desc "List Kenalans", headers: AUTHORIZATION_HEADERS
    oauth2
    get do
      kenalans  = Kenalan.all
      responses = []
      kenalans.each do |kenalan|
        user_kenalan = UserKenalan.find_by(user_id: current_user.id, kenalan_id: kenalan.id)
        uk_response  = { action_at: nil,
                         is_action: false }
        if user_kenalan.present?
          uk_response = {
            action_at: user_kenalan.action_at,
            is_action: user_kenalan.is_action
          }
        end
        responses << {
          id:   kenalan.id,
          link: kenalan.link,
          text: kenalan.text
        }.merge(uk_response)
      end

      present :kenalans, responses, with: API::V1::Linimasa::Kenalans::Entities::UserKenalan
    end
    desc "List Kenalans", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String, desc: "Kenalan ID"
    end
    put do
      UserKenalan.find_or_create_by(user_id: current_user.id, kenalan_id: params.id)
      kenalans  = Kenalan.all
      responses = []
      kenalans.each do |kenalan|
        user_kenalan = UserKenalan.find_by(user_id: current_user.id, kenalan_id: kenalan.id)
        uk_response  = { action_at: nil,
                         is_action: false }
        if user_kenalan.present?
          uk_response = { action_at: user_kenalan.action_at,
                          is_action: user_kenalan.is_action }
        end
        responses << {
          id:   kenalan.id,
          link: kenalan.link,
          text: kenalan.text
        }.merge(uk_response)
      end

      present :kenalans, responses, with: API::V1::Linimasa::Kenalans::Entities::UserKenalan
    end
  end
end
