
DEBUG = 0
VLOG = ncverilog +nctimescale+1ns/1ps
HEAD = header.v
SRC_1D    = RSA_t.v top.v RSA_nonsyn_1D.v RSA.v
SYNSRC_1D = RSA_t.v top.v RSA_nonsyn_1D.v RSA_syn.v
SRC_1E    = RSA_t.v top.v RSA_nonsyn_1E.v RSA.v
SYNSRC_1E = RSA_t.v top.v RSA_nonsyn_1E.v RSA_syn.v
SRC_2D    = RSA_t.v top.v RSA_nonsyn_2D.v RSA.v
SYNSRC_2D = RSA_t.v top.v RSA_nonsyn_2D.v RSA_syn.v
SRC_2E    = RSA_t.v top.v RSA_nonsyn_2E.v RSA.v
SYNSRC_2E = RSA_t.v top.v RSA_nonsyn_2E.v RSA_syn.v
SRC_3D    = RSA_t.v top.v RSA_nonsyn_3D.v RSA.v
SYNSRC_3D = RSA_t.v top.v RSA_nonsyn_3D.v RSA_syn.v
SRC_3E    = RSA_t.v top.v RSA_nonsyn_3E.v RSA.v
SYNSRC_3E = RSA_t.v top.v RSA_nonsyn_3E.v RSA_syn.v
SRC_4D    = RSA_t.v top.v RSA_nonsyn_4D.v RSA.v
SYNSRC_4D = RSA_t.v top.v RSA_nonsyn_4D.v RSA_syn.v
SRC_4E    = RSA_t.v top.v RSA_nonsyn_4E.v RSA.v
SYNSRC_4E = RSA_t.v top.v RSA_nonsyn_4E.v RSA_syn.v
SRC_V    = RSA_t_verify.v top.v RSA_nonsyn_verify.v RSA.v
SYNSRC_V = RSA_t_verify.v top.v RSA_nonsyn_verify.v RSA_syn.v


VLOGARG   = +access+r 
BAK = *.bak
INCA_libs = INCA_libs

 
all :: sim_1d
sim_1d:
	${VLOG}   ${SRC_1D} ${VLOGARG}

syn_1d:
	${VLOG}   ${HEAD} $(SYNSRC_1D) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_1e:
	${VLOG}   ${SRC_1E} ${VLOGARG}

syn_1e:
	${VLOG}   ${HEAD} $(SYNSRC_1E) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_2d:
	${VLOG}   ${SRC_2D} ${VLOGARG}

syn_2d:
	${VLOG}   ${HEAD} $(SYNSRC_2D) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_2e:
	${VLOG}   ${SRC_2E} ${VLOGARG}

syn_2e:
	${VLOG}   ${HEAD} $(SYNSRC_2E) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_3d:
	${VLOG}   ${SRC_3D} ${VLOGARG}

syn_3d:
	${VLOG}   ${HEAD} $(SYNSRC_3D) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_3e:
	${VLOG}   ${SRC_3E} ${VLOGARG}

syn_3e:
	${VLOG}   ${HEAD} $(SYNSRC_3E) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_4d:
	${VLOG}   ${SRC_4D} ${VLOGARG}

syn_4d:
	${VLOG}   ${HEAD} $(SYNSRC_4D) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_4e:
	${VLOG}   ${SRC_4E} ${VLOGARG}

syn_4e:
	${VLOG}   ${HEAD} $(SYNSRC_4E) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_v:
	${VLOG}   ${SRC_V} ${VLOGARG}

syn_v:
	${VLOG}   ${HEAD} $(SYNSRC_V) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}


clean:
	-rm -f ${BAK} ${LOG}
	-rm -rf ${INCA_libs}
