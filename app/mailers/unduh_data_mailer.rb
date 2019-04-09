class UnduhDataMailer < ApplicationMailer

  def request_unduh_data(data)
    @data = data
    mail(to: ENV['EMAIL_CONTACT_PANTAU'], from: data['email'], subject: 'Request Unduh Data')
  end
end
