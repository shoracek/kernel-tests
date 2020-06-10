#!/bin/bash

function rhel5_knownissue_filter()
{
	tskip "keyctl02 proc01 cve-2017-5669 \
		cve-2017-6951 cve-2017-2671 \
		request_key04 cve-2017-17807 \
		cve-2015-7550 cve-2018-5803 \
		binfmt_misc01" \
	fatal

	tskip "mmap16 fork14 gethostbyname_r01 \
		add_key02 keyctl04 sendto02 \
		signal06 vma05 dynamic_debug01 \
		poll02 select04" \
	unfix
}
