module API::V1::Hitung::Summary::Resources
  class Contribution < API::V1::ApplicationResource
    resource "summary" do
      desc "contribution" do
        detail "contribution"
      end
      get "contribution" do
        total = ::Hitung::RealCount.published.count('distinct user_id')
        last_update = ::Hitung::RealCount.published.order('created_at desc').first
        present :total, total
        present :last_update, last_update, with: API::V1::Hitung::Summary::Entities::LastUpdate
      end
    end
  end
end
