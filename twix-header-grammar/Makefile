all: compile

compile:
		antlr4 *.g4
	 	javac *.java

debug: compile
	java org.antlr.v4.gui.TestRig XProt header -gui -encoding utf8

check: compile
	./check.sh test/

python: 
	  antlr4 *.g4 -Dlanguage=Python3 -o Python -visitor -no-listener

java:
	 antlr4 *.g4 -o Java -visitor -no-listener
	 javac ./Java/*.java

clean:
	rm -f *.class *.java *.tokens *.interp

cleanall:clean
	rm -rf Java Python