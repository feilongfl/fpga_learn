#!/bin/sh

# 
# PlanAhead(TM)
# runme.sh: a PlanAhead-generated Runs Script for UNIX
# Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=D:/Xilinx/ISE/14.7/ISE_DS/EDK/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/EDK/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/lib/nt:D:/Xilinx/ISE/14.7/ISE_DS/PlanAhead/bin
else
  PATH=D:/Xilinx/ISE/14.7/ISE_DS/EDK/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/EDK/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/lib/nt:D:/Xilinx/ISE/14.7/ISE_DS/PlanAhead/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD=`dirname "$0"`
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep ngdbuild -intstyle ise -p xc6slx16csg324-2 -dd _ngo -uc "led.ucf" "led.edf"
EAStep map -intstyle pa -w -r 4 -ol high "led.ngd"
EAStep par -intstyle pa "led.ncd" -w "led_routed.ncd" -ol high
EAStep trce -intstyle ise -o "led.twr" -v 3 -l 30 -nodatasheet -fastpaths "led_routed.ncd" "led.pcf"
EAStep xdl -secure -ncd2xdl -nopips "led_routed.ncd" "led_routed.xdl"
