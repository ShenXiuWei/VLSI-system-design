/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 16 00:53:02 2019
/////////////////////////////////////////////////////////////


module GCD_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;
  wire   [16:0] carry;

  XOR3X1 U2_15 ( .A(A[15]), .B(n2), .C(carry[15]), .Y(DIFF[15]) );
  ADDFXL U2_14 ( .A(A[14]), .B(n3), .CI(carry[14]), .CO(carry[15]), .S(
        DIFF[14]) );
  ADDFXL U2_13 ( .A(A[13]), .B(n4), .CI(carry[13]), .CO(carry[14]), .S(
        DIFF[13]) );
  ADDFXL U2_12 ( .A(A[12]), .B(n5), .CI(carry[12]), .CO(carry[13]), .S(
        DIFF[12]) );
  ADDFXL U2_11 ( .A(A[11]), .B(n6), .CI(carry[11]), .CO(carry[12]), .S(
        DIFF[11]) );
  ADDFXL U2_10 ( .A(A[10]), .B(n7), .CI(carry[10]), .CO(carry[11]), .S(
        DIFF[10]) );
  ADDFXL U2_9 ( .A(A[9]), .B(n8), .CI(carry[9]), .CO(carry[10]), .S(DIFF[9])
         );
  ADDFXL U2_8 ( .A(A[8]), .B(n9), .CI(carry[8]), .CO(carry[9]), .S(DIFF[8]) );
  ADDFXL U2_7 ( .A(A[7]), .B(n10), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFXL U2_6 ( .A(A[6]), .B(n11), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  ADDFXL U2_5 ( .A(A[5]), .B(n12), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFXL U2_4 ( .A(A[4]), .B(n13), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFXL U2_3 ( .A(A[3]), .B(n14), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFXL U2_2 ( .A(A[2]), .B(n15), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFXL U2_1 ( .A(A[1]), .B(n16), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  CLKINVX1 U1 ( .A(B[0]), .Y(n17) );
  CLKINVX1 U2 ( .A(A[0]), .Y(n1) );
  NAND2X1 U3 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  CLKINVX1 U4 ( .A(B[1]), .Y(n16) );
  CLKINVX1 U5 ( .A(B[2]), .Y(n15) );
  CLKINVX1 U6 ( .A(B[3]), .Y(n14) );
  CLKINVX1 U7 ( .A(B[4]), .Y(n13) );
  CLKINVX1 U8 ( .A(B[5]), .Y(n12) );
  CLKINVX1 U9 ( .A(B[6]), .Y(n11) );
  CLKINVX1 U10 ( .A(B[7]), .Y(n10) );
  CLKINVX1 U11 ( .A(B[8]), .Y(n9) );
  CLKINVX1 U12 ( .A(B[9]), .Y(n8) );
  CLKINVX1 U13 ( .A(B[10]), .Y(n7) );
  CLKINVX1 U14 ( .A(B[11]), .Y(n6) );
  CLKINVX1 U15 ( .A(B[12]), .Y(n5) );
  CLKINVX1 U16 ( .A(B[13]), .Y(n4) );
  CLKINVX1 U17 ( .A(B[14]), .Y(n3) );
  XNOR2X1 U18 ( .A(n17), .B(A[0]), .Y(DIFF[0]) );
  CLKINVX1 U19 ( .A(B[15]), .Y(n2) );
endmodule


module GCD ( CLK, RST_N, A, B, START, Y, DONE, ERROR );
  input [7:0] A;
  input [7:0] B;
  output [7:0] Y;
  input CLK, RST_N, START;
  output DONE, ERROR;
  wire   N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31,
         N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45,
         N46, N47, N48, N49, N71, N72, N116, N117, N118, N119, N120, N121,
         N122, N123, N124, N125, N126, N127, N128, N129, N130, N131, N132,
         N133, N134, N135, N136, N137, N138, N139, N140, N141, N142, N143,
         N144, N145, N146, N147, N148, N149, N150, N151, N152, N153, N154,
         N155, N156, N157, N158, N159, N160, N161, N162, N163, N165, N166,
         N167, N168, N169, N170, N171, N172, N173, N174, N175, N176, N177,
         N178, N179, N180, N181, N182, N183, N184, N185, N186, N187, N188,
         N189, N190, N191, N192, N193, N194, N195, N196, N197, N198, N199,
         N200, N201, N202, N203, N204, N205, N206, N207, N208, N209, N210,
         N211, N212, N213, N214, N215, N216, N217, N218, N219, N220, N221,
         N222, N223, N224, N225, N226, N227, N228, N229, N230, N231, N232,
         N233, N234, N235, N236, N237, N238, N239, N240, N241, N242, N243,
         N244, N245, N246, N247, N248, N249, N250, N251, N252, N253, N254,
         N255, N256, N257, n8, n10, n13, n14, n15, n17, n18, n19, n20, n22,
         n73, n74, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295;
  wire   [2:0] state;
  wire   [15:0] reg_a;
  wire   [15:0] reg_b;
  wire   [2:0] state_next;

  GCD_DW01_sub_0 sub_141 ( .A({N131, N130, N129, N128, N127, N126, N125, N124, 
        N123, N122, N121, N120, N119, N118, N117, N116}), .B({N147, N146, N145, 
        N144, N143, N142, N141, N140, N139, N138, N137, N136, N135, N134, N133, 
        N132}), .CI(1'b0), .DIFF({N163, N162, N161, N160, N159, N158, N157, 
        N156, N155, N154, N153, N152, N151, N150, N149, N148}) );
  TLATX1 \reg_b_next_reg[0]  ( .G(N173), .D(N174), .QN(n137) );
  TLATX1 \diff_reg[15]  ( .G(N223), .D(N222), .QN(n134) );
  TLATX1 \data_b_reg[15]  ( .G(N223), .D(N239), .QN(n166) );
  TLATX1 \diff_reg[14]  ( .G(N223), .D(N221), .QN(n132) );
  TLATX1 \data_b_reg[14]  ( .G(N223), .D(N238), .QN(n164) );
  TLATX1 \diff_reg[13]  ( .G(N223), .D(N220), .QN(n130) );
  TLATX1 \diff_reg[12]  ( .G(N223), .D(N219), .QN(n128) );
  TLATX1 \diff_reg[11]  ( .G(N223), .D(N218), .QN(n126) );
  TLATX1 \diff_reg[10]  ( .G(N223), .D(N217), .QN(n124) );
  TLATX1 \diff_reg[9]  ( .G(N223), .D(N216), .QN(n122) );
  TLATX1 \diff_reg[8]  ( .G(N223), .D(N215), .QN(n120) );
  TLATX1 \diff_reg[7]  ( .G(N223), .D(N214), .QN(n118) );
  TLATX1 \diff_reg[6]  ( .G(N223), .D(N213), .QN(n116) );
  TLATX1 \diff_reg[5]  ( .G(N223), .D(N212), .QN(n114) );
  TLATX1 \diff_reg[4]  ( .G(N223), .D(N211), .QN(n112) );
  TLATX1 \diff_reg[3]  ( .G(N223), .D(N210), .QN(n110) );
  TLATX1 \diff_reg[2]  ( .G(N223), .D(N209), .QN(n108) );
  TLATX1 \diff_reg[1]  ( .G(N223), .D(N208), .QN(n106) );
  TLATX1 \diff_reg[0]  ( .G(N223), .D(N207), .QN(n104) );
  TLATX1 \reg_a_next_reg[8]  ( .G(N182), .D(N199), .QN(n121) );
  TLATX1 \reg_a_next_reg[9]  ( .G(N182), .D(N200), .QN(n123) );
  TLATX1 \reg_a_next_reg[10]  ( .G(N182), .D(N201), .QN(n125) );
  TLATX1 \reg_a_next_reg[11]  ( .G(N182), .D(N202), .QN(n127) );
  TLATX1 \reg_a_next_reg[12]  ( .G(N182), .D(N203), .QN(n129) );
  TLATX1 \reg_a_next_reg[13]  ( .G(N182), .D(N204), .QN(n131) );
  TLATX1 \reg_a_next_reg[14]  ( .G(N182), .D(N205), .QN(n133) );
  TLATX1 \reg_a_next_reg[15]  ( .G(N182), .D(N206), .QN(n135) );
  TLATX1 \reg_a_next_reg[1]  ( .G(N173), .D(N192), .QN(n107) );
  TLATX1 \reg_a_next_reg[2]  ( .G(N173), .D(N193), .QN(n109) );
  TLATX1 \reg_a_next_reg[3]  ( .G(N173), .D(N194), .QN(n111) );
  TLATX1 \reg_a_next_reg[4]  ( .G(N173), .D(N195), .QN(n113) );
  TLATX1 \reg_a_next_reg[5]  ( .G(N173), .D(N196), .QN(n115) );
  TLATX1 \reg_a_next_reg[6]  ( .G(N173), .D(N197), .QN(n117) );
  TLATX1 \reg_a_next_reg[7]  ( .G(N173), .D(N198), .QN(n119) );
  TLATX1 \reg_a_next_reg[0]  ( .G(N173), .D(N191), .QN(n105) );
  TLATX1 \data_b_reg[13]  ( .G(N223), .D(N237), .QN(n162) );
  TLATX1 \reg_b_next_reg[13]  ( .G(N182), .D(N188), .QN(n163) );
  TLATX1 \data_b_reg[12]  ( .G(N223), .D(N236), .QN(n160) );
  TLATX1 \reg_b_next_reg[12]  ( .G(N182), .D(N187), .QN(n161) );
  TLATX1 \data_b_reg[11]  ( .G(N223), .D(N235), .QN(n158) );
  TLATX1 \reg_b_next_reg[11]  ( .G(N182), .D(N186), .QN(n159) );
  TLATX1 \data_b_reg[10]  ( .G(N223), .D(N234), .QN(n156) );
  TLATX1 \reg_b_next_reg[10]  ( .G(N182), .D(N185), .QN(n157) );
  TLATX1 \data_b_reg[9]  ( .G(N223), .D(N233), .QN(n154) );
  TLATX1 \reg_b_next_reg[9]  ( .G(N182), .D(N184), .QN(n155) );
  TLATX1 \data_b_reg[8]  ( .G(N223), .D(N232), .QN(n152) );
  TLATX1 \reg_b_next_reg[8]  ( .G(N182), .D(N183), .QN(n153) );
  TLATX1 \data_b_reg[7]  ( .G(N223), .D(N231), .QN(n150) );
  TLATX1 \reg_b_next_reg[7]  ( .G(N173), .D(N181), .QN(n151) );
  TLATX1 \data_b_reg[6]  ( .G(N223), .D(N230), .QN(n148) );
  TLATX1 \reg_b_next_reg[6]  ( .G(N173), .D(N180), .QN(n149) );
  TLATX1 \data_b_reg[5]  ( .G(N223), .D(N229), .QN(n146) );
  TLATX1 \reg_b_next_reg[5]  ( .G(N173), .D(N179), .QN(n147) );
  TLATX1 \data_b_reg[4]  ( .G(N223), .D(N228), .QN(n144) );
  TLATX1 \reg_b_next_reg[4]  ( .G(N173), .D(N178), .QN(n145) );
  TLATX1 \data_b_reg[3]  ( .G(N223), .D(N227), .QN(n142) );
  TLATX1 \reg_b_next_reg[3]  ( .G(N173), .D(N177), .QN(n143) );
  TLATX1 \data_b_reg[2]  ( .G(N223), .D(N226), .QN(n140) );
  TLATX1 \reg_b_next_reg[2]  ( .G(N173), .D(N176), .QN(n141) );
  TLATX1 \data_b_reg[1]  ( .G(N223), .D(N225), .QN(n138) );
  TLATX1 \reg_b_next_reg[1]  ( .G(N173), .D(N175), .QN(n139) );
  TLATX1 \data_b_reg[0]  ( .G(N223), .D(N224), .QN(n136) );
  TLATX1 \data_a_reg[13]  ( .G(N223), .D(N253), .QN(n99) );
  TLATX1 \data_a_reg[12]  ( .G(N223), .D(N252), .QN(n97) );
  TLATX1 \data_a_reg[11]  ( .G(N223), .D(N251), .QN(n95) );
  TLATX1 \data_a_reg[10]  ( .G(N223), .D(N250), .QN(n93) );
  TLATX1 \data_a_reg[9]  ( .G(N223), .D(N249), .QN(n91) );
  TLATX1 \data_a_reg[8]  ( .G(N223), .D(N248), .QN(n89) );
  TLATX1 \data_a_reg[7]  ( .G(N223), .D(N247), .QN(n102) );
  TLATX1 \data_a_reg[6]  ( .G(N223), .D(N246), .QN(n100) );
  TLATX1 \data_a_reg[5]  ( .G(N223), .D(N245), .QN(n98) );
  TLATX1 \data_a_reg[4]  ( .G(N223), .D(N244), .QN(n96) );
  TLATX1 \data_a_reg[3]  ( .G(N223), .D(N243), .QN(n94) );
  TLATX1 \data_a_reg[2]  ( .G(N223), .D(N242), .QN(n92) );
  TLATX1 \data_a_reg[1]  ( .G(N223), .D(N241), .QN(n90) );
  TLATX1 \reg_b_next_reg[14]  ( .G(N182), .D(N189), .QN(n165) );
  TLATX1 \data_a_reg[14]  ( .G(N223), .D(N254), .QN(n101) );
  TLATX1 \reg_b_next_reg[15]  ( .G(N182), .D(N190), .QN(n167) );
  TLATX1 \data_a_reg[15]  ( .G(N223), .D(N255), .QN(n103) );
  TLATX1 \data_a_reg[0]  ( .G(N223), .D(N240), .QN(n88) );
  DFFRX1 ERROR_reg ( .D(n169), .CK(CLK), .RN(RST_N), .Q(ERROR) );
  DFFRX1 \state_reg[1]  ( .D(state_next[1]), .CK(CLK), .RN(RST_N), .Q(state[1]) );
  DFFRX1 \state_reg[2]  ( .D(state_next[2]), .CK(CLK), .RN(RST_N), .Q(state[2]), .QN(n190) );
  DFFRX1 \state_reg[0]  ( .D(state_next[0]), .CK(CLK), .RN(RST_N), .Q(state[0]), .QN(n182) );
  DFFRX1 \reg_b_reg[14]  ( .D(N48), .CK(CLK), .RN(RST_N), .Q(reg_b[14]) );
  DFFRX1 \reg_a_reg[15]  ( .D(N33), .CK(CLK), .RN(RST_N), .Q(reg_a[15]), .QN(
        n173) );
  DFFRX1 \reg_a_reg[10]  ( .D(N28), .CK(CLK), .RN(RST_N), .Q(reg_a[10]), .QN(
        n192) );
  DFFRX1 \reg_a_reg[12]  ( .D(N30), .CK(CLK), .RN(RST_N), .Q(reg_a[12]), .QN(
        n174) );
  DFFRX1 \reg_a_reg[11]  ( .D(N29), .CK(CLK), .RN(RST_N), .Q(reg_a[11]) );
  DFFRX1 \reg_a_reg[13]  ( .D(N31), .CK(CLK), .RN(RST_N), .Q(reg_a[13]) );
  DFFRX1 \reg_a_reg[9]  ( .D(N27), .CK(CLK), .RN(RST_N), .Q(reg_a[9]), .QN(
        n176) );
  DFFRX1 \reg_a_reg[8]  ( .D(N26), .CK(CLK), .RN(RST_N), .Q(reg_a[8]), .QN(
        n170) );
  DFFRX1 \reg_b_reg[15]  ( .D(N49), .CK(CLK), .RN(RST_N), .QN(n180) );
  DFFRX1 \reg_a_reg[14]  ( .D(N32), .CK(CLK), .RN(RST_N), .QN(n195) );
  DFFRX1 \reg_b_reg[13]  ( .D(N47), .CK(CLK), .RN(RST_N), .QN(n193) );
  DFFRX1 \reg_b_reg[12]  ( .D(N46), .CK(CLK), .RN(RST_N), .QN(n198) );
  DFFRX1 \reg_b_reg[11]  ( .D(N45), .CK(CLK), .RN(RST_N), .QN(n191) );
  DFFRX1 \reg_b_reg[10]  ( .D(N44), .CK(CLK), .RN(RST_N), .QN(n181) );
  DFFRX1 \reg_b_reg[9]  ( .D(N43), .CK(CLK), .RN(RST_N), .QN(n197) );
  DFFRX1 \reg_a_reg[5]  ( .D(N23), .CK(CLK), .RN(RST_N), .Q(reg_a[5]), .QN(
        n199) );
  DFFRX1 \reg_a_reg[0]  ( .D(N18), .CK(CLK), .RN(RST_N), .Q(reg_a[0]), .QN(
        n178) );
  DFFRX1 \reg_a_reg[1]  ( .D(N19), .CK(CLK), .RN(RST_N), .Q(reg_a[1]), .QN(
        n179) );
  DFFRX1 \reg_b_reg[4]  ( .D(N38), .CK(CLK), .RN(RST_N), .Q(reg_b[4]), .QN(
        n177) );
  DFFRX1 \reg_b_reg[7]  ( .D(N41), .CK(CLK), .RN(RST_N), .Q(reg_b[7]), .QN(
        n184) );
  DFFRX1 \reg_b_reg[6]  ( .D(N40), .CK(CLK), .RN(RST_N), .Q(reg_b[6]), .QN(
        n171) );
  DFFRX1 \reg_a_reg[2]  ( .D(N20), .CK(CLK), .RN(RST_N), .Q(reg_a[2]), .QN(
        n175) );
  DFFRX1 \reg_a_reg[3]  ( .D(N21), .CK(CLK), .RN(RST_N), .Q(reg_a[3]), .QN(
        n183) );
  DFFRX1 \reg_b_reg[5]  ( .D(N39), .CK(CLK), .RN(RST_N), .Q(reg_b[5]), .QN(
        n172) );
  DFFRX1 \reg_a_reg[4]  ( .D(N22), .CK(CLK), .RN(RST_N), .QN(n189) );
  DFFRX1 \reg_a_reg[6]  ( .D(N24), .CK(CLK), .RN(RST_N), .QN(n188) );
  DFFRX1 \reg_a_reg[7]  ( .D(N25), .CK(CLK), .RN(RST_N), .QN(n194) );
  DFFRX1 \reg_b_reg[8]  ( .D(N42), .CK(CLK), .RN(RST_N), .QN(n187) );
  DFFRX1 \reg_b_reg[3]  ( .D(N37), .CK(CLK), .RN(RST_N), .QN(n196) );
  DFFRX1 \reg_b_reg[2]  ( .D(N36), .CK(CLK), .RN(RST_N), .QN(n186) );
  DFFRX1 \reg_b_reg[1]  ( .D(N35), .CK(CLK), .RN(RST_N), .Q(reg_b[1]), .QN(
        n200) );
  DFFRX1 \reg_b_reg[0]  ( .D(N34), .CK(CLK), .RN(RST_N), .Q(reg_b[0]), .QN(
        n185) );
  TLATX1 \Y_reg[7]  ( .G(N71), .D(N172), .Q(Y[7]) );
  TLATX1 \Y_reg[6]  ( .G(N71), .D(N171), .Q(Y[6]) );
  TLATX1 \Y_reg[5]  ( .G(N71), .D(N170), .Q(Y[5]) );
  TLATX1 \Y_reg[4]  ( .G(N71), .D(N169), .Q(Y[4]) );
  TLATX1 \Y_reg[3]  ( .G(N71), .D(N168), .Q(Y[3]) );
  TLATX1 \Y_reg[2]  ( .G(N71), .D(N167), .Q(Y[2]) );
  TLATX1 \Y_reg[1]  ( .G(N71), .D(N166), .Q(Y[1]) );
  TLATX1 \Y_reg[0]  ( .G(N71), .D(N165), .Q(Y[0]) );
  TLATX1 DONE_reg ( .G(N71), .D(N72), .Q(DONE) );
  NOR2X1 U246 ( .A(n182), .B(n223), .Y(n22) );
  OAI22XL U247 ( .A0(n225), .A1(n185), .B0(n230), .B1(n178), .Y(N116) );
  OAI22XL U248 ( .A0(n225), .A1(n178), .B0(n230), .B1(n185), .Y(N132) );
  OAI22XL U249 ( .A0(n225), .A1(n179), .B0(n231), .B1(n200), .Y(N133) );
  OAI22XL U250 ( .A0(n225), .A1(n175), .B0(n231), .B1(n186), .Y(N134) );
  OAI22XL U251 ( .A0(n225), .A1(n183), .B0(n231), .B1(n196), .Y(N135) );
  OAI22XL U252 ( .A0(n225), .A1(n189), .B0(n231), .B1(n177), .Y(N136) );
  OAI22XL U253 ( .A0(n225), .A1(n199), .B0(n231), .B1(n172), .Y(N137) );
  OAI22XL U254 ( .A0(n225), .A1(n188), .B0(n231), .B1(n171), .Y(N138) );
  OAI22XL U255 ( .A0(n225), .A1(n194), .B0(n231), .B1(n184), .Y(N139) );
  OAI22XL U256 ( .A0(n225), .A1(n170), .B0(n232), .B1(n187), .Y(N140) );
  OAI22XL U257 ( .A0(n225), .A1(n176), .B0(n232), .B1(n197), .Y(N141) );
  OAI22XL U258 ( .A0(n225), .A1(n192), .B0(n232), .B1(n181), .Y(N142) );
  OAI22XL U259 ( .A0(n225), .A1(n294), .B0(n232), .B1(n191), .Y(N143) );
  OAI22XL U260 ( .A0(n225), .A1(n174), .B0(n232), .B1(n198), .Y(N144) );
  OAI22XL U261 ( .A0(n225), .A1(n295), .B0(n232), .B1(n193), .Y(N145) );
  OAI22XL U262 ( .A0(n225), .A1(n195), .B0(n232), .B1(n290), .Y(N146) );
  OAI22XL U263 ( .A0(n173), .A1(n225), .B0(n233), .B1(n180), .Y(N147) );
  CLKBUFX3 U264 ( .A(n20), .Y(n223) );
  CLKBUFX3 U265 ( .A(n291), .Y(n211) );
  CLKINVX1 U266 ( .A(n214), .Y(n222) );
  CLKBUFX3 U267 ( .A(n20), .Y(n224) );
  CLKBUFX3 U268 ( .A(n291), .Y(n210) );
  CLKINVX1 U269 ( .A(n228), .Y(n225) );
  NAND2X1 U270 ( .A(n292), .B(n13), .Y(state_next[1]) );
  OAI21XL U271 ( .A0(n14), .A1(n15), .B0(n212), .Y(n13) );
  CLKBUFX3 U272 ( .A(n235), .Y(n226) );
  NAND2X1 U273 ( .A(n207), .B(n212), .Y(n20) );
  CLKBUFX3 U274 ( .A(n22), .Y(n218) );
  CLKBUFX3 U275 ( .A(n22), .Y(n220) );
  CLKBUFX3 U276 ( .A(n22), .Y(n217) );
  CLKBUFX3 U277 ( .A(n22), .Y(n219) );
  CLKBUFX3 U278 ( .A(n22), .Y(n214) );
  CLKBUFX3 U279 ( .A(n22), .Y(n216) );
  CLKBUFX3 U280 ( .A(n22), .Y(n215) );
  CLKINVX1 U281 ( .A(n15), .Y(n291) );
  CLKBUFX3 U282 ( .A(n22), .Y(n221) );
  CLKBUFX3 U283 ( .A(n233), .Y(n231) );
  CLKBUFX3 U284 ( .A(n234), .Y(n229) );
  CLKBUFX3 U285 ( .A(n233), .Y(n232) );
  CLKBUFX3 U286 ( .A(n234), .Y(n230) );
  CLKBUFX3 U287 ( .A(n235), .Y(n227) );
  CLKBUFX3 U288 ( .A(n234), .Y(n228) );
  NAND2X1 U289 ( .A(n212), .B(n293), .Y(N71) );
  AND2X2 U290 ( .A(N116), .B(n212), .Y(N240) );
  AND2X2 U291 ( .A(N132), .B(n213), .Y(N224) );
  AND2X2 U292 ( .A(N133), .B(n213), .Y(N225) );
  AND2X2 U293 ( .A(N134), .B(n213), .Y(N226) );
  AND2X2 U294 ( .A(N135), .B(n213), .Y(N227) );
  AND2X2 U295 ( .A(N136), .B(n213), .Y(N228) );
  AND2X2 U296 ( .A(N137), .B(n213), .Y(N229) );
  AND2X2 U297 ( .A(N138), .B(n213), .Y(N230) );
  AND2X2 U298 ( .A(N139), .B(n213), .Y(N231) );
  AND2X2 U299 ( .A(N140), .B(n213), .Y(N232) );
  AND2X2 U300 ( .A(N141), .B(n213), .Y(N233) );
  AND2X2 U301 ( .A(N142), .B(n213), .Y(N234) );
  AND2X2 U302 ( .A(N143), .B(n212), .Y(N235) );
  AND2X2 U303 ( .A(N144), .B(n212), .Y(N236) );
  AND2X2 U304 ( .A(N145), .B(n212), .Y(N237) );
  AND2X2 U305 ( .A(N146), .B(n212), .Y(N238) );
  AND2X2 U306 ( .A(N147), .B(n212), .Y(N239) );
  AND2X2 U307 ( .A(N131), .B(n212), .Y(N255) );
  AND2X2 U308 ( .A(N130), .B(n212), .Y(N254) );
  AND2X2 U309 ( .A(N117), .B(n212), .Y(N241) );
  AND2X2 U310 ( .A(N118), .B(n212), .Y(N242) );
  AND2X2 U311 ( .A(N119), .B(n212), .Y(N243) );
  AND2X2 U312 ( .A(N120), .B(n212), .Y(N244) );
  AND2X2 U313 ( .A(N121), .B(n213), .Y(N245) );
  AND2X2 U314 ( .A(N122), .B(n212), .Y(N246) );
  AND2X2 U315 ( .A(N123), .B(n212), .Y(N247) );
  AND2X2 U316 ( .A(N124), .B(n212), .Y(N248) );
  AND2X2 U317 ( .A(N125), .B(n212), .Y(N249) );
  AND2X2 U318 ( .A(N126), .B(n212), .Y(N250) );
  AND2X2 U319 ( .A(N127), .B(n212), .Y(N251) );
  AND2X2 U320 ( .A(N128), .B(n212), .Y(N252) );
  AND2X2 U321 ( .A(N129), .B(n212), .Y(N253) );
  AND2X2 U322 ( .A(N148), .B(n213), .Y(N207) );
  AND2X2 U323 ( .A(N149), .B(n213), .Y(N208) );
  AND2X2 U324 ( .A(N150), .B(n213), .Y(N209) );
  AND2X2 U325 ( .A(N151), .B(n213), .Y(N210) );
  AND2X2 U326 ( .A(N152), .B(n213), .Y(N211) );
  AND2X2 U327 ( .A(N153), .B(n213), .Y(N212) );
  AND2X2 U328 ( .A(N154), .B(n213), .Y(N213) );
  AND2X2 U329 ( .A(N155), .B(n213), .Y(N214) );
  AND2X2 U330 ( .A(N156), .B(n213), .Y(N215) );
  AND2X2 U331 ( .A(N157), .B(n213), .Y(N216) );
  AND2X2 U332 ( .A(N158), .B(n213), .Y(N217) );
  AND2X2 U333 ( .A(N159), .B(n213), .Y(N218) );
  AND2X2 U334 ( .A(N160), .B(n213), .Y(N219) );
  AND2X2 U335 ( .A(N161), .B(n213), .Y(N220) );
  AND2X2 U336 ( .A(N162), .B(n213), .Y(N221) );
  AND2X2 U337 ( .A(N163), .B(n213), .Y(N222) );
  NOR3X1 U338 ( .A(n182), .B(N257), .C(ERROR), .Y(n14) );
  CLKBUFX3 U339 ( .A(n236), .Y(n235) );
  OAI21XL U340 ( .A0(n8), .A1(n222), .B0(n10), .Y(state_next[2]) );
  NOR2X1 U341 ( .A(N257), .B(ERROR), .Y(n8) );
  NAND4BX1 U342 ( .AN(n17), .B(n292), .C(n10), .D(n18), .Y(state_next[0]) );
  NOR3X1 U343 ( .A(N257), .B(n223), .C(ERROR), .Y(n17) );
  NOR4X1 U344 ( .A(n80), .B(n81), .C(n82), .D(n83), .Y(n79) );
  NAND4X1 U345 ( .A(n171), .B(n184), .C(n187), .D(n197), .Y(n80) );
  NAND4X1 U346 ( .A(n186), .B(n196), .C(n177), .D(n172), .Y(n81) );
  NAND4X1 U347 ( .A(n193), .B(n290), .C(n180), .D(n200), .Y(n82) );
  OAI21XL U348 ( .A0(n212), .A1(n211), .B0(n10), .Y(N72) );
  NAND4X1 U349 ( .A(n178), .B(n192), .C(n294), .D(n174), .Y(n87) );
  NAND4X1 U350 ( .A(n185), .B(n181), .C(n191), .D(n198), .Y(n83) );
  NAND4X1 U351 ( .A(n295), .B(n195), .C(n173), .D(n179), .Y(n86) );
  NAND4X1 U352 ( .A(n188), .B(n194), .C(n170), .D(n176), .Y(n84) );
  CLKINVX1 U353 ( .A(n201), .Y(n205) );
  NAND4X1 U354 ( .A(n175), .B(n183), .C(n189), .D(n199), .Y(n85) );
  CLKINVX1 U355 ( .A(n201), .Y(n204) );
  NOR2X1 U356 ( .A(n182), .B(n205), .Y(n15) );
  CLKBUFX3 U357 ( .A(n190), .Y(n212) );
  CLKINVX1 U358 ( .A(n202), .Y(n207) );
  CLKINVX1 U359 ( .A(n19), .Y(n292) );
  NAND2X1 U360 ( .A(n76), .B(n77), .Y(n169) );
  OAI21XL U361 ( .A0(n78), .A1(n79), .B0(n19), .Y(n77) );
  OAI21XL U362 ( .A0(N72), .A1(n214), .B0(ERROR), .Y(n76) );
  NOR4X1 U363 ( .A(n84), .B(n85), .C(n86), .D(n87), .Y(n78) );
  OAI22XL U364 ( .A0(n225), .A1(n200), .B0(n226), .B1(n179), .Y(N117) );
  OAI22XL U365 ( .A0(n225), .A1(n186), .B0(n227), .B1(n175), .Y(N118) );
  OAI22XL U366 ( .A0(n225), .A1(n196), .B0(n228), .B1(n183), .Y(N119) );
  OAI22XL U367 ( .A0(n225), .A1(n177), .B0(n229), .B1(n189), .Y(N120) );
  OAI22XL U368 ( .A0(n225), .A1(n172), .B0(n229), .B1(n199), .Y(N121) );
  OAI22XL U369 ( .A0(n225), .A1(n171), .B0(n229), .B1(n188), .Y(N122) );
  OAI22XL U370 ( .A0(n225), .A1(n184), .B0(n229), .B1(n194), .Y(N123) );
  OAI22XL U371 ( .A0(n225), .A1(n187), .B0(n229), .B1(n170), .Y(N124) );
  OAI22XL U372 ( .A0(n225), .A1(n197), .B0(n229), .B1(n176), .Y(N125) );
  OAI22XL U373 ( .A0(n225), .A1(n181), .B0(n229), .B1(n192), .Y(N126) );
  OAI22XL U374 ( .A0(n225), .A1(n191), .B0(n230), .B1(n294), .Y(N127) );
  OAI22XL U375 ( .A0(n225), .A1(n198), .B0(n230), .B1(n174), .Y(N128) );
  OAI22XL U376 ( .A0(n225), .A1(n193), .B0(n230), .B1(n295), .Y(N129) );
  OAI22XL U377 ( .A0(n225), .A1(n290), .B0(n230), .B1(n195), .Y(N130) );
  OAI22XL U378 ( .A0(n225), .A1(n180), .B0(n230), .B1(n173), .Y(N131) );
  OAI22XL U379 ( .A0(n209), .A1(n282), .B0(n223), .B1(n180), .Y(N190) );
  OAI22XL U380 ( .A0(n210), .A1(n281), .B0(n223), .B1(n178), .Y(N191) );
  OAI22XL U381 ( .A0(n210), .A1(n274), .B0(n223), .B1(n194), .Y(N198) );
  OAI22XL U382 ( .A0(n210), .A1(n275), .B0(n223), .B1(n188), .Y(N197) );
  OAI22XL U383 ( .A0(n210), .A1(n276), .B0(n223), .B1(n199), .Y(N196) );
  OAI22XL U384 ( .A0(n210), .A1(n277), .B0(n223), .B1(n189), .Y(N195) );
  OAI22XL U385 ( .A0(n210), .A1(n278), .B0(n223), .B1(n183), .Y(N194) );
  OAI22XL U386 ( .A0(n210), .A1(n279), .B0(n223), .B1(n175), .Y(N193) );
  OAI22XL U387 ( .A0(n210), .A1(n280), .B0(n223), .B1(n179), .Y(N192) );
  OAI22XL U388 ( .A0(n208), .A1(n274), .B0(n223), .B1(n173), .Y(N206) );
  OAI22XL U389 ( .A0(n209), .A1(n275), .B0(n223), .B1(n195), .Y(N205) );
  OAI22XL U390 ( .A0(n208), .A1(n276), .B0(n223), .B1(n295), .Y(N204) );
  OAI22XL U391 ( .A0(n206), .A1(n277), .B0(n223), .B1(n174), .Y(N203) );
  OAI22XL U392 ( .A0(n206), .A1(n278), .B0(n223), .B1(n294), .Y(N202) );
  OAI22XL U393 ( .A0(n208), .A1(n279), .B0(n223), .B1(n192), .Y(N201) );
  OAI22XL U394 ( .A0(n203), .A1(n280), .B0(n223), .B1(n176), .Y(N200) );
  OAI22XL U395 ( .A0(n208), .A1(n281), .B0(n223), .B1(n170), .Y(N199) );
  OAI22XL U396 ( .A0(n211), .A1(n289), .B0(n223), .B1(n185), .Y(N174) );
  OAI22XL U397 ( .A0(n209), .A1(n283), .B0(n224), .B1(n290), .Y(N189) );
  OAI22XL U398 ( .A0(n211), .A1(n288), .B0(n224), .B1(n200), .Y(N175) );
  OAI22XL U399 ( .A0(n211), .A1(n287), .B0(n224), .B1(n186), .Y(N176) );
  OAI22XL U400 ( .A0(n211), .A1(n286), .B0(n224), .B1(n196), .Y(N177) );
  OAI22XL U401 ( .A0(n210), .A1(n285), .B0(n224), .B1(n177), .Y(N178) );
  OAI22XL U402 ( .A0(n210), .A1(n284), .B0(n224), .B1(n172), .Y(N179) );
  OAI22XL U403 ( .A0(n210), .A1(n283), .B0(n224), .B1(n171), .Y(N180) );
  OAI22XL U404 ( .A0(n210), .A1(n282), .B0(n224), .B1(n184), .Y(N181) );
  OAI22XL U405 ( .A0(n203), .A1(n289), .B0(n224), .B1(n187), .Y(N183) );
  OAI22XL U406 ( .A0(n203), .A1(n288), .B0(n224), .B1(n197), .Y(N184) );
  OAI22XL U407 ( .A0(n209), .A1(n287), .B0(n224), .B1(n181), .Y(N185) );
  OAI22XL U408 ( .A0(n203), .A1(n286), .B0(n224), .B1(n191), .Y(N186) );
  OAI22XL U409 ( .A0(n205), .A1(n285), .B0(n224), .B1(n198), .Y(N187) );
  OAI22XL U410 ( .A0(n207), .A1(n284), .B0(n224), .B1(n193), .Y(N188) );
  AO21X1 U411 ( .A0(n213), .A1(n15), .B0(N182), .Y(N173) );
  CLKINVX1 U412 ( .A(n201), .Y(n203) );
  CLKINVX1 U413 ( .A(n74), .Y(n293) );
  CLKINVX1 U414 ( .A(n202), .Y(n209) );
  CLKINVX1 U415 ( .A(n202), .Y(n208) );
  CLKBUFX3 U416 ( .A(n190), .Y(n213) );
  CLKINVX1 U417 ( .A(n202), .Y(n206) );
  CLKBUFX3 U418 ( .A(n236), .Y(n234) );
  CLKBUFX3 U419 ( .A(n236), .Y(n233) );
  CLKINVX1 U420 ( .A(n256), .Y(n272) );
  CLKBUFX3 U421 ( .A(N256), .Y(n236) );
  CLKINVX1 U422 ( .A(n252), .Y(n273) );
  OAI22XL U423 ( .A0(n108), .A1(n222), .B0(n221), .B1(n109), .Y(N20) );
  OAI22XL U424 ( .A0(n106), .A1(n222), .B0(n221), .B1(n107), .Y(N19) );
  OAI22XL U425 ( .A0(n138), .A1(n222), .B0(n218), .B1(n139), .Y(N35) );
  OAI22XL U426 ( .A0(n140), .A1(n222), .B0(n218), .B1(n141), .Y(N36) );
  OAI22XL U427 ( .A0(n142), .A1(n222), .B0(n218), .B1(n143), .Y(N37) );
  OAI22XL U428 ( .A0(n144), .A1(n222), .B0(n218), .B1(n145), .Y(N38) );
  OAI22XL U429 ( .A0(n146), .A1(n222), .B0(n218), .B1(n147), .Y(N39) );
  OAI22XL U430 ( .A0(n148), .A1(n222), .B0(n218), .B1(n149), .Y(N40) );
  OAI22XL U431 ( .A0(n150), .A1(n222), .B0(n217), .B1(n151), .Y(N41) );
  OAI22XL U432 ( .A0(n152), .A1(n222), .B0(n217), .B1(n153), .Y(N42) );
  OAI22XL U433 ( .A0(n154), .A1(n222), .B0(n217), .B1(n155), .Y(N43) );
  OAI22XL U434 ( .A0(n156), .A1(n222), .B0(n218), .B1(n157), .Y(N44) );
  OAI22XL U435 ( .A0(n158), .A1(n222), .B0(n217), .B1(n159), .Y(N45) );
  OAI22XL U436 ( .A0(n160), .A1(n222), .B0(n217), .B1(n161), .Y(N46) );
  OAI22XL U437 ( .A0(n162), .A1(n222), .B0(n217), .B1(n163), .Y(N47) );
  OAI22XL U438 ( .A0(n104), .A1(n222), .B0(n215), .B1(n105), .Y(N18) );
  OAI22XL U439 ( .A0(n118), .A1(n222), .B0(n220), .B1(n119), .Y(N25) );
  OAI22XL U440 ( .A0(n116), .A1(n222), .B0(n220), .B1(n117), .Y(N24) );
  OAI22XL U441 ( .A0(n114), .A1(n222), .B0(n220), .B1(n115), .Y(N23) );
  OAI22XL U442 ( .A0(n112), .A1(n222), .B0(n220), .B1(n113), .Y(N22) );
  OAI22XL U443 ( .A0(n110), .A1(n222), .B0(n220), .B1(n111), .Y(N21) );
  OAI22XL U444 ( .A0(n130), .A1(n222), .B0(n219), .B1(n131), .Y(N31) );
  OAI22XL U445 ( .A0(n128), .A1(n222), .B0(n219), .B1(n129), .Y(N30) );
  OAI22XL U446 ( .A0(n126), .A1(n222), .B0(n219), .B1(n127), .Y(N29) );
  OAI22XL U447 ( .A0(n124), .A1(n222), .B0(n219), .B1(n125), .Y(N28) );
  OAI22XL U448 ( .A0(n122), .A1(n222), .B0(n220), .B1(n123), .Y(N27) );
  OAI22XL U449 ( .A0(n120), .A1(n222), .B0(n220), .B1(n121), .Y(N26) );
  OAI22XL U450 ( .A0(n164), .A1(n222), .B0(n217), .B1(n165), .Y(N48) );
  OAI22XL U451 ( .A0(n132), .A1(n222), .B0(n219), .B1(n133), .Y(N32) );
  OAI22XL U452 ( .A0(n166), .A1(n222), .B0(n216), .B1(n167), .Y(N49) );
  OAI22XL U453 ( .A0(n134), .A1(n222), .B0(n219), .B1(n135), .Y(N33) );
  OAI22XL U454 ( .A0(n136), .A1(n222), .B0(n219), .B1(n137), .Y(N34) );
  NOR2X1 U455 ( .A(state[0]), .B(n204), .Y(n74) );
  NOR2X1 U456 ( .A(n223), .B(state[0]), .Y(n19) );
  NAND3X1 U457 ( .A(n182), .B(n212), .C(START), .Y(n18) );
  NAND2X1 U458 ( .A(state[2]), .B(n74), .Y(n10) );
  CLKINVX1 U459 ( .A(state[1]), .Y(n202) );
  CLKINVX1 U460 ( .A(reg_a[13]), .Y(n295) );
  CLKINVX1 U461 ( .A(reg_a[11]), .Y(n294) );
  CLKINVX1 U462 ( .A(reg_b[14]), .Y(n290) );
  CLKINVX1 U463 ( .A(state[1]), .Y(n201) );
  OA21X2 U464 ( .A0(n14), .A1(state[2]), .B0(n206), .Y(N223) );
  OAI22XL U465 ( .A0(n88), .A1(n211), .B0(n89), .B1(n293), .Y(N165) );
  OAI22XL U466 ( .A0(n90), .A1(n211), .B0(n91), .B1(n293), .Y(N166) );
  OAI22XL U467 ( .A0(n92), .A1(n211), .B0(n93), .B1(n293), .Y(N167) );
  OAI22XL U468 ( .A0(n94), .A1(n211), .B0(n95), .B1(n293), .Y(N168) );
  OAI22XL U469 ( .A0(n96), .A1(n211), .B0(n97), .B1(n293), .Y(N169) );
  OAI22XL U470 ( .A0(n98), .A1(n211), .B0(n99), .B1(n293), .Y(N170) );
  OAI22XL U471 ( .A0(n100), .A1(n211), .B0(n101), .B1(n293), .Y(N171) );
  OAI22XL U472 ( .A0(n102), .A1(n211), .B0(n103), .B1(n293), .Y(N172) );
  NAND2X1 U473 ( .A(n18), .B(n73), .Y(N182) );
  OAI21XL U474 ( .A0(state[2]), .A1(n182), .B0(n204), .Y(n73) );
  CLKINVX1 U475 ( .A(B[6]), .Y(n283) );
  CLKINVX1 U476 ( .A(B[7]), .Y(n282) );
  CLKINVX1 U477 ( .A(B[1]), .Y(n288) );
  CLKINVX1 U478 ( .A(B[2]), .Y(n287) );
  CLKINVX1 U479 ( .A(B[3]), .Y(n286) );
  CLKINVX1 U480 ( .A(B[4]), .Y(n285) );
  CLKINVX1 U481 ( .A(B[5]), .Y(n284) );
  CLKINVX1 U482 ( .A(A[7]), .Y(n274) );
  CLKINVX1 U483 ( .A(A[6]), .Y(n275) );
  CLKINVX1 U484 ( .A(A[5]), .Y(n276) );
  CLKINVX1 U485 ( .A(A[4]), .Y(n277) );
  CLKINVX1 U486 ( .A(A[3]), .Y(n278) );
  CLKINVX1 U487 ( .A(A[2]), .Y(n279) );
  CLKINVX1 U488 ( .A(A[1]), .Y(n280) );
  CLKINVX1 U489 ( .A(A[0]), .Y(n281) );
  CLKINVX1 U490 ( .A(B[0]), .Y(n289) );
  NAND2X1 U491 ( .A(reg_a[15]), .B(n180), .Y(n252) );
  NAND2X1 U492 ( .A(reg_a[13]), .B(n193), .Y(n266) );
  OR2X1 U493 ( .A(reg_b[14]), .B(n195), .Y(n265) );
  NAND2X1 U494 ( .A(reg_a[11]), .B(n191), .Y(n264) );
  NAND2X1 U495 ( .A(reg_a[12]), .B(n198), .Y(n261) );
  NOR2X1 U496 ( .A(reg_a[9]), .B(n197), .Y(n246) );
  NAND2X1 U497 ( .A(reg_a[3]), .B(n196), .Y(n255) );
  OR2X1 U498 ( .A(reg_b[4]), .B(n189), .Y(n254) );
  NOR2BX1 U499 ( .AN(reg_b[0]), .B(reg_a[0]), .Y(n238) );
  OAI2BB1X1 U500 ( .A0N(n238), .A1N(reg_b[1]), .B0(reg_a[1]), .Y(n237) );
  NAND2X1 U501 ( .A(reg_a[2]), .B(n186), .Y(n253) );
  OAI211X1 U502 ( .A0(reg_b[1]), .A1(n238), .B0(n237), .C0(n253), .Y(n239) );
  OAI221XL U503 ( .A0(reg_a[2]), .A1(n186), .B0(reg_a[3]), .B1(n196), .C0(n239), .Y(n240) );
  AOI32X1 U504 ( .A0(n255), .A1(n254), .A2(n240), .B0(reg_b[4]), .B1(n189), 
        .Y(n242) );
  NAND2BX1 U505 ( .AN(reg_a[5]), .B(reg_b[5]), .Y(n241) );
  NOR2X1 U506 ( .A(n188), .B(reg_b[6]), .Y(n258) );
  NOR2BX1 U507 ( .AN(reg_a[5]), .B(reg_b[5]), .Y(n257) );
  AOI211X1 U508 ( .A0(n242), .A1(n241), .B0(n258), .C0(n257), .Y(n243) );
  AOI221XL U509 ( .A0(reg_b[7]), .A1(n194), .B0(reg_b[6]), .B1(n188), .C0(n243), .Y(n244) );
  NAND2X1 U510 ( .A(reg_a[8]), .B(n187), .Y(n256) );
  NOR2X1 U511 ( .A(n194), .B(reg_b[7]), .Y(n262) );
  OAI32X1 U512 ( .A0(n244), .A1(n272), .A2(n262), .B0(reg_a[8]), .B1(n187), 
        .Y(n245) );
  NAND2X1 U513 ( .A(reg_a[9]), .B(n197), .Y(n260) );
  NAND2X1 U514 ( .A(reg_a[10]), .B(n181), .Y(n259) );
  OAI211X1 U515 ( .A0(n246), .A1(n245), .B0(n260), .C0(n259), .Y(n247) );
  OAI221XL U516 ( .A0(reg_a[10]), .A1(n181), .B0(reg_a[11]), .B1(n191), .C0(
        n247), .Y(n248) );
  NAND3X1 U517 ( .A(n264), .B(n261), .C(n248), .Y(n249) );
  OAI221XL U518 ( .A0(reg_a[12]), .A1(n198), .B0(reg_a[13]), .B1(n193), .C0(
        n249), .Y(n250) );
  AOI32X1 U519 ( .A0(n266), .A1(n265), .A2(n250), .B0(reg_b[14]), .B1(n195), 
        .Y(n251) );
  OAI22XL U520 ( .A0(reg_a[15]), .A1(n180), .B0(n273), .B1(n251), .Y(N256) );
  NAND4BX1 U521 ( .AN(n226), .B(n254), .C(n253), .D(n252), .Y(n271) );
  NAND4BBXL U522 ( .AN(n258), .BN(n257), .C(n256), .D(n255), .Y(n270) );
  NAND4BX1 U523 ( .AN(n262), .B(n261), .C(n260), .D(n259), .Y(n269) );
  NOR2BX1 U524 ( .AN(reg_a[0]), .B(reg_b[0]), .Y(n263) );
  OAI22XL U525 ( .A0(n263), .A1(n200), .B0(reg_a[1]), .B1(n263), .Y(n267) );
  NAND4X1 U526 ( .A(n267), .B(n266), .C(n265), .D(n264), .Y(n268) );
  NOR4X1 U527 ( .A(n271), .B(n270), .C(n269), .D(n268), .Y(N257) );
endmodule

