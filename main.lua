--[[ main.lua - will use this to create a page for my start tab ]]--

webreq = require "requests"
jdec = require "cjson"

--[[ get disk space from computers ]]--

function getDisks()
  local zlist = io.popen("zfs list","r")
  for line in zlist:read() do
    print(line)
  end
end


--[[ get task warrior stuff ]]--

function tasknow()
  local taskcmd = io.popen("task overdue","r")
  for line in taskcmd:read() do
    print(line)
  end
end

--[[ reddit top 

function rtop()
end

top x stories from rss 

function rfeeds()
end
 yeah do this later]]--

--[[ rando xkcd ]]--

function xk()
  local xkresp = webreq.get('http://xkcd.com/info.0.json')
  local xkjsn = xkresp.text
  local xktbl = jdec.decode(xkjsn)
  local xkimg = xktbl["img"]
  return xkimg
end

--[[ neat words 

function hagrd()
end
 
 later ]]--

--[[ make it a web page ]]--

function txt2h()
end

--[[ serve it ]]--

function websrv()
end


