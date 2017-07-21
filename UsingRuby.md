# Using Ruby

Notes about Ruby scripting on both Linux and Windows. Also how it might apply to Chef.

## Study Environments
* A distribtuion (simple install) Package was installed to Ubuntu Workstation (VM on my work script box)
* RVM Install on Cloud Server 1, Linux Academy
  * rvm.io
  * gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  * \curl -sSL https://get.rvm.io | bash -s stable
  * source /home/user/.rvm/scripts/rvm
* sudo yum install -y kernel-headers --disableexcludes=all
* rvm install ruby