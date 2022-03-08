-- Source: https://www.cnblogs.com/MiraculousB/p/15260583.html

-------------------------------自定义配置区域--------------------------------

Offset = 4
--[[
    offset 对应抖动的幅度，必须为整数。可以根据自己的灵敏度调整，太小的话没有减少后坐力的效果
    也可设置为一定范围内随机，例如：offset = math.random(3, 5)，设置为0时候无抖动效果
--]]
Offset_random = 0 --随机偏移量，必须为整数。为0则不随机
Btn_main_switch = 5 --鼠标的抖动开关

Btn_recoil_switch = 4 --鼠标的下压开关

-- 这两个按键可以自行调整，默认的5和4对应的是我 G Pro Hero 上的前后两个侧键,设置为一样可以同时开启两个开关

---------------------------------程序区域------------------------------------

EnablePrimaryMouseButtonEvents(true)
Is_ads = 0
Enabled = 0
Recoil = 0
Jitter_max = Offset + Offset_random
Jitter_min = Offset - Offset_random


function OnEvent(event, arg)
    ClearLog()
    --OutputLogMessage("Event: " .. event .. " Arg: " .. arg .. "\n")
    OutputLogMessage("Current settings:\n\nJitter = %d\nRecoil = %d\n", Enabled, Recoil)
    local recovery_offset
    local downcount
    local jitter
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1 and Is_ads == 1 and Enabled == 1) then
        downcount = 0
        repeat
            downcount = downcount + 1
            if (downcount <= 150 and Recoil == 1) then
                MoveMouseRelative(0, 1)
            end
            jitter = math.random(Jitter_min, Jitter_max)
            recovery_offset = -jitter
            Sleep(2)
            MoveMouseRelative(jitter, jitter)
            Sleep(2)
            MoveMouseRelative(recovery_offset, recovery_offset)
        until not IsMouseButtonPressed(1)
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == Btn_main_switch) then
        if (Enabled == 0) then
            Enabled = 1
        else
            Enabled = 0
        end
    end
    if (event == "MOUSE_BUTTON_PRESSED" and arg == Btn_recoil_switch) then
        if (Recoil == 0) then
            Recoil = 1
        else
            Recoil = 0
        end
    end
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 2) then
        Is_ads = 1
    end

    if (event == "MOUSE_BUTTON_RELEASED" and arg == 2) then
        Is_ads = 0
    end

end
