/*

This is a script to run the remaining 3-generated 4-transposition groups with the ParAxlAlg code.  There are 31 such groups.  Run in a screen as follows:

magma grp:=25 lb:=1 ub:=500 3gen4trans_script.m

to run shapes between lb = 1 and ub = 500 for the group numbered grp = 25.

Will output a log file and two tex files into the directory 3gen4trans (** ensure this exists**)

3gen4trans_grp_lb_ub.log
3gen4trans_grp_lb_ub_long.tex
3gen4trans_grp_lb_ub_short.tex

The long one is all the info.  The short one is only the short info and omits all the 0-dim algebras.

Groups are: <group, orbits, #shapes>

1     <"C1", [ 1, 1, 1 ], 4>,
2     <"C2^2", [ 1, 2, 2 ], 6>,
3     <"C2^2", [ 2, 2, 2 ], 2>,
4     <"C2^2", [ 2, 2, 2 ], 6>,
5     <"S3", [ 1, 3 ], 4>,
6     <"C2^3", [ 2, 2, 4 ], 4>,
7     <"C2^3", [ 2, 2, 4 ], 18>,
8     <"C2^3", [ 2, 4, 4 ], 12>,
9     <"C2^3", [ 4, 4, 4 ], 20>,
10    <"C2*D4", [ 4, 4, 8 ], 80>,
11    <"C3:S3", [ 9 ], 5>,
12    <"S4", [ 6 ], 4>,
13    <"S4", [ 3, 6 ], 8>,
14    <"C2^2wrC2", [ 4, 4, 4 ], 24>,
15    <"C2^2wrC2", [ 4, 8, 8 ], 216>,
16    <"C2wrC2^2", [ 4, 4, 8 ], 24>,
17    <"C2wrC2^2", [ 8, 8, 8 ], 288>,
18    <"C2.C4:D4", [ 8, 8, 8 ], 364>,
19    <"S3wrC2", [ 6, 6 ], 6>,
20    <"C4^2:C3:C2", [ 12 ], 4>,
21    <"C2^2:S4", [ 6, 12 ], 16>,
22    <"C2^2:S4", [ 12, 12 ], 16>,
23    <"C2^4.C2^3", [ 8, 8, 16 ], 1560>,
24    <"PSL(2,7)", [ 21 ], 4>,
25    <"C2^5.C2^3", [ 8, 16, 16 ], 2520>,
26    <"C2^5.C2^3", [ 16, 16, 16 ], 1540>,
27    <"C2^5.D4.C2", [ 16, 16, 32 ], 2520>,
28    <"C2^4.C2^4.C2^2", [ 16, 32, 32 ], 1560>,
29    <"C2^5.C2^2wrC2", [ 32, 32, 32 ], 364>,
30    <"A4^2.D4", [ 12, 24 ], 32>,
31    <"C3^4.D4:C2", [ 18, 18, 18 ], 26>

cant_complete, dim0, usedshapetypes := ZeroDim(10);

G := group_list[6];
Ax := GSet(G);
tau, stab := Explode(AdmissibleTauMaps(Ax)[1]);
shapes := Shapes(Ax, tau, stab);

[<GroupName(G), [#o : o in Orbits(G, Ax)], &cat[t[3,i,2] : i in [1..#t[3]]]> where G:=Group(Ax) where Ax := t[1] : t in maxs];

can't complete list:

14 - [ 1, 2, 7, 8, 9, 10 ]
15 - [ 10, 20 ]
16 - [ 14, 16, 18 ]
17 - [ 13, 145, 166, 251 ]
18 - [ 17, 18, 19, 20, 139, 301, 361 ]
22 - all complete
23 - [ 104, 488 ]
24 - [ 1 ]
25 - [ 35, 36, 239, 319, 390, 623 ]
26 - [ 1, 35, 138, 169, 1485 ]
27 - []
28 - []
29 - [ 47 ]
30 - [ 1, 9 ]
31 - [ 1, 14 ]

*/
group_list := [sub< Sym(3) | [ [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3 ]]>,
sub< Sym(5) | [ [ 1, 2, 3, 4, 5 ], [ 1, 2, 3, 5, 4 ], [ 1, 3, 2, 4, 5 ]]>,
sub< Sym(6) | [ [ 1, 2, 4, 3, 6, 5 ], [ 2, 1, 3, 4, 6, 5 ], [ 2, 1, 4, 3, 5, 6 
]]>,
sub< Sym(6) | [ [ 2, 1, 3, 4, 5, 6 ], [ 2, 1, 3, 4, 5, 6 ], [ 1, 2, 4, 3, 6, 5 
]]>,
sub< Sym(4) | [ [ 1, 2, 4, 3 ], [ 1, 3, 2, 4 ], [ 1, 2, 3, 4 ]]>,
sub< Sym(8) | [ [ 1, 2, 4, 3, 6, 5, 8, 7 ], [ 2, 1, 3, 4, 7, 8, 5, 6 ], [ 2, 1, 
4, 3, 5, 6, 7, 8 ]]>,
sub< Sym(8) | [ [ 1, 2, 3, 4, 6, 5, 8, 7 ], [ 1, 2, 3, 4, 7, 8, 5, 6 ], [ 2, 1, 
4, 3, 5, 6, 7, 8 ]]>,
sub< Sym(10) | [ [ 1, 2, 4, 3, 6, 5, 8, 7, 10, 9 ], [ 2, 1, 3, 4, 5, 6, 9, 10, 
7, 8 ], [ 2, 1, 5, 6, 3, 4, 7, 8, 9, 10 ]]>,
sub< Sym(12) | [ [ 1, 2, 3, 4, 6, 5, 8, 7, 10, 9, 12, 11 ], [ 2, 1, 4, 3, 5, 6, 
7, 8, 11, 12, 9, 10 ], [ 3, 4, 1, 2, 7, 8, 5, 6, 9, 10, 11, 12 ]]>,
sub< Sym(16) | [ [ 1, 2, 3, 4, 6, 5, 8, 7, 10, 9, 13, 14, 11, 12, 16, 15 ], [ 2,
1, 4, 3, 5, 6, 7, 8, 11, 12, 9, 10, 15, 16, 13, 14 ], [ 3, 4, 1, 2, 7, 8, 5, 6, 
9, 10, 11, 12, 13, 14, 15, 16 ]]>,
sub< Sym(9) | [ [ 1, 4, 6, 2, 7, 3, 5, 9, 8 ], [ 2, 1, 7, 4, 9, 8, 3, 6, 5 ], [ 
3, 5, 1, 8, 2, 6, 9, 4, 7 ]]>,
sub< Sym(6) | [ [ 1, 4, 5, 2, 3, 6 ], [ 2, 1, 3, 4, 6, 5 ], [ 3, 2, 1, 6, 5, 4 
]]>,
sub< Sym(9) | [ [ 2, 1, 3, 4, 7, 6, 5, 9, 8 ], [ 1, 3, 2, 5, 4, 8, 7, 6, 9 ], [ 
1, 2, 3, 6, 8, 4, 7, 5, 9 ]]>,
sub< Sym(12) | [ [ 1, 2, 3, 4, 6, 5, 8, 7, 10, 9, 12, 11 ], [ 2, 1, 4, 3, 5, 6, 
7, 8, 11, 10, 9, 12 ], [ 3, 4, 1, 2, 7, 6, 5, 8, 9, 10, 11, 12 ]]>,
sub< Sym(20) | [ [ 1, 2, 3, 4, 5, 6, 7, 8, 10, 9, 13, 14, 11, 12, 16, 15, 18, 
17, 20, 19 ], [ 2, 1, 5, 6, 3, 4, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16, 19, 20, 
17, 18 ], [ 3, 4, 1, 2, 7, 8, 5, 6, 11, 12, 9, 10, 15, 16, 13, 14, 17, 18, 19, 
20 ]]>,
sub< Sym(16) | [ [ 1, 2, 3, 4, 6, 5, 8, 7, 10, 9, 12, 11, 13, 15, 14, 16 ], [ 2,
1, 4, 3, 5, 6, 7, 9, 8, 10, 11, 12, 14, 13, 16, 15 ], [ 1, 3, 2, 4, 7, 8, 5, 6, 
11, 12, 9, 10, 13, 14, 15, 16 ]]>,
sub< Sym(24) | [ [ 1, 2, 3, 5, 4, 6, 7, 8, 10, 9, 13, 14, 11, 12, 16, 15, 18, 
17, 21, 22, 19, 20, 24, 23 ], [ 2, 1, 5, 6, 3, 4, 8, 7, 9, 10, 11, 12, 13, 14, 
15, 16, 19, 20, 17, 18, 23, 24, 21, 22 ], [ 3, 4, 1, 2, 7, 8, 5, 6, 11, 12, 9, 
10, 15, 16, 13, 14, 17, 18, 19, 20, 21, 22, 23, 24 ]]>,
sub< Sym(24) | [ [ 1, 2, 3, 4, 5, 6, 7, 8, 10, 9, 13, 14, 11, 12, 16, 15, 18, 
17, 21, 22, 19, 20, 24, 23 ], [ 2, 1, 5, 6, 3, 4, 8, 7, 9, 10, 11, 12, 13, 14, 
15, 16, 19, 20, 17, 18, 23, 24, 21, 22 ], [ 3, 4, 1, 2, 7, 8, 5, 6, 11, 12, 9, 
10, 15, 16, 13, 14, 17, 18, 19, 20, 21, 22, 23, 24 ]]>,
sub< Sym(12) | [ [ 2, 1, 5, 6, 3, 4, 7, 10, 9, 8, 11, 12 ], [ 3, 4, 1, 2, 6, 5, 
8, 7, 9, 10, 11, 12 ], [ 1, 2, 3, 5, 4, 6, 9, 11, 7, 12, 8, 10 ]]>,
sub< Sym(12) | [ [ 1, 4, 6, 2, 9, 3, 11, 12, 5, 10, 7, 8 ], [ 2, 1, 7, 4, 10, 8,
3, 6, 9, 5, 12, 11 ], [ 3, 5, 1, 8, 2, 6, 10, 4, 12, 7, 11, 9 ]]>,
sub< Sym(18) | [ [ 2, 1, 5, 6, 3, 4, 7, 10, 9, 8, 14, 16, 17, 11, 15, 12, 13, 18
], [ 3, 4, 1, 2, 6, 5, 8, 7, 12, 10, 15, 9, 13, 14, 11, 16, 18, 17 ], [ 1, 2, 3,
4, 5, 6, 9, 11, 7, 13, 8, 17, 10, 16, 18, 14, 12, 15 ]]>,
sub< Sym(24) | [ [ 2, 1, 5, 6, 3, 4, 9, 11, 7, 12, 8, 10, 13, 16, 15, 14, 20, 
22, 23, 17, 21, 18, 19, 24 ], [ 3, 4, 1, 2, 6, 5, 10, 9, 8, 7, 12, 11, 14, 13, 
18, 16, 21, 15, 19, 20, 17, 22, 24, 23 ], [ 1, 2, 3, 7, 8, 6, 4, 5, 9, 10, 11, 
12, 15, 17, 13, 19, 14, 23, 16, 22, 24, 20, 18, 21 ]]>,
sub< Sym(32) | [ [ 1, 2, 3, 4, 5, 6, 7, 8, 10, 9, 13, 14, 11, 12, 16, 15, 18, 
17, 21, 22, 19, 20, 27, 26, 29, 24, 23, 32, 25, 31, 30, 28 ], [ 2, 1, 5, 6, 3, 
4, 8, 7, 9, 10, 11, 12, 13, 14, 15, 16, 19, 20, 17, 18, 24, 26, 28, 21, 30, 22, 
31, 23, 32, 25, 27, 29 ], [ 3, 4, 1, 2, 7, 8, 5, 6, 11, 12, 9, 10, 15, 16, 13, 
14, 17, 18, 19, 23, 25, 22, 20, 24, 21, 26, 27, 28, 29, 30, 31, 32 ]]>,
sub< Sym(21) | [ [ 1, 4, 6, 2, 9, 3, 12, 14, 5, 10, 16, 7, 13, 8, 18, 11, 17, 
15, 19, 21, 20 ], [ 2, 1, 7, 4, 10, 11, 3, 8, 9, 5, 6, 16, 15, 17, 13, 12, 14, 
18, 21, 20, 19 ], [ 3, 5, 1, 8, 2, 6, 13, 4, 14, 15, 11, 12, 7, 9, 10, 19, 20, 
18, 16, 17, 21 ]]>,
sub< Sym(40) | [ [ 1, 2, 3, 6, 8, 4, 7, 5, 9, 10, 11, 12, 13, 14, 15, 16, 18, 
17, 21, 22, 19, 20, 27, 29, 26, 25, 23, 32, 24, 31, 30, 28, 34, 33, 37, 38, 35, 
36, 40, 39 ], [ 2, 1, 5, 7, 3, 10, 4, 13, 12, 6, 16, 9, 8, 15, 14, 11, 17, 18, 
19, 23, 24, 22, 20, 21, 25, 26, 27, 28, 29, 30, 31, 32, 35, 36, 33, 34, 39, 40, 
37, 38 ], [ 3, 4, 1, 2, 9, 11, 12, 14, 5, 15, 6, 7, 16, 8, 10, 13, 19, 20, 17, 
18, 25, 26, 28, 30, 21, 22, 31, 23, 32, 24, 27, 29, 33, 34, 35, 36, 37, 38, 39, 
40 ]]>,
sub< Sym(48) | [ [ 1, 2, 3, 6, 8, 4, 7, 5, 9, 10, 11, 12, 13, 14, 15, 16, 18, 
17, 21, 22, 19, 20, 27, 29, 26, 25, 23, 32, 24, 31, 30, 28, 34, 33, 37, 38, 35, 
36, 43, 42, 45, 40, 39, 48, 41, 47, 46, 44 ], [ 2, 1, 5, 7, 3, 10, 4, 13, 12, 6,
16, 9, 8, 15, 14, 11, 17, 18, 19, 23, 24, 22, 20, 21, 25, 26, 27, 28, 29, 30, 
31, 32, 35, 36, 33, 34, 40, 42, 44, 37, 46, 38, 47, 39, 48, 41, 43, 45 ], [ 3, 
4, 1, 2, 9, 11, 12, 14, 5, 15, 6, 7, 16, 8, 10, 13, 19, 20, 17, 18, 25, 26, 28, 
30, 21, 22, 31, 23, 32, 24, 27, 29, 33, 34, 35, 39, 41, 38, 36, 40, 37, 42, 43, 
44, 45, 46, 47, 48 ]]>,
sub< Sym(64) | [ [ 1, 2, 3, 6, 8, 4, 7, 5, 9, 10, 11, 12, 13, 14, 15, 16, 18, 
17, 21, 22, 19, 20, 27, 29, 26, 25, 23, 32, 24, 31, 30, 28, 34, 33, 37, 38, 35, 
36, 43, 42, 45, 40, 39, 49, 41, 51, 52, 54, 44, 56, 46, 47, 59, 48, 60, 50, 61, 
62, 53, 55, 57, 58, 64, 63 ], [ 2, 1, 5, 7, 3, 10, 4, 13, 12, 6, 16, 9, 8, 15, 
14, 11, 17, 18, 19, 23, 24, 22, 20, 21, 25, 26, 27, 28, 29, 30, 31, 32, 35, 36, 
33, 34, 40, 42, 44, 37, 46, 38, 48, 39, 50, 41, 53, 43, 55, 45, 57, 58, 47, 60, 
49, 61, 51, 52, 63, 54, 56, 64, 59, 62 ], [ 3, 4, 1, 2, 9, 11, 12, 14, 5, 15, 6,
7, 16, 8, 10, 13, 19, 20, 17, 18, 25, 26, 28, 30, 21, 22, 31, 23, 32, 24, 27, 
29, 33, 34, 35, 39, 41, 38, 36, 40, 37, 47, 43, 44, 45, 46, 42, 51, 49, 50, 48, 
52, 53, 54, 55, 56, 57, 60, 61, 58, 59, 62, 63, 64 ]]>,
sub< Sym(80) | [ [ 1, 2, 3, 6, 8, 4, 7, 5, 9, 10, 11, 17, 13, 14, 19, 16, 12, 
18, 15, 20, 21, 22, 23, 24, 25, 27, 26, 29, 28, 30, 31, 32, 34, 33, 37, 38, 35, 
36, 43, 45, 42, 41, 39, 48, 40, 47, 46, 44, 50, 49, 53, 54, 51, 52, 59, 58, 61, 
56, 55, 65, 57, 67, 68, 70, 60, 72, 62, 63, 75, 64, 76, 66, 77, 78, 69, 71, 73, 
74, 80, 79 ], [ 2, 1, 5, 7, 3, 10, 4, 13, 12, 6, 16, 9, 8, 19, 20, 11, 22, 24, 
14, 15, 26, 17, 28, 18, 29, 21, 30, 23, 25, 27, 32, 31, 33, 34, 35, 39, 40, 38, 
36, 37, 41, 42, 43, 44, 45, 46, 47, 48, 51, 52, 49, 50, 56, 58, 60, 53, 62, 54, 
64, 55, 66, 57, 69, 59, 71, 61, 73, 74, 63, 76, 65, 77, 67, 68, 79, 70, 72, 80, 
75, 78 ], [ 3, 4, 1, 2, 9, 11, 12, 14, 5, 15, 6, 7, 18, 8, 10, 21, 23, 13, 25, 
26, 16, 27, 17, 29, 19, 20, 22, 31, 24, 32, 28, 30, 35, 36, 33, 34, 41, 42, 44, 
46, 37, 38, 47, 39, 48, 40, 43, 45, 49, 50, 51, 55, 57, 54, 52, 56, 53, 63, 59, 
60, 61, 62, 58, 67, 65, 66, 64, 68, 69, 70, 71, 72, 73, 76, 77, 74, 75, 78, 79, 
80 ]]>,
sub< Sym(96) | [ [ 1, 2, 3, 6, 8, 4, 7, 5, 9, 10, 11, 17, 13, 14, 19, 16, 12, 
18, 15, 20, 21, 22, 23, 24, 25, 27, 26, 29, 28, 30, 31, 32, 34, 33, 37, 38, 35, 
36, 43, 45, 42, 41, 39, 49, 40, 51, 52, 54, 44, 56, 46, 47, 59, 48, 60, 50, 61, 
62, 53, 55, 57, 58, 64, 63, 66, 65, 69, 70, 67, 68, 75, 74, 77, 72, 71, 81, 73, 
83, 84, 86, 76, 88, 78, 79, 91, 80, 92, 82, 93, 94, 85, 87, 89, 90, 96, 95 ], [ 
2, 1, 5, 7, 3, 10, 4, 13, 12, 6, 16, 9, 8, 19, 20, 11, 22, 24, 14, 15, 26, 17, 
28, 18, 29, 21, 30, 23, 25, 27, 32, 31, 33, 34, 35, 39, 40, 38, 36, 37, 41, 47, 
43, 44, 45, 46, 42, 51, 49, 50, 48, 52, 53, 54, 55, 56, 57, 60, 61, 58, 59, 62, 
63, 64, 67, 68, 65, 66, 72, 74, 76, 69, 78, 70, 80, 71, 82, 73, 85, 75, 87, 77, 
89, 90, 79, 92, 81, 93, 83, 84, 95, 86, 88, 96, 91, 94 ], [ 3, 4, 1, 2, 9, 11, 
12, 14, 5, 15, 6, 7, 18, 8, 10, 21, 23, 13, 25, 26, 16, 27, 17, 29, 19, 20, 22, 
31, 24, 32, 28, 30, 35, 36, 33, 34, 41, 42, 44, 46, 37, 38, 48, 39, 50, 40, 53, 
43, 55, 45, 57, 58, 47, 60, 49, 61, 51, 52, 63, 54, 56, 64, 59, 62, 65, 66, 67, 
71, 73, 70, 68, 72, 69, 79, 75, 76, 77, 78, 74, 83, 81, 82, 80, 84, 85, 86, 87, 
88, 89, 92, 93, 90, 91, 94, 95, 96 ]]>,
sub< Sym(36) | [ [ 2, 1, 5, 6, 3, 4, 9, 10, 7, 8, 12, 11, 13, 16, 15, 14, 20, 
22, 24, 17, 21, 18, 23, 19, 29, 31, 27, 28, 25, 30, 26, 33, 32, 34, 35, 36 ], [ 
3, 4, 1, 2, 6, 5, 10, 11, 12, 7, 8, 9, 14, 13, 18, 16, 21, 15, 19, 20, 17, 22, 
26, 28, 30, 23, 32, 24, 29, 25, 31, 27, 33, 34, 35, 36 ], [ 1, 2, 3, 7, 8, 6, 4,
5, 9, 10, 11, 12, 15, 17, 13, 19, 14, 23, 16, 25, 26, 27, 18, 29, 20, 21, 22, 
33, 24, 34, 35, 36, 28, 30, 31, 32 ]]>,
sub< Sym(54) | [ [ 1, 2, 3, 6, 8, 4, 7, 5, 9, 10, 11, 15, 13, 16, 12, 14, 17, 
18, 20, 19, 23, 24, 21, 22, 29, 30, 28, 27, 25, 26, 34, 35, 36, 31, 32, 33, 38, 
37, 41, 42, 39, 40, 47, 46, 48, 44, 43, 45, 52, 53, 54, 49, 50, 51 ], [ 2, 1, 5,
7, 3, 10, 4, 11, 12, 6, 8, 9, 16, 17, 18, 13, 14, 15, 19, 20, 21, 25, 26, 24, 
22, 23, 27, 32, 29, 30, 31, 28, 34, 33, 35, 36, 39, 40, 37, 38, 44, 46, 48, 41, 
49, 42, 51, 43, 45, 53, 47, 54, 50, 52 ], [ 3, 4, 1, 2, 9, 11, 12, 13, 5, 14, 6,
7, 8, 10, 18, 17, 16, 15, 21, 22, 19, 20, 27, 28, 30, 31, 23, 24, 33, 25, 26, 
35, 29, 36, 32, 34, 37, 38, 39, 43, 45, 42, 40, 44, 41, 50, 47, 48, 49, 46, 52, 
51, 53, 54 ]]>];



AttachSpec("ParAxlAlg.spec");
SetVerbose("ParAxlAlg", 4);

/*

Now we load each case in turn and use the following functions

*/
field := Rationals();

// It is slow to use the normal saving method for the 2-groups as it checks isomorphism with many other possible shapes
procedure FastSave(A, ~usedshapetypes)
  G := Group(A);
  Ax := A`GSet;
  Ax_num_axes := Join([ IntegerToString(#o) : o in Orbits(G, Ax)], "+");
  shapetype := &cat [ sh[2] : sh in A`shape];
  if shapetype in usedshapetypes then
    filename := Filename(A);
  else
    path := Sprintf("%o/%m/%o/%o", "library", field, MyGroupName(G), Ax_num_axes);
    filename := path cat Sprintf("/%o_%o.json", shapetype, 1);
  end if;
  Include(~usedshapetypes, shapetype);
  
  PrintFile(filename, JSON(A): Overwrite:=true);
end procedure;
/*

We use the follwing to find all subalgebras on the set of axes < Ax

*/
function FindPossibleSubalgebras(Ax, tau, axes)
  G := Group(Ax);
  K := sub<G | FewGenerators(sub<G | axes@tau>)>;
  num := IndexedSet([1..#axes]);
  numxK := CartesianProduct(num, K);
  f := map<numxK -> num | y:-> Position(axes, Image(y[2], Ax, axes[y[1]]))>;
  Kx := GSet(K, num, f);

  // Find a faithful action of a subgroup, K is a central extension of this.
  phi, K_faithful := Action(K, Kx);
  Kx_faithful := GSet(K_faithful, Kx);

  Ktau := map<Kx -> K | i:-> axes[i]@tau>;
  Ktau_faithful := Ktau*phi;

  num_axes := Join([ IntegerToString(#o) : o in Orbits(K_faithful, Kx_faithful)], "+");

  path := Sprintf("library/%m/%o/%o", Rationals(), MyGroupName(K_faithful), num_axes);
  assert ExistsPath(path);

  algs := ls(path);
  algs := [ alg : alg in algs | "partial" notin alg];
  alg_shapes := [ ParseShape(sh) : sh in algs];
  alg_types := [ GetTypePartialAxialAlgebra(Sprintf("%o/%o", path, algs[j])) : j in [1..#algs]];

  return K, Kx_faithful, Ktau_faithful, alg_shapes, alg_types;
end function;
/*

For a given list of indexes L, sieve the shapes checking whether axes gives a trivial subalgebra.

*/
function SieveList(Ax, tau, shapes, L, axes, usedshapetypes)
  K, Kx_faithful, Ktau_faithful, alg_shapes, alg_types := FindPossibleSubalgebras(Ax, tau, axes);
  G := Group(Ax);
  dim0 := [];
  still := [];
  
  for i in L do
    shape := shapes[i,3];
    // We search for possible isomorphic algebras by checking the shape
    Kshape, flags := RestrictShape(Ax, tau, shape, K, axes);
    Kshape := [ <{@ Position(axes, j) : j in t[1] @}, t[2]> : t in Kshape ];
    
    shape_type := ParseShape(&cat[t[2] : t in Kshape]);
    possible_gluings := {@ j : j in [1..#alg_shapes] | alg_shapes[j] eq shape_type @};
    
    if #possible_gluings eq 0 then
      Append(~still, i);
      continue;
    end if;
          
    // Have to do it this slightly awkward way so the continue statement works...
    so := false;
    index := 1;
    while not so and index le #possible_gluings do
      j := possible_gluings[index];
      _, alg_ax, alg_tau, alg_shape, dim := Explode(alg_types[j]);
      
      so, perm, homg, _ := IsIsomorphic(Kx_faithful, Ktau_faithful, Kshape, alg_ax, alg_tau, alg_shape);
      index +:= 1;
    end while;
          
    // There is no match, or the algebra is not zero dim
    if not so or dim ne 0 then
      Append(~still, i);
      continue;
    end if;
          
    // We have found a match with a zero dim algebra
   
    printf "%o, ", i;
    Append(~dim0, i);

    A := New(ParAxlAlg);
    A`GSet := Ax;
    A`tau := tau;
    A`shape := shape;
    A`number_of_axes := #Ax;
    A`fusion_table := MonsterFusionTable();
    A`Wmod := GModule(G, MatrixAlgebra<field,0|[ZeroMatrix(field,0,0) : g in Generators(G)]>);
    A`W := RSpace(field, Dimension(A`Wmod));
    A`V := A`W;
    A`GSet_to_axes := map<Ax -> A`W | i :-> A`W!0>;
    FastSave(A, ~usedshapetypes);
  end for;
  
  return still, dim0, usedshapetypes;
end function;
/*

Find the next shape which has a 0-dim subalgebra to be glued in

*/
function SelectNext(Ax, tau, shapes, to_process)
  for i in to_process do
    subalgs := GluingSubalgebras(Ax, tau, shapes[i,3]);
    if #subalgs eq 1 then
      type := GetTypePartialAxialAlgebra(subalgs[1,1]);
      if type[5] eq 0 then
        return true, i, Domain(subalgs[1,2]);
      end if;
    end if;
  end for;
  
  return false, #to_process+1, _;
end function;
/*

Function to loop over all shapes and try to glue in 0-dim algebras.  It returns the indexes it can't finish

*/
function ZeroDim(grp)
  G := group_list[grp];
  Ax := GSet(G);
  tau, stab := Explode(AdmissibleTauMaps(Ax)[1]);
  shapes := Shapes(Ax, tau, stab);

  Ax_num_axes := Join([ IntegerToString(#o) : o in Orbits(G, Ax)], "+");
  path := Sprintf("%o/%m/%o/%o", "library", field, MyGroupName(G), Ax_num_axes);
  System(Sprintf("mkdir -p '%o'", path));

  to_process := [1..#shapes];
  cant_complete:=[];
  dim0:=[];
  usedshapetypes := {@ @};
  
  repeat
    so, i, axes := SelectNext(Ax, tau, shapes, to_process);
    pos := Position(to_process, i);
    if pos ne 0 then
      cant_complete cat:= to_process[1..pos-1];
      to_process := to_process[pos..#to_process];
    else
      assert not so;
      cant_complete cat:= to_process;
      to_process := [];
    end if;
    if so then
      to_process, newdim0, usedshapetypes := SieveList(Ax, tau, shapes, to_process, axes, usedshapetypes);
      dim0 cat:= newdim0;
    end if;
  until not so;

  assert #to_process eq 0;
  assert Set(cant_complete) join Set(dim0) eq {1..#shapes};
  
  return cant_complete, dim0, usedshapetypes;
end function;

// To run, first select the case

/*
This is some code which may be useful to examine properties of the algebras if they have already been computed and saved.

// Some code to read the info off disk and generate latex tables

// do the 0-dim algebras

PrintZeroDim(i)

out := "";
for l in lines do
  txt := Split(l, "&");
  if #txt gt 2 then
    multi := ParseShape(txt[3][2..#txt[3]-1]);
    set := Set(multi);
    set := Setseq(set);
    Sort(~set, ShapeSort);
    newtxt := "$" cat Join([Sprintf("(%o\\%o)^%o", x[1], x[2], Multiplicity(multi, x)) : x in set], " ") cat "$";
    ll := Join([t : t in txt[1..2]], "&") cat "& " cat newtxt cat " &" cat Join([t : t in txt[4..#txt]], "&");
  else
    ll := l;
  end if;
  out cat:= ll cat "\n";
end for;
Write("table", out);

  PrintProperties(algs, Sprintf("3gen4trans/3gen4trans_long.tex", grp, lb, ub): long:=true, header:=false);

  PrintProperties(algs, Sprintf("3gen4trans/3gen4trans_short.tex", grp, lb, ub): long:=false, header:=false, zerodim:=false);

*/
