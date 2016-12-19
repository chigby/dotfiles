alias br="cd $HOME/lw/django-brambling && workon brambling"
alias bf="cd $HOME/lw/mybfinfo && workon mybfinfo"
alias lc="cd $HOME/lw/lcv && workon lcv"
alias lcr="cd $HOME/lw/lcv/lcvista/react && npm run start"

function mr() {
  cd ~/Downloads/elasticsearch-1.7.5 && ./bin/elasticsearch -d
  cd $HOME/lw/muckrack
  for service in memcached mysql rabbitmq-server redis-server; do
    service $service status
  done

  workon muckrack
}

alias pm="python manage.py"
