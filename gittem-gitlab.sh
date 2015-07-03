#!/bin/bash

INPUT=${1-respondents.csv} # Get csv from command line or default to respondents.csv
BUCKET=${2-test} #Get S3 bucket name from command line or default to test

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

(tail -n +1 $INPUT ; echo -n)| while IFS=, read RESPONDENT REPOSITORY

do
	echo "Fetching $REPOSITORY"
	REPO="$(basename $REPOSITORY)"

	REPONAME="${REPO%.git}"

	mkdir -p responses/$RESPONDENT

	git clone $REPOSITORY && \
		curl -XPOST -d name=$REPONAME -d private_token=$PRIVATE_TOKEN "http://$DOCKERHOST:10080/api/v3/projects" && \
		cd $REPONAME && git remote add gitlab ssh://git@$DOCKERHOST:10022/root/$REPONAME.git && \
		git push --all gitlab && \
		cd .. && rm -rf $REPONAME;

done
