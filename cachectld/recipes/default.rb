filename = node["cachectld"]["install_filename"]
remote_uri = node["cachectld"]["install_file_url"]

# githubからバイナリーをダウンロードする
execute "/tmp/#{filename}" do
  command "wget #{remote_uri} -O /tmp/#{filename}"
  notifies :run, "script[install_remote_cachectld]", :immediately
end

# バイナリを展開して、移動させる
script "install_remote_cachectld" do
  interpreter "bash"
  user "root"
  code <<-EOL
    tar zxvf /tmp/#{filename} -C /tmp
    cp -f /tmp/cachectl-0.3.2/cachectl /usr/local/bin/cachectl
    cp -f /tmp/cachectl-0.3.2/cachectld /usr/local/bin/cachectld
  EOL
  notifies :create, "template[cachectld.toml]", :immediately
end

# テンプレートファイルをコピー
template "cachectld.toml" do
  path "/etc/cachectld.toml"
  owner "root"
  group "root"
  mode 0644
  notifies :create, "template[cachectld]", :immediately
end

template "cachectld" do
  path "/etc/init.d/cachectld"
  owner "root"
  group "root"
  mode 0755
  notifies :run, "execute[add chkconfig]", :immediately
end

execute "add chkconfig" do
  command "chkconfig --add /etc/init.d/cachectld"
  notifies :start, "service[cachectld]", :immediately
end

service "cachectld" do
  action [ :enable ]
  supports :start => true, :status => true, :restart => true, :reload => true
end
