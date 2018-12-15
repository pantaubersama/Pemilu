Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Lini Masa (InitLinimasa), Pendidikan Politik (InitPendidikanPolitik), Lapor(InitLapor), Hitung (InitHitung)
  mount API::InitLinimasa, at: "/linimasa"
  mount API::InitPendidikanPolitik, at: "/pendidikan_politik"
  mount API::InitLapor, at: "/lapor"
  mount API::InitHitung, at: "/hitung"
  mount GrapeSwaggerRails::Engine, as: "doc", at: "/doc"
end
