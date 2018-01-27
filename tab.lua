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
  local xkresp = webreq.get('https://xkcd.com/info.0.json')
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

function doatemplt()
  local liluat = require "liluat"
  local template = [[
  <!DOCTYPE html>
  <head>
    <title>A Start Page</title>
  </head>
  <body>
    <h1> The important Stuff </h1>
    <br>
    <img src = {{= xkcdi}}>
  </body>
  </html>
  ]]

  local values = { xkcdi = xk() }

  local compiled_template = liluat.compile(template)
  local rendered_tmplt = liluat.render(compiled_template, values)
  tab = io.open("tab.html", "w+")
  tab:write(rendered_tmplt)
  io.close(tab)
end

--[[ serve it ]]--

function websrv()
end

doatemplt()
