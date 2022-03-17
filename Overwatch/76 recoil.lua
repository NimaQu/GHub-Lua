-------------------------------自定义配置区域--------------------------------

Offset = 15
--[[
    offset 对应下压的幅度，必须为整数。可以根据自己的灵敏度调整, 数字越小幅度越大
    这玩意并不是线性的，后面可能有更好方法会重写
--]]
Offset_random = 0 --随机偏移量，必须为整数。为0则不随机, 不得超过 Offset
Delay = 200 --下压的延迟，单位毫秒,因为 76 前面几发几乎没有后坐力

Btn_main_switch = 5 --开关按键

-- 这两个按键可以自行调整，默认的5和4对应的是我 G Pro Hero 上的前面侧键,设置为一样可以同时开启两个开关

---------------------------------程序区域------------------------------------

EnablePrimaryMouseButtonEvents(true)
Enabled = 0
Jitter_max = Offset + Offset_random
Jitter_min = Offset - Offset_random
Max_Fire_time = 3500


function OnEvent(event, arg)
    ClearLog()
    --OutputLogMessage("Event: " .. event .. " Arg: " .. arg .. "\n")
    OutputLogMessage("Current settings:\n\nEnabled = %d\n", Enabled)
    local downcount
    local jitter
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1 and Enabled == 1) then
        Sleep(Delay)
        downcount = 0 + Delay
        repeat
            jitter = math.random(Jitter_min, Jitter_max)
            downcount = downcount + jitter * 1.5
            --执行需要时间，所以必须得乘一个 1.6 作为补偿
            if (downcount <= Max_Fire_time and Enabled == 1) then
                MoveMouseRelative(0, 2)
            end
            Sleep(jitter)
        until not IsMouseButtonPressed(1)
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == Btn_main_switch) then
        if (Enabled == 0) then
            Enabled = 1
        else
            Enabled = 0
        end
    end

end
