# Database
database = File.join(__dir__, 'development.db')
DataMapper.setup(:default, ENV['DATABASE_URL'] || File.join('sqlite://', database))
