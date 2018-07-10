# move to shell provisioner
# execute "yum -y update"

# Install Git
# This is the same process as the Docker install
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

# most of this process can be accomplished with the line
# `execute "yum -y groupinstall development"`
# There is no groupinstall option to Chef Package that I know of...
# (git, yum-utils, and vim enhanced would still need to be in their own
# package resource)
package %w(git yum-utils autoconf automake bison byacc cscope ctags diffstat 
doxygen elfutils flex gcc gcc-c++ gcc-gfortran indent intltool libtool patch patchutils 
rcs redhat-rpm-config rpm-build rpm-sign subversion swig systemtap apr apr-util avahi-libs 
boost-date-time boost-system boost-thread cpp dwz dyninst efivar-libs emacs-filesystem gdb 
gettext-common-devel gettext-devel glibc-devel glibc-headers gnutls kernel-debug-devel kernel-headers 
libdwarf libgfortran libmodman libproxy libquadmath libquadmath-devel libstdc++-devel mokutil 
neon nettle pakchois perl-Data-Dumper perl-Test-Harness perl-Thread-Queue perl-XML-Parser 
perl-srpm-macros subversion-libs systemtap-client systemtap-devel systemtap-runtime trousers 
unzip zip vim-enhanced) do
  action :install
end

# this did nothing? all up to date??
# package %w(
# elfutils-libelf elfutils-libs glibc glibc-common libgcc libgomp libstdc++ rpm 
# rpm-build-libs rpm-libs rpm-python) do
#   action :upgrade
# end



# Now to set up the repo for Python
# This could have been done with a single command
# `# execute "yum -y install https://centos7.iuscommunity.org/ius-release.rpm"`
# But it is less Cheffy to do so.
# There are likely easier ways to do this, but demonstrating some techniques
# This grabs the GPG from the ius website like before
remote_file '/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY' do
  source 'https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY'
  action :create
end

# Here the repo file is being copied locally
# In Vagrant, by default, all files in the folder with the Vagrantfile
# are synchronized with the /Vagrant folder on the guest
# This becomes the source I am user here
remote_file '/etc/yum.repos.d/ius.repo' do
  source 'file:////vagrant/ius.repo'
  action :create
end

# Note the need to flush the cache before it can read this repo, but there it is
package %w(python36u python36u-pip python36u-devel) do
  flush_cache before: true
  action :install
end