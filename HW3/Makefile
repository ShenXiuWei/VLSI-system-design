
DEBUG = 0
VLOG = ncverilog
HEAD = header.v
SRC_A    = top_a.v load_bmp_a.v sram_a.v hw03a.v
SYNSRC_A = top_a.v load_bmp_a.v sram_a.v hw03a_syn.v
SRC_B    = top_b.v load_bmp_b.v sram_b.v hw03b.v
SYNSRC_B = top_b.v load_bmp_b.v sram_b.v hw03b_syn.v
SRC_C    = top_c.v load_bmp_c.v sram_c.v hw03c.v
SYNSRC_C = top_c.v load_bmp_c.v sram_c.v hw03c_syn.v

VLOGARG   = +access+r 
BAK = *.bak
LOG = *.log *.key *.fsdb img_gray*.txt out_log.txt *_output.bmp
INCA_libs = INCA_libs

 
all :: sim_a

sim_a:
	${VLOG}  +debug=${DEBUG} ${SRC_A} ${VLOGARG}

syn_a:
	${VLOG}  +debug=${DEBUG} ${HEAD} $(SYNSRC_A) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_b:
	${VLOG}  +debug=${DEBUG} ${SRC_B} ${VLOGARG}

syn_b:
	${VLOG}  +debug=${DEBUG} ${HEAD} $(SYNSRC_B) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

sim_c:
	${VLOG}  +debug=${DEBUG} ${SRC_C} ${VLOGARG}

syn_c:
	${VLOG}  +debug=${DEBUG} ${HEAD} $(SYNSRC_C) -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v ${VLOGARG}

clean:
	-rm -f ${BAK} ${LOG}
	-rm -rf ${INCA_libs}
