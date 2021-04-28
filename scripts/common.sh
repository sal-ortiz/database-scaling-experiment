#!/usr/bin/env bash

function elapsed_to_milliseconds() {
  ELAPSED=$1

  MINS=$( echo -n $ELAPSED | sed -E 's/[^0-9].+//g' | (cat && echo " * 60000") | bc )
  SECS=$( echo -n $ELAPSED | sed -E 's/[^0-9\.]+//g' | (cat && echo " * 1000") | bc )

  MINS=$( echo -n $MINS | sed -E 's/\..*$//g' )
  SECS=$( echo -n $SECS | sed -E 's/\..*$//g' )

  echo -n $(( $MINS + $SECS ))
}

function run_benchmark() {
  SCRIPT=$1
  NUM_RECORDS=$2

  RAW=$( { time $SCRIPT $NUM_RECORDS; } 2>&1 )
  OUTP=$( echo -n $RAW | tr -s ' ' | cut -d ' ' -f 3 )

  echo -n $( elapsed_to_milliseconds $OUTP )
}

