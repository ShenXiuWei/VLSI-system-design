VLOG        = ncverilog
SRC         = hw02_t.v \
              hw02.v
SYNSRC      = hw02_h.v \
              hw02_t.v \
              hw02_syn.v \
              -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v
                            
VLOGARG     = +access+r

TMPFILE     = *.log \
              ncverilog.key \
              nWaveLog \
              INCA_libs

DBFILE      = *.fsdb *.vcd *.bak

RM          = -rm -rf

all :: sim

sim :
	$(VLOG) $(SRC) $(VLOGARG)
syn :
	$(VLOG) $(SYNSRC) $(VLOGARG)
clean :
	$(RM) $(TMPFILE)

veryclean :
	$(RM) $(TMPFILE) $(DBFILE)


