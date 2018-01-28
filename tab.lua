--[[ main.lua - will use this to create a page for my start tab ]]--

webreq = require "requests"
jdec = require "cjson"

--[[ get disk space from computers ]]--

function getZDisks()
  local disktbl = {}	
  local zlist = io.popen("zfs list","r")
  for line in zlist:lines() do
    disktbl.insert(line)  
  end
  return disktbl
end


--[[ get task warrior stuff ]]--

--[[ a splitter upper function first]]--
function tasksplt(tasktblLn)
local wordtbl = {}
for word in tasktblLn:gmatch("%w+") do
  table.insert(wordtbl, word)
end
--[[
proj = wordtbl[1]
due = wordtbl[#wordtbl]
desc = table.concat(wordtbl, " ", 2, (#wordtbl -1))

]]--
return wordtbl
end

function taskodue()
  tasktbl = {}
  local taskcmd = io.popen("task oduemeta","r")
  for line in taskcmd:lines() do
    if #line > 0 then  
      table.insert(tasktbl, tasksplt(line))
    end
  end
  -- remove the first two entries to the task table
  table.remove(tasktbl, 1)
  table.remove(tasktbl, 1)
  -- probably a better way to do that
  return tasktbl
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
    <br>
    <br>
    <h2> ToDo Stuff </h2>
    <br>
    <br>
    	<table>
	    <tr>
	       <th>Project</th>
	       <th>Due</th>
	       <th>Description</th>
	    </tr>
   	   	{{ for i, tsk in ipairs(tsktbl) do }}
		<tr>  
		      <td> {{= tsk[1]}} </td>
		      <td> {{= tsk[#tsk]}} </td>
		      <td> {{= table.concat(tsk, " ", 2, (#tsk - 1))}} </td>
		</tr>   
		{{end}}
	</table>
  </body>
  </html>
  ]]

  local values = {
  		xkcdi = xk(),
		tsktbl = taskodue() 
	}

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
