wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/users/student/topic/zscaxd5651/VLSI_System_Design/HW3/hw03b_syn.fsdb}
wvResizeWindow -win $_nWave1 54 237 1440 775
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top"
wvGetSignalSetSignalFilter -win $_nWave1 "i"
wvGetSignalSetSignalFilter -win $_nWave1 "j"
wvGetSignalSetScope -win $_nWave1 "/top/filt"
wvGetSignalSetSignalFilter -win $_nWave1 "j"
wvGetSignalSetSignalFilter -win $_nWave1 "i"
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top/out_pixel\[7:0\]} \
{/top/filt/j\[7:0\]} \
{/top/filt/i\[7:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetPosition -win $_nWave1 {("G1" 3)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 6000174.589787 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 6000174.589787 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 6000174.589787 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 6032607.965948 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 50267702.232056 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 50267702.232056 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 51565037.278496 -snap {("G1" 3)}
wvResizeWindow -win $_nWave1 54 237 1440 775
wvResizeWindow -win $_nWave1 54 237 1440 775
wvSetCursor -win $_nWave1 8211713.058105 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 7205534.778258 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 4901061.943770 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 227201.547062 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 129829.455464 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 292116.274794 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 616689.913455 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 421945.730258 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 746519.368919 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 746519.368919 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 811434.096651 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1006178.279847 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1525496.101703 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1850069.740364 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 2272015.470622 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 2304472.834488 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 2693961.200880 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 2693961.200880 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3472937.933665 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 4544030.941244 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 5712496.040421 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 7530108.416918 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 9639837.068210 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 11782023.083368 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 13956666.462392 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 16098852.477550 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 15547077.291827 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 16066395.113684 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 16196224.569148 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 69063128.429681
wvSetCursor -win $_nWave1 69929123.770492
wvSetCursor -win $_nWave1 69929123.770492
wvSetCursor -win $_nWave1 69542077.805054 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69314874.789569 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69087671.774084 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69087671.774084 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69087671.774084 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69282417.215928 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69801738.394179 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 69866653.541460 -snap {("G1" 3)}
wvExit
