#!/bin/sh

APP_MAIN=com.webank.webase.front.Application
tradePortalPID=0
getTradeProtalPID(){
    javaps=`$JAVA_HOME/bin/jps -l | grep $APP_MAIN`
    if [ -n "$javaps" ]; then
        tradePortalPID=`echo $javaps | awk '{print $1}'`
    else
        tradePortalPID=0
    fi
}

stopFront(){
	getTradeProtalPID
	echo "==============================================================================================="
	if [ $tradePortalPID -ne 0 ]; then
	    echo -n "Stopping $APP_MAIN (PID=$tradePortalPID)..."
	    kill -9 $tradePortalPID
	    if [ $? -eq 0 ]; then
	        echo "[Success]"
	        echo "==============================================================================================="
	    else
	        echo "[Failed]"
	        echo "==============================================================================================="
	    fi
	    getTradeProtalPID
	    if [ $tradePortalPID -ne 0 ]; then
	        stopFront
	    fi
	else
	    echo "$APP_MAIN is not running"
	    echo "==============================================================================================="
	fi
}

# stop front
stopFront
# stop report
#cd ./report && sh report_stop.sh