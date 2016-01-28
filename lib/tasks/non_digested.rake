namespace :assets do
  desc "Create copies as non digested assets"
  task :non_digested do
    assets = Dir.glob(File.expand_path('public/assets/**/.sprockets-manifest-*'))
    manifest_path = assets[0]
    manifest_data = JSON.load(File.new(manifest_path))

    manifest_data["assets"].each do |asset_name, file_name|
      if file_name =~ /.*\.html$/
        file_path  = File.expand_path(file_name, 'public/assets/')
        asset_path = File.expand_path(asset_name, 'public/assets/')
        FileUtils.cp(file_path, asset_path)
      end
    end
  end
end
