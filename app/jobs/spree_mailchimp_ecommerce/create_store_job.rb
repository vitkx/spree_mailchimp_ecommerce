module SpreeMailchimpEcommerce
  class CreateStoreJob < ApplicationJob
    def perform(mailchimp_setting)
      ::Gibbon::Request.new(api_key: mailchimp_setting.mailchimp_api_key).
        ecommerce.stores.create(body: {
                                  id: mailchimp_setting.mailchimp_store_id,
                                  list_id: mailchimp_setting.mailchimp_list_id,
                                  name: mailchimp_setting.mailchimp_store_name,
                                  currency_code: ::Spree::Store.default.default_currency || ::Spree::Config[:currency],
                                  domain: Spree::Store.default.url,
                                  email_address: mailchimp_setting.mailchimp_store_email
                                })
      MailchimpSetting.last.update(state: 'created')
    end
  end
end
