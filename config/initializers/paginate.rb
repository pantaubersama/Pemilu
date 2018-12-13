ApiPagination.configure do |config|
  # If you have both gems included, you can choose a paginator.
  config.paginator = :kaminari # or :will_paginate

  # Optional: what parameter should be used to set the page option
  config.page_param = :page

  # Optional: what parameter should be used to set the per page option
  config.per_page_param = :per_page
end