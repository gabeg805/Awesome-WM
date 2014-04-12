-- 
-- Created By: Gabriel Gonzalez (contact me at gabeg@bu.edu)
-- 
-- 
-- Name:
-- 	
--     gabegWidgets
-- 
-- 
-- Syntax: 
-- 	
--     gabegWidgets = require("gabegWidgets")
-- 
-- 
-- Purpose:
-- 	
--     Insert custom widgets to panel.
-- 
-- 
-- Keywords:
-- 	
--     N/A
-- 
-- 
-- Functions:
-- 	
--     gabegWidgets.setTimer - set the widget refresh timer
-- 
-- 
-- Dependencies:
--
--     awful     - Awesome builtin module
--     beautiful - Awesome builtin module
--     naughty   - Awesome builtin module
--     menubar   - Awesome builtin module
--     
--     panelLayouts    - custom module, sets the wallpaper and returns the Awesome tiling algorithms
--     panelMenu       - custom module, returns Awesome menu launcher
--     panelClock      - custom module, returns text clock (image and text)
--     panelText       - custom module, returns script output in string format and
--                       widget text format
--     panelBattery    - custom module, returns battery widget (image and text)
--     panelWireless   - custom module, returns wifi widget (image and text)
--     panelVolume     - custom module, returns volume widget (image and text)
--     panelTimer      - custom module, refreshes widgets with updated values
--     panelBrightness - custom module, returns brightness widget (image and text)
--     panelMusic      - custom module, returns music widget (image and text)
--
--   
--  File Structure:
--
--     * Edit Package Path
--     * Define Necessary Variables
--     * Import Modules
--     * Compile All The Modules
-- 
-- 
-- Modification History:
-- 	
--     gabeg Mar 08 2014 <> created
--     gabeg Mar 23 2014 <> changed the method of enabling the widget timer
--
-- ************************************************************************




-- *****************
-- EDIT PACKAGE PATH
-- *****************

package.path = package.path .. ';/home/gabeg/.config/awesome/widget-library/?.lua'



-- **************************
-- DEFINE NECESSARY VARIABLES
-- **************************

-- script that prints out current computer info
bat_cmd = "/mnt/Linux/Share/scripts/compInfo-Arch.sh bat"
net_cmd = "/mnt/Linux/Share/scripts/compInfo-Arch.sh net"
vol_cmd = "/mnt/Linux/Share/scripts/compInfo-Arch.sh vol stat"

-- initialize counter to display 10min warning
counter = 0


-- **************
-- IMPORT MODULES
-- **************

local panelLayouts = require("panelLayouts")
local panelMenu = require("panelMenu")
local panelClock = require("panelClock")
local panelText = require("panelText")
local panelBattery = require("panelBattery")
local panelWireless = require("panelWireless")
local panelVolume = require("panelVolume")
local panelBrightness = require("panelBrightness")
local panelMusic = require("panelMusic")
local panelCute = require("panelCute")



-- ***********************
-- COMPILE ALL THE MODULES
-- ***********************

function make_module(name, definer)
   local module = {}
   definer(module)
   package.loaded[name] = module
   return module
end


gabegWidgets = make_module('gabegWidgets',
                           function(gabegWidgets)
                               
                               gabegWidgets.wallpaper = panelLayouts.wallpaper
                               gabegWidgets.layouts = panelLayouts.layouts
                               
                               gabegWidgets.aweMenu = panelMenu.aweMenu
                               gabegWidgets.clock = panelClock.clock
                               
                               gabegWidgets.battery = panelBattery.battery
                               gabegWidgets.wireless = panelWireless.wireless
                               gabegWidgets.volume = panelVolume.volume
                               gabegWidgets.brightness = panelBrightness.brightness
                               gabegWidgets.music = panelMusic.music
                               
                               gabegWidgets.cute = panelCute.cute
                               
                               -- enabling the timer to refresh widgets
                               gabegWidgets.setTimer = function(myBatteryImage, myBatteryTextBox, myWirelessImage, myVolumeImage, secs)
                                   mytimer = timer({ timeout = secs })
                                   mytimer:connect_signal("timeout", 
                                                          function()
                                                              -- refresh panel stats
                                                              panelBattery.warning()
                                                              panelBattery.getIcon(myBatteryImage, bat_cmd)
                                                              panelText.getScript(myBatteryTextBox, bat_cmd, "#333333")
                                                              panelWireless.getIcon(myWirelessImage, net_cmd)
                                                              panelVolume.getIcon(myVolumeImage, vol_cmd)
                                                              
                                                              -- increment/reset counter
                                                              counter = counter + 1
                                                              
                                                              if counter == 10 then
                                                                  naughty.notify( 
                                                                      { 
                                                                          preset = naughty.config.presets.critical,
                                                                          title = "Reminder",
                                                                          text = " 10 min",
                                                                          font = "Inconsolata 14", 
                                                                          position = "bottom_right", 
                                                                          timeout = 10, hover_timeout = 0,
                                                                          width = 90, 
                                                                          height = 60
                                                                      }
                                                                                )
                                                                  
                                                                  counter = 0
                                                              end
                                                              
                                                          end
                                                         )
                                   mytimer:start()
                               end                             
                               
                           end
                           
                          )

