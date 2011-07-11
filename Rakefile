require 'rake'

def linkit(source, target)
  puts "installing #{source}"
  `ln -s "$PWD/#{source}" "#{target}"`
end

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('*/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink')
    target = "#{ENV["HOME"]}/.#{file.first}"

    if File.exists?(target) || File.symlink?(target)
      unless @force_install || skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all || @force_install
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    linkit(linkable, target) unless File.exists?(target) && File.symlink?(target)
  end
end

desc "Hook our dotfiles into system-standard positions, and FORCE IT!!"
task :force_install do
  @force_install = true
  Rake::Task["install"].invoke
end

desc "symlink bins to ~/bin/"
task :install_bins do
  linkables = Dir.glob('*/bin/*')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last
    target = "#{ENV["HOME"]}/bin/#{file}"
    puts "will symlink #{target} = #{file}"
    return

    if File.exists?(target) || File.symlink?(target)
      unless @force_install || skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all || @force_install
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end
task :default => 'install'
