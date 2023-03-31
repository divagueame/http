#!/bin/bash
ruby ./my_server.rb &
sleep 5
curl -v http://localhost:4321 
