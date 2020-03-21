
DEBUG = 0
VLOG = ncverilog +nctimescale+1ns/1ps
HEAD = header.v
SRC    = hw04_t.v top.v hw04_nonsyn.v hw04.v
SYNSRC = hw04_t.v top.v hw04_nonsyn.v hw04_syn.v


VLOGARG   = +access+r 
BAK = *.bak
INCA_libs = INCA_libs

 
all :: sim

sim:
	${VLOG}   ${SRC} ${VLOGARG}

syn:
	${VLOG}   ${HEAD} $(SYNSRC) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}


clean:
	-rm -f ${BAK} ${LOG}
	-rm -rf ${INCA_libs}
