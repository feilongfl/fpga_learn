//
// PlanAhead(TM)
// rundef.js: a PlanAhead-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
//

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "D:/Xilinx/ISE/14.7/ISE_DS/EDK/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/EDK/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/PlanAhead/bin;";
} else {
  PathVal = "D:/Xilinx/ISE/14.7/ISE_DS/EDK/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/EDK/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/ISE/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/bin/nt;D:/Xilinx/ISE/14.7/ISE_DS/common/lib/nt;D:/Xilinx/ISE/14.7/ISE_DS/PlanAhead/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "ngdbuild",
         "-intstyle ise -p xc6slx16csg324-2 -dd _ngo -uc \"led.ucf\" \"led.edf\"" );
ISEStep( "map",
         "-intstyle pa -w -r 4 -ol high \"led.ngd\"" );
ISEStep( "par",
         "-intstyle pa \"led.ncd\" -w \"led_routed.ncd\" -ol high" );
ISEStep( "trce",
         "-intstyle ise -o \"led.twr\" -v 3 -l 30 -nodatasheet -fastpaths \"led_routed.ncd\" \"led.pcf\"" );
ISEStep( "xdl",
         "-secure -ncd2xdl -nopips \"led_routed.ncd\" \"led_routed.xdl\"" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
