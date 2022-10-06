-------------------------------自定义配置区域--------------------------------

--[[
    Trigger 是触发按键，参考罗技按键图，长按按键会先按下 E(复活技能按键)，然后以随机的速度蹲起并移动走来让敌人难以寻找你的头部
    按键配置：E 复活，A 向左走，CTRL 蹲下
--]]

Trigger = 5
-- 开关

Duration = 90
-- 持续时间，一般为复活时间，根据需要调整，到达时间后自动停止旋转并视角回正

Rotational_speed = 10000
-- 旋转速度，越大越快

Back_to_center = 1800
-- 视角回正量，根据需要调整

Ctrl_duration_min = 5
-- 从蹲到起的间隔时间最小值

Ctrl_duration_max = 30
-- 从蹲到起的间隔时间最大值

Ctrl_interval = 10
-- 两次蹲起的间隔时间

---------------------------------程序区域------------------------------------

function OnEvent(event, arg)
    local ctrl_count = 0
    local count = 0

    if (event == "MOUSE_BUTTON_PRESSED" and arg == Trigger) then
        PressAndReleaseKey("e")
        MoveMouseRelative(0, 10000)
        Sleep(1)
        repeat
            PressKey("a")
            local ctrl_duration = math.random(Ctrl_duration_min, Ctrl_duration_max)
            MoveMouseRelative(Rotational_speed, 0)
            if ctrl_count == Ctrl_interval then
                PressKey(29)
            end
            if ctrl_count >= Ctrl_interval + ctrl_duration then
                ReleaseKey(29)
                ctrl_count = 0
            end
            ctrl_count = ctrl_count + 1
            count = count + 1
            Sleep(1)
        until not IsMouseButtonPressed(Trigger) or count > Duration
        MoveMouseRelative(0, -Back_to_center)
        ReleaseKey(29)
        ReleaseKey("a")
    end
end