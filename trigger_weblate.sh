#!/bin/bash

api_token=$3
language=$2
url=$1
act=$4

if [[ $api_token = "" || $language = "" || $url = "" || $act = "" ]]; then
  echo "failed weblate api call, wrong args provided"
  exit 1
fi


if [[ $act = "pull" ]]; then

		curl -sS \
			--data-binary '{
				"operation":"pull"
			}' \
			-H "Content-Type: application/json" \
			-H "Authorization: Token $api_token" \
		  "$url/components/nitrokey-documentation/root/repository/"

fi
		
#curl \
#		--data-binary '{
#			"operation":"reset"
#		}' \
#		-H "Content-Type: application/json" \
#		-H "Authorization: Token $api_token" \
#   "$url/projects/nitrokey-documentation/repository/"

if [[ $act = "translate" ]]; then
		
		curl -sS \
			--data-binary '{
				"mode":"translate",
				"auto_source":"mt",
				"engines":["deepl"],
				"filter_type":"nottranslated",
				"threshold":"80"
			}' \
			-H "Content-Type: application/json" \
			-H "Authorization: Token $api_token" \
		  "$url/translations/nitrokey-documentation/root/$language/autotranslate/"

	curl -sS \
			--data-binary '{
				"operation":"commit"
			}' \
			-H "Content-Type: application/json" \
			-H "Authorization: Token $api_token" \
		  "$url/components/nitrokey-documentation/root/repository/"

fi

if [[ $act = "push" ]]; then

		curl \
			--data-binary '{
				"operation":"push"
			}' \
			-H "Content-Type: application/json" \
			-H "Authorization: Token $api_token" \
 	    "$url/components/nitrokey-documentation/root/repository/"

fi


