### ppc64le 4.18.0-0.el8 #######################################################
from flags import *

def setup(exc):
    PID_T = 'unistd.h'
    SIZE_T = 'stddef.h'
    SA_FAMILY_T = "sys/socket.h"
    SOCKADDR = 'sys/socket.h'

    exc['asm/papr_pdsm.h'] = (['* #define PAGE_SIZE (1UL << 16)'],
                              OK, 'PAGE_SIZE')
