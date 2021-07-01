COMPONENT=DemoAppC
TOSMAKE_PRE_EXE_DEPS +=DemoApp.class
TOSMAKE_CLEAN_EXTRA =*.class DemoAppMsgL.java
TOSMAKE_CLEAN_EXTRA =*.class DemoAppMsgH.java
TOSMAKE_CLEAN_EXTRA =*.class DemoAppMsgT.java

DemoApp.class: $(wildcard *.java) DemoAppMsgL.java
	javac -target 1.4 -source 1.4 *.java

DemoAppMsgL.java:
	nescc-mig java $(CFLAGS) -java-classname=DemoAppMsgL DemoApp.h l_message -o $@

DemoApp.class: $(wildcard *.java) DemoAppMsgH.java
	javac -target 1.4 -source 1.4 *.java

DemoAppMsgH.java:
	nescc-mig java $(CFLAGS) -java-classname=DemoAppMsgH DemoApp.h h_message -o $@

DemoApp.class: $(wildcard *.java) DemoAppMsgT.java
	javac -target 1.4 -source 1.4 *.java

DemoAppMsgT.java:
	nescc-mig java $(CFLAGS) -java-classname=DemoAppMsgT DemoApp.h t_message -o $@

TINYOS_ROOT_DIR?=../..
include $(TINYOS_ROOT_DIR)/Makefile.include
