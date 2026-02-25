-- Paksa pake wl-copy langsung
function syscopy()
    local text = CurView():Selection()
    if text and text ~= "" then
        os.execute("printf '%s' " .. string.gsub(text, "'", "'\\''") .. " | wl-copy")
    end
end

function syspaste()
    local f = io.popen("wl-paste")
    local text = f:read("*a")
    f:close()
    Paste(text)
end

BindKey("Ctrl-c", "lua:initlua.syscopy")
BindKey("Ctrl-v", "lua:initlua.syspaste")