class VM < Thor

  desc 'ip', 'Show IP of running VirtualBox'
  def ip
    ips = `VBoxManage list runningvms`.split("\n").map do |line|
      `VBoxManage guestproperty get #{line.match(/[^{]*{(.*)}/)[1]} /VirtualBox/GuestInfo/Net/0/V4/IP`.split(':').last.strip
    end
    raise "confused" unless ips.size == 1
    puts ips.first
  end

  # NB: http://spectlog.com/content/Log:Stuff/Use_cygwin_sshd_to_start_application_remotely_in_user_GUI_session

  desc 'exec [file.rb]', 'Sync source directory to a running VirtualBox host and execute ruby script'
  method_options :file => :string
  def exec(file)
    ips = `VBoxManage list runningvms`.split("\n").map do |line|
      `VBoxManage guestproperty get #{line.match(/[^{]*{(.*)}/)[1]} /VirtualBox/GuestInfo/Net/0/V4/IP`.split(':').last.strip
    end
    raise "confused" unless ips.size == 1
    system("rsync -avz -e ssh . #{ENV['USER']}@#{ips.first}:opine")
    system("ssh #{ENV['USER']}@#{ips.first} \"cd opine; bundle exec ruby #{file}\"")
  end
end
