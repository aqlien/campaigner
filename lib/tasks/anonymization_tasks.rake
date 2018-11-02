require 'faker'

namespace :users do

  desc "Randomize all available data"
  task hide_all: :environment do
    hide_user_data([:email, :name, :phone])
  end

  desc "Randomize all non-admin names"
  task hide_names: :environment do
    hide_user_data([:name])
  end

  desc "Randomize all non-admin phone numbers"
  task hide_phones: :environment do
    hide_user_data([:phone])
  end

  desc "Randomize all non-admin email addresses"
  task hide_emails: :environment do
    hide_user_data([:email])
  end

  def hide_user_data(data_to_hide = [])
    User.where(admin: [nil, false]).each do |user|
      new_attrs = {}
      new_attrs[:email] = Faker::Internet.unique.email if data_to_hide.include?(:email)
      new_attrs[:name] = Faker::Name.name if data_to_hide.include?(:name) && !user.name.blank?
      new_attrs[:short_name] = Faker::Name.first_name if data_to_hide.include?(:name) && !user.short_name.blank?
      new_attrs[:phone] = Faker::PhoneNumber.phone_number.gsub(/\D/, '') if data_to_hide.include?(:phone) && !user.phone.blank?
      user.update_attributes(new_attrs)
    end
  end

end
