namespace :reload do
  namespace :projects do
    task :run, [:force] => :environment do |t, args|
      Util::Updater.new.run
    end
  end
end
