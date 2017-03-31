function h() { cd ~; }
function dot() { cd ~/dotfiles; }
if [ "$PROFILE_ENV" == HOME ]; then
  export NVM_DIR=$HOME/.nvm
  . /usr/local/opt/nvm/nvm.sh
  if [ -f /Users/elamm/libraries/google-cloud-sdk/path.bash.inc ]; then source /Users/elamm/libraries/google-cloud-sdk/path.bash.inc; fi
  if [ -f /Users/elamm/libraries/google-cloud-sdk/completion.bash.inc ]; then source /Users/elamm/libraries/google-cloud-sdk/completion.bash.inc; fi
fi
if [ "$PROFILE_ENV" == WORK ]; then
  export PATH=$PATH:$HOME/libraries/spark-2.0.2-bin-hadoop2.7/bin:$HOME/libraries/gradle-2.14.1/bin
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/
  export im=$HOME/d/impressions
  export imp=$im/backend/src/main/python
  export s3im="s3://bwaite/impression"
  export s3en=$s3im"/output/EN"
  function im() { cd $im; }
  function imp() { cd $imp; }
  alias s3='aws s3'
fi

alias json='python -m json.tool'
