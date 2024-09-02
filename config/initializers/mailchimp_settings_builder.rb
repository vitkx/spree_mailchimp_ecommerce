Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
      Rails.application.config.spree_backend.main_menu.add_to_section('settings',
      ::Spree::Admin::MainMenu::ItemBuilder.new('admin.mailchimp_settings', ::Spree::Core::Engine.routes.url_helpers.admin_mailchimp_settings_path).
        with_manage_ability_check(::MailchimpSetting).
        build
      )
  end
end