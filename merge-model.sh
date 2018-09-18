#!/bin/bash
# go to root level of this git repository
cd "$(git rev-parse --show-toplevel)";

if ! [ "$(git status | grep 'both modified' | grep 'eox/model.eox')" ] || ! [ "$(git status | grep 'Unmerged paths')" ]; then
	echo "nothing to merge in eox/model.eox";
else
	echo "preparing to do a three-way-merge in EEC";

	# commits
	cMERGE_HEAD="MERGE_HEAD";
	cORIG_HEAD="ORIG_HEAD";
	cBASE="$(git merge-base $cMERGE_HEAD $cORIG_HEAD)";

	# save the versions in separate files
	git show $cBASE:eox/model.eox > tmp.eox; ./zippey.exe d < tmp.eox > eox/modelBase.eox;
	git show $cMERGE_HEAD:eox/model.eox > tmp.eox; ./zippey.exe d < tmp.eox > eox/modelSource.eox;
	git show $cORIG_HEAD:eox/model.eox > tmp.eox; ./zippey.exe d < tmp.eox > eox/model.eox;
	rm tmp.eox;

	# notify the user
	echo "";
	echo "";
	echo "";
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
	echo "   PLEASE FIRST REOPEN THE model.eox   ";
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
	echo "";
	echo "";
	echo "modelBase.eox   is from the common anchestor of both branches (${cBASE})";
	echo "model.eox       is from the current branch ($(git rev-parse ${cORIG_HEAD}))";
	echo "modelSource.eox is from the merged branch ($(git rev-parse ${cMERGE_HEAD}))";
	echo "";
	echo "";
	echo "afterwards do your merge in EEC";
	echo "";
	echo "1. reopen model.eox to update the EEC IDE";
	echo "2. File -> Import... -> EOX -> Next";
	echo "3. select mode: 'Three way merge with base EOX'";
	echo "4. Base:   modelBase.eox";
	echo "5. Source: modelSource.eox";
	echo "6. click 'Select All'";
	echo "7. click 'Finish'";
	echo "";
	echo "";
	echo "after merging everything in EEC call ./stage-merge-model.sh to finish merging (doing cleanup)";
fi
