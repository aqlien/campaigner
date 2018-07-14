# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.find_or_create_by!(name: 'System Admin', short_name: 'Admin', admin: true, email: "admin@#{ENV['ROOT_DOMAIN']}") do |u|
  admin_password = User.secure_password
  u.password = admin_password
  u.password_confirmation = admin_password
end

if ENV['SEED_WITH'] == 'existing_data'
  # import categories
  categories_list = YAML.load_file(File.join(Rails.root, 'db', 'data', 'categories.yml'))['categories']
  categories_list.each do |index, hash|
    Category.find_or_create_by(name: hash['name']) do |c|
      c.short_name = hash['short_name']
    end
  end

  # import events
  # Event.create!(name: 'Families Belong Together', start_date: '2018/06/30', end_date: '2018/07/07')

  # import organizations
  categories = Category.all.order(name: :asc)
  organizations_list = YAML.load_file(File.join(Rails.root, 'db', 'data', 'organizations.yml'))['organizations']
  organizations_list.each do |index, hash|
    Organization.find_or_create_by(name: hash['name']) do |o|
      o.short_name = hash['short_name']
      o.url = hash['url']
      o.categories << categories.find_or_create_by(name: hash['category'])
    end
  end
end

if ENV['SEED_WITH'] == 'fake_users'
  first_names = ['Armani', 'Maeve', 'Ana', 'Kathryn', 'Phoenix', 'Marley', 'Mariah', 'Kaylen', 'Kelly', 'Dania', 'Sierra', 'Olivia',
    'Alayna', 'Zariah', 'Charlee', 'Priscilla', 'Katie', 'Bailey', 'Corinne', 'Dixie', 'Aliyah', 'Elaine', 'Sabrina', 'Sophia',
    'Isla', 'Gianna', 'Deanna', 'Jasmine', 'Sophie', 'Rayne', 'Kaylah', 'Monica', 'Joyce', 'Nina', 'Jayleen', 'Celia', 'Presley',
    'Kiley', 'Belen', 'Julie', 'Alondra', 'Paige', 'Kennedy', 'Haley', 'Brynn', 'Kaydence', 'Carleigh', 'Chanel', 'Adelaide', 'Tris'
  ]
  last_names = ['Diaz', 'Jones', 'Smith', 'Wu', 'Lin', 'Jackson', nil, nil, nil]
  first_names.each do |first_name|
    pass = User.secure_password
    User.create(
      name: [first_name, last_names.sample].join(' '),
      short_name: first_name,
      email: "#{first_name}#{rand(100)}@fake-email.com",
      password: pass,
      password_confirmation: pass
    )
  end
end
