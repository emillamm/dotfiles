# NVM
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/elamm/libraries/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/elamm/libraries/google-cloud-sdk/path.bash.inc'
fi
# The next line enables shell command completion for gcloud.
if [ -f /Users/elamm/libraries/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/elamm/libraries/google-cloud-sdk/completion.bash.inc'
fi
