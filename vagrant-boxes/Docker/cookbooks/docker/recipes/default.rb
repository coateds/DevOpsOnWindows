# move to shell provisioner
# execute "yum -y update"

file "/etc/yum.repos.d/docker.repo" do
    content "[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg"
end

remote_file '/etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco' do
    source 'http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco'
    action :create
end

file "/etc/yum.repos.d/wandisco-git.repo" do
    content "[WANdisco-git]
name=WANdisco Distribution of git
baseurl=http://opensource.wandisco.com/rhel/$releasever/git/$basearch
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco"
end

package "git"
package "docker-engine"

service "docker" do
    action [:enable, :start]
end

group 'docker' do
  action :modify
  members 'vagrant'
  append true
end
