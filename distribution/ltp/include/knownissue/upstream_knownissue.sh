#!/bin/bash

function upstream_knownissue_filter()
{
	# http://lists.linux.it/pipermail/ltp/2017-January/003424.html
	kernel_in_range "4.8.0-rc6" "4.12" && tskip "utimensat01.*" unfix
	# http://lists.linux.it/pipermail/ltp/2019-March/011231.html
	kernel_in_range "5.0.0" "5.2.0" && tskip "mount02" unfix
}
