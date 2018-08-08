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
