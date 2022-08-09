#!bin/bash

wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin && rm -rf /usr/bin/jq

mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.294.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.294.0/actions-runner-linux-x64-2.294.0.tar.gz

echo "a19a09f4eda5716e5d48ba86b6b78fc014880c5619b9dba4a059eaf65e131780  actions-runner-linux-x64-2.294.0.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner-linux-x64-2.294.0.tar.gz && rm -rf ./actions-runner-linux-x64-2.294.0.tar.gz

curl --request POST ${github_api_token_registration_url} --header "Authorization: token ${github_access_token}" > token.txt
runner_token=\$(jq -r '.token' output.txt)

./config.sh --url ${repo_url} --token \$runner_token --name "Self Hosted Runner" --unattended

./run.sh
