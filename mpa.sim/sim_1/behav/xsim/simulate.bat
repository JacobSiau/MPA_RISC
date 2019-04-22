@echo off
REM ****************************************************************************
REM Vivado (TM) v2017.3 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Mon Apr 22 01:03:32 -0500 2019
REM SW Build 2018833 on Wed Oct  4 19:58:22 MDT 2017
REM
REM Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
call xsim homework5_risc_top_tb_behav -key {Behavioral:sim_1:Functional:homework5_risc_top_tb} -tclbatch homework5_risc_top_tb.tcl -view C:/Users/jacob/Desktop/Vivado/mpa/homework2_function_unit_tb_behav.wcfg -view C:/Users/jacob/Desktop/Vivado/mpa/homework5_risc_top_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
