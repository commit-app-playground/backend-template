#!/usr/bin/env bash
set -e

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
export AWS_PROFILE=commit-app-playground
export AWS_DEFAULT_REGION=us-west-2

ENVIRONMENT=stage
PROJECT=onboarding
ROLE=operator
KUBE_CONTEXT=${PROJECT}-${ENVIRONMENT}-${AWS_DEFAULT_REGION}
SSO_START_URL=https://commit.awsapps.com/start/
SSO_REGION=us-west-2
SSO_ACCOUNT_ID=337242009412
SSO_ROLE_NAME=EPAccess

blue='\e[1;34m%b\e[0m'
red='\e[1;31m%b\e[0m'
yellow='\e[1;33m%b\e[0m'



function fail() {
	printf $red "\n\U274C It seems like the '$1' command failed.\nPlease reach out to someone in the #help channel with a screenshot of the output of this script.\n"
	exit 1
}

# Check for dependencies
which aws > /dev/null || { printf $yellow "The AWS cli tool is not installed or not in your path.\nInstallation instructions: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html\n"; exit 1; }
which kubectl > /dev/null || { printf $yellow "The kubectl cli tool is not installed or not in your path.\nInstallation instructions: https://kubernetes.io/docs/tasks/tools/\n"; exit 1; }

# Configure aws sso
aws configure set sso_start_url ${SSO_START_URL}
aws configure set sso_region ${SSO_REGION}
aws configure set sso_account_id ${SSO_ACCOUNT_ID}
aws configure set sso_role_name ${SSO_ROLE_NAME}

printf $blue "A web browser will now open and prompt you to log in with your Commit Google account.\n\n"
sleep 3

# Perform SSO login
aws sso login || fail "aws sso login"
aws eks --region ${AWS_DEFAULT_REGION} update-kubeconfig --role "arn:aws:iam::${SSO_ACCOUNT_ID}:role/${PROJECT}-kubernetes-${ROLE}-${ENVIRONMENT}" --name ${KUBE_CONTEXT} --alias ${KUBE_CONTEXT} \
  || fail "aws eks update-kubeconfig"

printf $blue "\nIf configuration was successful you should now see a list of namespaces in the kubernetes cluster:\n\n"
kubectl get ns || fail "kubectl"

printf "\n\U1F389\n" # tada
printf $blue "You're ready to access the cluster. Feel free to poke around and experiment.\nYou can find out more about the kubectl command here: https://kubernetes.io/docs/reference/kubectl/overview/\n"
printf $blue "If you're more in the mood for a GUI, we recommend Lens: https://k8slens.dev/\n"
printf $blue "When your application is deployed it will be running in a namespace called '<% .Name %>'\n\n"
printf $blue "You now have a new AWS CLI profile called '${AWS_PROFILE}' - to use it you can run 'export AWS_PROFILE=${AWS_PROFILE}' or supply the --profile argument to the aws cli.\n"
