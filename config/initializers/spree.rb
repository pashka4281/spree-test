# encoding: utf-8

# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
end

Spree.user_class = "Spree::User"

Spree::Config.set(:allow_ssl_in_production => false)
Spree::Auth::Config[:registration_step] = false;
Spree::Config[:address_requires_state] = false

customCurrency = {
  priority: 100,
  iso_code: "UAH",
  name: "Ukrainian Hryvna",
  symbol: "грн.",
  alternate_symbols: ["грн."],
  subunit: "копейки",
  subunit_to_unit: 100,
  symbol_first: true,
  html_entity: "",
  decimal_mark: ".",
  thousands_separator: ",",
  iso_numeric: "756"
}
Money::Currency.register(customCurrency)


Spree.config do |config|
  # Sets default country to UK
  config.default_country_id = 211
end