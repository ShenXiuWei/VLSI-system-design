VLOG        = ncverilog
SRC         = hw01_t.v \
              hw01.v
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

clean :
	$(RM) $(TMPFILE)

veryclean :
	$(RM) $(TMPFILE) $(DBFILE)


