module API::V1::Hitung::Summary::Resources
  class Contribution < API::V1::ApplicationResource
    resource "summary" do
      desc "Total contribution" do
        detail "Total contribution"
      end
      get "contribution" do
        total = ::Hitung::RealCount.count('distinct user_id')
        present :total, total
      end
    end
  end
end
