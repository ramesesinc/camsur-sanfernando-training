#!/bin/sh
# set the java home if neccessary
# JAVA_HOME=/mnt/c/Users/ramesesinc/Apps/jdk7u80-x64

# set java options
JAVA_OPTS="-Xmx1024m -Dfontsize=12 -Duser.timezone=Asia/Manila"

# run java
if [ "x$JAVA_HOME" = "x" ]; then
   JAVA="java"
else
   JAVA="$JAVA_HOME/bin/java"
fi

echo ""
echo "========================================================================"
echo ""
echo "  Platform    : Osiris3 Client Platform "
echo "  Application : ETRACS Version 2.5 "
echo ""
echo "  JAVA_HOME   : $JAVA_HOME "
echo "  JAVA_OPTS   : $JAVA_OPTS "
echo "  JAVA        : $JAVA "
echo ""
echo "========================================================================"
echo ""

$JAVA $JAVA_OPTS -classpath lib/*:. com.rameses.osiris3.platform.OSBootStrap
