-- 
-- CREATED BY: Gabriel Gonzalez (contact me at gabeg@bu.edu)
-- 
-- 
-- NAME:
-- 	
--     CommandLine
-- 
-- 
-- SYNTAX: 
-- 	
--     require("CommandLine")
-- 
-- 
-- PURPOSE:
-- 	
--     Returns command output as a string.
-- 
-- 
-- KEYWORDS:
-- 	
--     N/A
-- 
-- 
-- FUNCTIONS:
-- 	
--     doCommand - execute the specified command
-- 
-- 
--  FILE STRUCTURE:
--
--     * Execute Command
-- 
-- 
-- MODIFICATION HISTORY:
-- 	
--     gabeg Mar 13 2014 <> created
--
--     gabeg Jul 28 2014 <> removed functions that were not being used
--
-- **********************************************************************************


-- ---------------------------
-- ----- EXECUTE COMMAND -----
-- ---------------------------

-- Execute the specified command
function doCommand(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    
    if raw then return s end
    
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    -- s = string.gsub(s, '[\n\r]+', ' ')
    
    return s
end
