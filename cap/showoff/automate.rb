#!/usr/bin/env ruby

require 'xdo/keyboard'

while true
    XDo::Keyboard.simulate("{CMD}{SHIFT}[")
    sleep 10
end
