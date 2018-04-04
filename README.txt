Mips CPU project for CS385 Markov

Authors: Tyler MacNeil & Eric Smith

This is the various implementation of the MIPS CPU in Verilog HDL.



To run files:

Install verilog hdl from (bleyer.org/icarus/)
	-Install the latest version

Once intalled open command prompt to test if the command (iverilog) works.
	-If it does not follow tutorial on (https://www.swarthmore.edu/NatSci/mzucker1/e15_f2014/iverilog.html)
		-Open system properties control panel, edit environment variables for your account, click new under user variables, enter variable name as PATH, and variable value as %PATH%;c:\iverilog\bin
	-Now test and you should get a no source files response to typing in iverilog

Change directory to where file is stored

Run command iverilog -o (file name).vvp (file name).v

Run command vvp (file name).vvp

NOTES: This should generate the output of the specific file tested.