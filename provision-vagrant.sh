# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby2.2 ruby2.2-dev
update-alternatives --set ruby /usr/bin/ruby2.2 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.2 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Byobu byobu
install Git git
install memcached memcached

install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD 'password';"
sudo -u postgres createdb -O admin wedding_dev
sudo -u postgres createdb -O admin wedding_test

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs

echo installing Bundler project packages
cd /home/vagrant/wedding
bundle >/dev/null 2>&1

echo creating the database
bundle exec rake db:create

echo running the migrations
bundle exec rake db:migrate

echo running imports
bundle exec rake import_guests
bundle exec rake import_menu_items

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo 'Lets go!'

