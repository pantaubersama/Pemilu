module API::V1::Hitung::UnduhData::Resources
  class UnduhData < API::V1::ApplicationResource
    resource "unduh_data" do
      desc "request unduh data" do
        detail "request unduh data"
      end
      params do
        optional :name, type: String, desc: "Nama"
        requires :email, type: String, desc: "Email"
        optional :organization, type: String, desc: "Komunitas/Organisasi"
        optional :phone, type: String, desc: "Nomor Handphone"
        optional :necessity, type: String, desc: "Keperluan Penggunaan Data"
      end
      post "/request" do
        request_unduh_data = RequestDatum.create(params)
        UnduhDataMailer.request_unduh_data(params).deliver_now
        present :unduh_data, request_unduh_data, with: API::V1::Hitung::UnduhData::Entities::UnduhData
      end
    end
  end
end
