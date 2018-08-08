# sdram & systemverilog test

> learn sdram usage
> learn system verilog

## write log
```
# At time    200000 ns: Command => PrechargeAllBanks
# at time    200020 ns PRE  : Bank = ALL
# At time    200040 ns: Command => AutoRefresh
# at time    200060 ns AREF : Auto Refresh
# At time    200120 ns: Command => AutoRefresh
# at time    200140 ns AREF : Auto Refresh
# At time    200200 ns: Command => ModeRegisterSet
# at time    200220 ns LMR  : Load Mode Register
#                             CAS Latency      = 2
#                             Burst Length     = 4
#                             Burst Type       = Sequential
#                             Write Burst Mode = Programmed Burst Length
# At time    200240 ns: FLAG => INITIAL FINISH
# At time    200300 ns: Command => AutoRefresh
# at time    200320 ns AREF : Auto Refresh
# At time    200360 ns: Flag => refershFinishFlag
# At time    200390 ns: Trig => writeonce
# At time    200420 ns: Command => BankActive
# at time    200440 ns ACT  : Bank = 0 Row =    0
# At time    200460 ns: Command => sdram_write
# at time    200480 ns WRITE: Bank = 0 Row =    0, Col =   0, Data =     1, Dqm = 0000
# at time    200500 ns WRITE: Bank = 0 Row =    0, Col =   1, Data =     2, Dqm = 0000
# at time    200520 ns WRITE: Bank = 0 Row =    0, Col =   2, Data =     3, Dqm = 0000
# At time    200540 ns: Command => PrechargeAllBanks
# at time    200540 ns WRITE: Bank = 0 Row =    0, Col =   3, Data =     4, Dqm = 0000
# At time    200560 ns: Flag => writeonce fin
# at time    200560 ns PRE  : Bank = ALL
```

## read log

```
run
# At time    200000 ns: Command => PrechargeAllBanks
# at time    200020 ns PRE  : Bank = ALL
# At time    200040 ns: Command => AutoRefresh
# at time    200060 ns AREF : Auto Refresh
# At time    200120 ns: Command => AutoRefresh
# at time    200140 ns AREF : Auto Refresh
# At time    200200 ns: Command => ModeRegisterSet
# at time    200220 ns LMR  : Load Mode Register
#                             CAS Latency      = 2
#                             Burst Length     = 4
#                             Burst Type       = Sequential
#                             Write Burst Mode = Programmed Burst Length
# At time    200240 ns: FLAG => INITIAL FINISH
# At time    200300 ns: Command => AutoRefresh
# at time    200320 ns AREF : Auto Refresh
# At time    200360 ns: Flag => refershFinishFlag
# At time    200390 ns: Trig => writeonce
# At time    200420 ns: Command => BankActive
# at time    200440 ns ACT  : Bank = 0 Row =    0
# At time    200460 ns: Command => sdram_write
# At time    200470 ns: write =>     0
# at time    200480 ns WRITE: Bank = 0 Row =    0, Col =   0, Data =     0, Dqm = 0000
# At time    200490 ns: write =>     1
# at time    200500 ns WRITE: Bank = 0 Row =    0, Col =   1, Data =     1, Dqm = 0000
# At time    200510 ns: write =>     2
# at time    200520 ns WRITE: Bank = 0 Row =    0, Col =   2, Data =     2, Dqm = 0000
# At time    200530 ns: write =>     3
# At time    200540 ns: Command => PrechargeAllBanks
# at time    200540 ns WRITE: Bank = 0 Row =    0, Col =   3, Data =     3, Dqm = 0000
# At time    200560 ns: Flag => writeonce fin
# at time    200560 ns PRE  : Bank = ALL
# At time    200610 ns: Trig => writeonce
# At time    200640 ns: Command => BankActive
# at time    200660 ns ACT  : Bank = 0 Row =    0
# At time    200680 ns: Command => sdram_write
# At time    200690 ns: write =>     4
# at time    200700 ns WRITE: Bank = 0 Row =    0, Col =   4, Data =     4, Dqm = 0000
# At time    200710 ns: write =>     5
# at time    200720 ns WRITE: Bank = 0 Row =    0, Col =   5, Data =     5, Dqm = 0000
# At time    200730 ns: write =>     6
# at time    200740 ns WRITE: Bank = 0 Row =    0, Col =   6, Data =     6, Dqm = 0000
# At time    200750 ns: write =>     7
# At time    200760 ns: Command => PrechargeAllBanks
# at time    200760 ns WRITE: Bank = 0 Row =    0, Col =   7, Data =     7, Dqm = 0000
# At time    200780 ns: Flag => writeonce fin
# at time    200780 ns PRE  : Bank = ALL
# At time    200830 ns: Trig => writeonce
# At time    200860 ns: Command => BankActive
# at time    200880 ns ACT  : Bank = 0 Row =    0
# At time    200900 ns: Command => sdram_write
# At time    200910 ns: write =>     8
# at time    200920 ns WRITE: Bank = 0 Row =    0, Col =   8, Data =     8, Dqm = 0000
# At time    200930 ns: write =>     9
# at time    200940 ns WRITE: Bank = 0 Row =    0, Col =   9, Data =     9, Dqm = 0000
# At time    200950 ns: write =>    10
# at time    200960 ns WRITE: Bank = 0 Row =    0, Col =  10, Data =    10, Dqm = 0000
# At time    200970 ns: write =>    11
# At time    200980 ns: Command => PrechargeAllBanks
# at time    200980 ns WRITE: Bank = 0 Row =    0, Col =  11, Data =    11, Dqm = 0000
# At time    201000 ns: Flag => writeonce fin
# at time    201000 ns PRE  : Bank = ALL
# At time    201050 ns: Trig => writeonce
# At time    201080 ns: Command => BankActive
# at time    201100 ns ACT  : Bank = 0 Row =    0
# At time    201120 ns: Command => sdram_write
# At time    201130 ns: write =>    12
# at time    201140 ns WRITE: Bank = 0 Row =    0, Col =  12, Data =    12, Dqm = 0000
# At time    201150 ns: write =>    13
# at time    201160 ns WRITE: Bank = 0 Row =    0, Col =  13, Data =    13, Dqm = 0000
# At time    201170 ns: write =>    14
# at time    201180 ns WRITE: Bank = 0 Row =    0, Col =  14, Data =    14, Dqm = 0000
# At time    201190 ns: write =>    15
# At time    201200 ns: Command => PrechargeAllBanks
# at time    201200 ns WRITE: Bank = 0 Row =    0, Col =  15, Data =    15, Dqm = 0000
# At time    201220 ns: Flag => writeonce fin
# at time    201220 ns PRE  : Bank = ALL
# At time    201270 ns: Trig => writeonce
# At time    201300 ns: Command => BankActive
# at time    201320 ns ACT  : Bank = 0 Row =    0
# At time    201340 ns: Command => sdram_write
# At time    201350 ns: write =>    16
# at time    201360 ns WRITE: Bank = 0 Row =    0, Col =  16, Data =    16, Dqm = 0000
# At time    201370 ns: write =>    17
# at time    201380 ns WRITE: Bank = 0 Row =    0, Col =  17, Data =    17, Dqm = 0000
# At time    201390 ns: write =>    18
# at time    201400 ns WRITE: Bank = 0 Row =    0, Col =  18, Data =    18, Dqm = 0000
# At time    201410 ns: write =>    19
# At time    201420 ns: Command => PrechargeAllBanks
# at time    201420 ns WRITE: Bank = 0 Row =    0, Col =  19, Data =    19, Dqm = 0000
# At time    201440 ns: Flag => writeonce fin
# at time    201440 ns PRE  : Bank = ALL
# At time    201490 ns: Trig => writeonce
# At time    201520 ns: Command => BankActive
# at time    201540 ns ACT  : Bank = 0 Row =    0
# At time    201560 ns: Command => sdram_write
# At time    201570 ns: write =>    20
# at time    201580 ns WRITE: Bank = 0 Row =    0, Col =  20, Data =    20, Dqm = 0000
# At time    201590 ns: write =>    21
# at time    201600 ns WRITE: Bank = 0 Row =    0, Col =  21, Data =    21, Dqm = 0000
# At time    201610 ns: write =>    22
# at time    201620 ns WRITE: Bank = 0 Row =    0, Col =  22, Data =    22, Dqm = 0000
# At time    201630 ns: write =>    23
# At time    201640 ns: Command => PrechargeAllBanks
# at time    201640 ns WRITE: Bank = 0 Row =    0, Col =  23, Data =    23, Dqm = 0000
# At time    201660 ns: Flag => writeonce fin
# at time    201660 ns PRE  : Bank = ALL
# At time    201710 ns: Trig => writeonce
# At time    201740 ns: Command => BankActive
# at time    201760 ns ACT  : Bank = 0 Row =    0
# At time    201780 ns: Command => sdram_write
# At time    201790 ns: write =>    24
# at time    201800 ns WRITE: Bank = 0 Row =    0, Col =  24, Data =    24, Dqm = 0000
# At time    201810 ns: write =>    25
# at time    201820 ns WRITE: Bank = 0 Row =    0, Col =  25, Data =    25, Dqm = 0000
# At time    201830 ns: write =>    26
# at time    201840 ns WRITE: Bank = 0 Row =    0, Col =  26, Data =    26, Dqm = 0000
# At time    201850 ns: write =>    27
# At time    201860 ns: Command => PrechargeAllBanks
# at time    201860 ns WRITE: Bank = 0 Row =    0, Col =  27, Data =    27, Dqm = 0000
# At time    201880 ns: Flag => writeonce fin
# at time    201880 ns PRE  : Bank = ALL
# At time    201930 ns: Trig => writeonce
# At time    201960 ns: Command => BankActive
# at time    201980 ns ACT  : Bank = 0 Row =    0
# At time    202000 ns: Command => sdram_write
# At time    202010 ns: write =>    28
# at time    202020 ns WRITE: Bank = 0 Row =    0, Col =  28, Data =    28, Dqm = 0000
# At time    202030 ns: write =>    29
# at time    202040 ns WRITE: Bank = 0 Row =    0, Col =  29, Data =    29, Dqm = 0000
# At time    202050 ns: write =>    30
# at time    202060 ns WRITE: Bank = 0 Row =    0, Col =  30, Data =    30, Dqm = 0000
# At time    202070 ns: write =>    31
# At time    202080 ns: Command => PrechargeAllBanks
# at time    202080 ns WRITE: Bank = 0 Row =    0, Col =  31, Data =    31, Dqm = 0000
# At time    202100 ns: Flag => writeonce fin
# at time    202100 ns PRE  : Bank = ALL
# At time    202150 ns: Trig => writeonce
# At time    202180 ns: Command => BankActive
# at time    202200 ns ACT  : Bank = 0 Row =    0
# At time    202220 ns: Command => sdram_write
# At time    202230 ns: write =>    32
# at time    202240 ns WRITE: Bank = 0 Row =    0, Col =  32, Data =    32, Dqm = 0000
# At time    202250 ns: write =>    33
# at time    202260 ns WRITE: Bank = 0 Row =    0, Col =  33, Data =    33, Dqm = 0000
# At time    202270 ns: write =>    34
# at time    202280 ns WRITE: Bank = 0 Row =    0, Col =  34, Data =    34, Dqm = 0000
# At time    202290 ns: write =>    35
# At time    202300 ns: Command => PrechargeAllBanks
# at time    202300 ns WRITE: Bank = 0 Row =    0, Col =  35, Data =    35, Dqm = 0000
# At time    202320 ns: Flag => writeonce fin
# at time    202320 ns PRE  : Bank = ALL
# At time    202370 ns: Trig => writeonce
# At time    202400 ns: Command => BankActive
# at time    202420 ns ACT  : Bank = 0 Row =    0
# At time    202440 ns: Command => sdram_write
# At time    202450 ns: write =>    36
# at time    202460 ns WRITE: Bank = 0 Row =    0, Col =  36, Data =    36, Dqm = 0000
# At time    202470 ns: write =>    37
# at time    202480 ns WRITE: Bank = 0 Row =    0, Col =  37, Data =    37, Dqm = 0000
# At time    202490 ns: write =>    38
# at time    202500 ns WRITE: Bank = 0 Row =    0, Col =  38, Data =    38, Dqm = 0000
# At time    202510 ns: write =>    39
# At time    202520 ns: Command => PrechargeAllBanks
# at time    202520 ns WRITE: Bank = 0 Row =    0, Col =  39, Data =    39, Dqm = 0000
# At time    202540 ns: Flag => writeonce fin
# at time    202540 ns PRE  : Bank = ALL
# At time    202590 ns: Trig => writeonce
# At time    202620 ns: Command => BankActive
# at time    202640 ns ACT  : Bank = 0 Row =    0
# At time    202660 ns: Command => sdram_write
# At time    202670 ns: write =>    40
# at time    202680 ns WRITE: Bank = 0 Row =    0, Col =  40, Data =    40, Dqm = 0000
# At time    202690 ns: write =>    41
# at time    202700 ns WRITE: Bank = 0 Row =    0, Col =  41, Data =    41, Dqm = 0000
# At time    202710 ns: write =>    42
# at time    202720 ns WRITE: Bank = 0 Row =    0, Col =  42, Data =    42, Dqm = 0000
# At time    202730 ns: write =>    43
# At time    202740 ns: Command => PrechargeAllBanks
# at time    202740 ns WRITE: Bank = 0 Row =    0, Col =  43, Data =    43, Dqm = 0000
# At time    202760 ns: Flag => writeonce fin
# at time    202760 ns PRE  : Bank = ALL
# At time    202810 ns: Trig => writeonce
# At time    202840 ns: Command => BankActive
# at time    202860 ns ACT  : Bank = 0 Row =    0
# At time    202880 ns: Command => sdram_write
# At time    202890 ns: write =>    44
# at time    202900 ns WRITE: Bank = 0 Row =    0, Col =  44, Data =    44, Dqm = 0000
# At time    202910 ns: write =>    45
# at time    202920 ns WRITE: Bank = 0 Row =    0, Col =  45, Data =    45, Dqm = 0000
# At time    202930 ns: write =>    46
# at time    202940 ns WRITE: Bank = 0 Row =    0, Col =  46, Data =    46, Dqm = 0000
# At time    202950 ns: write =>    47
# At time    202960 ns: Command => PrechargeAllBanks
# at time    202960 ns WRITE: Bank = 0 Row =    0, Col =  47, Data =    47, Dqm = 0000
# At time    202980 ns: Flag => writeonce fin
# at time    202980 ns PRE  : Bank = ALL
# At time    220010 ns: Trig => readonce
# At time    220040 ns: Command => BankActive
# at time    220060 ns ACT  : Bank = 0 Row =    0
# At time    220080 ns: Command => Read
# at time    220127 ns READ : Bank = 0 Row =    0, Col =   0, Data =     0, Dqm = 0000
# At time    220130 ns: read =>     0
# at time    220147 ns READ : Bank = 0 Row =    0, Col =   1, Data =     1, Dqm = 0000
# At time    220150 ns: read =>     1
# At time    220160 ns: Command => PrechargeAllBanks
# at time    220167 ns READ : Bank = 0 Row =    0, Col =   2, Data =     2, Dqm = 0000
# At time    220170 ns: read =>     2
# At time    220180 ns: Flag => readonce fin
# at time    220180 ns PRE  : Bank = ALL
# at time    220187 ns READ : Bank = 0 Row =    0, Col =   3, Data =     3, Dqm = 0000
# At time    220190 ns: read =>     3
# At time    220210 ns: Trig => readonce
# At time    220240 ns: Command => BankActive
# at time    220260 ns ACT  : Bank = 0 Row =    0
# At time    220280 ns: Command => Read
# at time    220327 ns READ : Bank = 0 Row =    0, Col =   0, Data =     0, Dqm = 0000
# At time    220330 ns: read =>     0
# at time    220347 ns READ : Bank = 0 Row =    0, Col =   1, Data =     1, Dqm = 0000
# At time    220350 ns: read =>     1
# At time    220360 ns: Command => PrechargeAllBanks
# at time    220367 ns READ : Bank = 0 Row =    0, Col =   2, Data =     2, Dqm = 0000
# At time    220370 ns: read =>     2
# At time    220380 ns: Flag => readonce fin
# at time    220380 ns PRE  : Bank = ALL
# at time    220387 ns READ : Bank = 0 Row =    0, Col =   3, Data =     3, Dqm = 0000
# At time    220390 ns: read =>     3
# At time    220410 ns: Trig => readonce
# At time    220440 ns: Command => BankActive
# at time    220460 ns ACT  : Bank = 0 Row =    0
# At time    220480 ns: Command => Read
# at time    220527 ns READ : Bank = 0 Row =    0, Col =   4, Data =     4, Dqm = 0000
# At time    220530 ns: read =>     4
# at time    220547 ns READ : Bank = 0 Row =    0, Col =   5, Data =     5, Dqm = 0000
# At time    220550 ns: read =>     5
# At time    220560 ns: Command => PrechargeAllBanks
# at time    220567 ns READ : Bank = 0 Row =    0, Col =   6, Data =     6, Dqm = 0000
# At time    220570 ns: read =>     6
# At time    220580 ns: Flag => readonce fin
# at time    220580 ns PRE  : Bank = ALL
# at time    220587 ns READ : Bank = 0 Row =    0, Col =   7, Data =     7, Dqm = 0000
# At time    220590 ns: read =>     7
# At time    220610 ns: Trig => readonce
# At time    220640 ns: Command => BankActive
# at time    220660 ns ACT  : Bank = 0 Row =    0
# At time    220680 ns: Command => Read
# at time    220727 ns READ : Bank = 0 Row =    0, Col =   8, Data =     8, Dqm = 0000
# At time    220730 ns: read =>     8
# at time    220747 ns READ : Bank = 0 Row =    0, Col =   9, Data =     9, Dqm = 0000
# At time    220750 ns: read =>     9
# At time    220760 ns: Command => PrechargeAllBanks
# at time    220767 ns READ : Bank = 0 Row =    0, Col =  10, Data =    10, Dqm = 0000
# At time    220770 ns: read =>    10
# At time    220780 ns: Flag => readonce fin
# at time    220780 ns PRE  : Bank = ALL
# at time    220787 ns READ : Bank = 0 Row =    0, Col =  11, Data =    11, Dqm = 0000
# At time    220790 ns: read =>    11
# At time    220810 ns: Trig => readonce
# At time    220840 ns: Command => BankActive
# at time    220860 ns ACT  : Bank = 0 Row =    0
# At time    220880 ns: Command => Read
# at time    220927 ns READ : Bank = 0 Row =    0, Col =  12, Data =    12, Dqm = 0000
# At time    220930 ns: read =>    12
# at time    220947 ns READ : Bank = 0 Row =    0, Col =  13, Data =    13, Dqm = 0000
# At time    220950 ns: read =>    13
# At time    220960 ns: Command => PrechargeAllBanks
# at time    220967 ns READ : Bank = 0 Row =    0, Col =  14, Data =    14, Dqm = 0000
# At time    220970 ns: read =>    14
# At time    220980 ns: Flag => readonce fin
# at time    220980 ns PRE  : Bank = ALL
# at time    220987 ns READ : Bank = 0 Row =    0, Col =  15, Data =    15, Dqm = 0000
# At time    220990 ns: read =>    15
# At time    221010 ns: Trig => readonce
# At time    221040 ns: Command => BankActive
# at time    221060 ns ACT  : Bank = 0 Row =    0
# At time    221080 ns: Command => Read
# at time    221127 ns READ : Bank = 0 Row =    0, Col =  16, Data =    16, Dqm = 0000
# At time    221130 ns: read =>    16
# at time    221147 ns READ : Bank = 0 Row =    0, Col =  17, Data =    17, Dqm = 0000
# At time    221150 ns: read =>    17
# At time    221160 ns: Command => PrechargeAllBanks
# at time    221167 ns READ : Bank = 0 Row =    0, Col =  18, Data =    18, Dqm = 0000
# At time    221170 ns: read =>    18
# At time    221180 ns: Flag => readonce fin
# at time    221180 ns PRE  : Bank = ALL
# at time    221187 ns READ : Bank = 0 Row =    0, Col =  19, Data =    19, Dqm = 0000
# At time    221190 ns: read =>    19
# At time    221210 ns: Trig => readonce
# At time    221240 ns: Command => BankActive
# at time    221260 ns ACT  : Bank = 0 Row =    0
# At time    221280 ns: Command => Read
# at time    221327 ns READ : Bank = 0 Row =    0, Col =  20, Data =    20, Dqm = 0000
# At time    221330 ns: read =>    20
# at time    221347 ns READ : Bank = 0 Row =    0, Col =  21, Data =    21, Dqm = 0000
# At time    221350 ns: read =>    21
# At time    221360 ns: Command => PrechargeAllBanks
# at time    221367 ns READ : Bank = 0 Row =    0, Col =  22, Data =    22, Dqm = 0000
# At time    221370 ns: read =>    22
# At time    221380 ns: Flag => readonce fin
# at time    221380 ns PRE  : Bank = ALL
# at time    221387 ns READ : Bank = 0 Row =    0, Col =  23, Data =    23, Dqm = 0000
# At time    221390 ns: read =>    23
# At time    221410 ns: Trig => readonce
# At time    221440 ns: Command => BankActive
# at time    221460 ns ACT  : Bank = 0 Row =    0
# At time    221480 ns: Command => Read
# at time    221527 ns READ : Bank = 0 Row =    0, Col =  24, Data =    24, Dqm = 0000
# At time    221530 ns: read =>    24
# at time    221547 ns READ : Bank = 0 Row =    0, Col =  25, Data =    25, Dqm = 0000
# At time    221550 ns: read =>    25
# At time    221560 ns: Command => PrechargeAllBanks
# at time    221567 ns READ : Bank = 0 Row =    0, Col =  26, Data =    26, Dqm = 0000
# At time    221570 ns: read =>    26
# At time    221580 ns: Flag => readonce fin
# at time    221580 ns PRE  : Bank = ALL
# at time    221587 ns READ : Bank = 0 Row =    0, Col =  27, Data =    27, Dqm = 0000
# At time    221590 ns: read =>    27
# At time    221610 ns: Trig => readonce
# At time    221640 ns: Command => BankActive
# at time    221660 ns ACT  : Bank = 0 Row =    0
# At time    221680 ns: Command => Read
# at time    221727 ns READ : Bank = 0 Row =    0, Col =  28, Data =    28, Dqm = 0000
# At time    221730 ns: read =>    28
# at time    221747 ns READ : Bank = 0 Row =    0, Col =  29, Data =    29, Dqm = 0000
# At time    221750 ns: read =>    29
# At time    221760 ns: Command => PrechargeAllBanks
# at time    221767 ns READ : Bank = 0 Row =    0, Col =  30, Data =    30, Dqm = 0000
# At time    221770 ns: read =>    30
# At time    221780 ns: Flag => readonce fin
# at time    221780 ns PRE  : Bank = ALL
# at time    221787 ns READ : Bank = 0 Row =    0, Col =  31, Data =    31, Dqm = 0000
# At time    221790 ns: read =>    31
# At time    221810 ns: Trig => readonce
# At time    221840 ns: Command => BankActive
# at time    221860 ns ACT  : Bank = 0 Row =    0
# At time    221880 ns: Command => Read
# at time    221927 ns READ : Bank = 0 Row =    0, Col =  32, Data =    32, Dqm = 0000
# At time    221930 ns: read =>    32
# at time    221947 ns READ : Bank = 0 Row =    0, Col =  33, Data =    33, Dqm = 0000
# At time    221950 ns: read =>    33
# At time    221960 ns: Command => PrechargeAllBanks
# at time    221967 ns READ : Bank = 0 Row =    0, Col =  34, Data =    34, Dqm = 0000
# At time    221970 ns: read =>    34
# At time    221980 ns: Flag => readonce fin
# at time    221980 ns PRE  : Bank = ALL
# at time    221987 ns READ : Bank = 0 Row =    0, Col =  35, Data =    35, Dqm = 0000
# At time    221990 ns: read =>    35


```
