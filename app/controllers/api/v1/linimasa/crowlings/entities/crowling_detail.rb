class API::V1::Linimasa::Crowlings::Entities::CrowlingDetail < API::V1::Linimasa::Crowlings::Entities::Crowling
  # expose :feed, API::V1::Linimasa::Feeds::Entities::Feed
  expose :feeds, with: API::V1::Linimasa::Feeds::Entities::Feed
end
