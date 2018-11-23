    CHIP N588
.PUBLIC UIO_COMMAND_ADDR_TABLE
.PUBLIC UIO_INIT
.PUBLIC UIO_N55P_INIT
.PUBLIC UIO_N55P_ENTER_SLEEP
.PUBLIC UIO_N55P_WAKE_UP
.PUBLIC UIO_START
.PUBLIC UIO_STOP
.PUBLIC UIO_STOP_ALL_KEEP_LEVEL_PIN
.PUBLIC BAM_EVENT_ADDR_OFFSET_TABLE
.PUBLIC BAM_CH_BIT_TABLE
.PUBLIC BAM_EVENT_ADDR_SP1
.PUBLIC UIO_EVENT_CH_FLAG
    CODE: SECTION
UIO_COMMAND_ADDR_TABLE:
BAM_EVENT_ADDR_OFFSET_TABLE:
BAM_CH_BIT_TABLE:
UIO_INIT:
UIO_START:
UIO_STOP:
UIO_STOP_ALL_KEEP_LEVEL_PIN:
UIO_N55P_INIT:
UIO_N55P_ENTER_SLEEP:
UIO_N55P_WAKE_UP:
    RTS
    ENDS

    UIO_USED_RAM: SECTION
BAM_EVENT_ADDR_SP1: DS 0
UIO_EVENT_CH_FLAG: DS 0
    ENDS

