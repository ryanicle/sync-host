require 'json'

configs = JSON.parse(File.read(File.expand_path( File.dirname( __FILE__ )) + '/config.json'))


configs.each do |config|
  source_path = config['source_path']
  destination_path = config['username'] + '@' + config['host'] + ':' + config['destination_path']
  
  dirs = config['exclude'].split(',')
  exclude_list = ''
  dirs.each do |dir|
    exclude_list += '--exclude=' + dir + ' '
  end

  puts 'Syncing starts at ' + Time.now.to_s
  cmd = 'sshpass -p "' + config['password'] + '" rsync -avr --no-p --delete --keep-dirlinks ' + exclude_list + ' ' + config['source_path'] + ' ' + destination_path
  puts cmd
  system(cmd)
  puts 'Syncing ends at ' + Time.now.to_s
end