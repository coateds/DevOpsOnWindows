# move to shell provisioner
# execute "yum -y update"

# Copy the pki key from the WANdisco web site
# to the local pki store
remote_file '/etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco' do
    source 'http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco'
    action :create
end

# Create a file in the yum repo directory
# Provide the contents right here
# Note the gpgkey uses a file:// URI
file "/etc/yum.repos.d/wandisco-git.repo" do
    content "[WANdisco-git]
name=WANdisco Distribution of git
baseurl=http://opensource.wandisco.com/rhel/$releasever/git/$basearch
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco"
end

# It is now possible to install the lates version of git
package "git"

# Here is a similar song and dance for Docker
# for whatever reason, it is able to get the gpgkey
# straight from the web site, go figure
file "/etc/yum.repos.d/docker.repo" do
    content "[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg"
end

# Let the install rip!
package "docker-engine"

# Adjust and fire up the service
service "docker" do
    action [:enable, :start]
end

# Give the (default) vagrant user access to run Docker
group 'docker' do
  action :modify
  members 'vagrant'
  append true
end
