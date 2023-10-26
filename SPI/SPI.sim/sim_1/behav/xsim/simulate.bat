@echo off
REM ****************************************************************************
REM Vivado (TM) v2023.1.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Thu Oct 12 14:29:13 -0600 2023
REM SW Build 3900603 on Fri Jun 16 19:31:24 MDT 2023
REM
REM IP Build 3900379 on Sat Jun 17 05:28:05 MDT 2023
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim SPI_Master_TB_behav -key {Behavioral:sim_1:Functional:SPI_Master_TB} -tclbatch SPI_Master_TB.tcl -log simulate.log"
call xsim  SPI_Master_TB_behav -key {Behavioral:sim_1:Functional:SPI_Master_TB} -tclbatch SPI_Master_TB.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
