#!/bin/bash
# go to root level of this git repository
cd "$(git rev-parse --show-toplevel)";

if ! [ "$(git status | grep 'both modified' | grep 'eox/model.eox')" ] || ! [ "$(git status | grep 'Unmerged paths')" ]; then
	echo "nothing to merge in eox/model.eox";
else
	echo "stage three-way-merge from EEC and clean up";

	# stage
	git add eox/model.eox;

	# cleanup
	rm eox/modelBase.eox;
	rm eox/modelSource.eox;

	# notify the user
	echo "";
	echo "";
	echo "";
	echo "staged model.eox";
	echo "removed modelBase.eox";
	echo "removed modelSource.eox";
fi
