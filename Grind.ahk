#Requires AutoHotkey v2.0

DetectHiddenWindows false
CoordMode "Mouse", "Screen"
SendMode "Event"
SetWinDelay -1

; Emergency stop hotkey
#MaxThreadsPerHotkey 1
F10::ExitApp

robloxWins := []
svc := ComObjGet("winmgmts:")
for proc in svc.ExecQuery("SELECT Name, ProcessId FROM Win32_Process") {
    lname := StrLower(proc.Name)
    if InStr(lname, "robloxplayerbeta") {
        for hwnd in WinGetList("ahk_pid " proc.ProcessId) {
            WinGetPos &x, &y, &w, &h, hwnd
            if (w > 0 && h > 0)
                robloxWins.Push({hwnd: hwnd, x: x, y: y, w: w, h: h})
        }
    }
}

if (robloxWins.Length = 0)
    ExitApp

Loop {

; ------------------------
; First full cycle
; ------------------------

; First pass: press 1 + center click
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Sleep 50
    Send "1"
    centerX := win.x + (win.w // 2)
    centerY := win.y + (win.h // 2)
    MouseMove(centerX, centerY, 2)
    Sleep 150
    Click "Left"
    Sleep 100
}

Sleep 5000 ; wait before second pass

; Second pass: press 1
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Sleep 50
    Send "1"
    Sleep 500
}

Sleep 1000 ; wait before third pass

; Third pass: Escape → r → Enter twice
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Send "{Escape}"
    Sleep 20
    Send "r"
    Sleep 50
    Send "{Enter}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
}

Sleep 1000 ; wait before final pass

; Final pass: offset click (+110 right, +145 down) + press 1
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    offsetX := win.x + (win.w // 2) + 95
    offsetY := win.y + (win.h // 2) + 125
    MouseMove(offsetX, offsetY, 5)
    Sleep 200
    Click "Left"
    Sleep 100
    Send "1"
    Sleep 200
}

; Movement step: W + D (with space at 0.5s)
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Send "{w down}"
    Sleep 450
    Send "{w up}"
    Sleep 100
    Send "{d down}"
    Sleep 500
    Send "{Space}"
    Sleep 500
    Send "{d up}"
    Sleep 200
}

; Reset: Escape → r → Enter twice
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Send "{Escape}"
    Sleep 20
    Send "r"
    Sleep 50
    Send "{Enter}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
}

; ------------------------
; Second cycle (modified)
; ------------------------

; Final pass again: offset click + press 1
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    offsetX := win.x + (win.w // 2) + 95
    offsetY := win.y + (win.h // 2) + 125
    MouseMove(offsetX, offsetY, 5)
    Sleep 200
    Click "Left"
    Sleep 100
    Send "1"
    Sleep 200
}

; Movement step again: W + D (with space at 0.5s, then press 2 after D finishes)
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Send "{w down}"
    Sleep 450
    Send "{w up}"
    Sleep 100
    Send "{d down}"
    Sleep 500
    Send "{Space}"
    Sleep 500
    Send "{d up}"
    Sleep 100
    Send "2"
    Sleep 200
}

; Reset again: Escape → r → Enter twice
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Send "{Escape}"
    Sleep 20
    Send "r"
    Sleep 50
    Send "{Enter}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
}

; ------------------------
; Final step: wait 1s, then W + A, then mouse offset (center → left 145, down 92), click + delayed 2
; ------------------------

Sleep 1000

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    Send "{w down}"
    Sleep 700
    Send "{w up}"

    Send "{a down}"
    Sleep 300
    Send "{a up}"

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    offsetX := markerX - 145
    offsetY := markerY + 92

    MouseMove(offsetX, offsetY, 5)
    Sleep 100
    Click "Left"
    Sleep 300
    Send "2"
    Sleep 400
}

; ------------------------
; Return click step
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    offsetX := markerX - 190
    offsetY := markerY + 37

    MouseMove(offsetX, offsetY, 5)
    Sleep 100
    Click "Left"
    Sleep 300
    Send "2"
    Sleep 300
}

; ------------------------
; Step A: +50 right, +20 down
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    offsetX := markerX + 50
    offsetY := markerY + 17

    MouseMove(offsetX, offsetY, 5)
    Sleep 300
    Click "Left"
    Sleep 300
}

; ------------------------
; Step B: +40 right from Step A
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    offsetX := markerX + 95
    offsetY := markerY + 17

    MouseMove(offsetX, offsetY, 5)
    Sleep 300
    Click "Left"
    Sleep 300
}

; ------------------------
; Final new step: wait 1s, then go back to first instance, move +13 right and +5 down, click
; ------------------------

Sleep 1000

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    offsetX := markerX + 13
    offsetY := markerY + 5

    MouseMove(offsetX, offsetY, 5)
    Sleep 300
    Click "Left"
    Sleep 300
}

; ------------------------
; Final back step: after last click, move 120 left and 20 up, click (for all)
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    ; Move 120 left and 20 up from the reference point
    offsetX := markerX - 135
    offsetY := markerY - 15

    MouseMove(offsetX, offsetY, 5)
    Sleep 200
    Click "Left"
    Sleep 200
}   ; <-- this closes the final back step loop

; ------------------------
; Reset all instances: Escape → r → Enter twice
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    Send "{Escape}"
    Sleep 20
    Send "r"
    Sleep 50
    Send "{Enter}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
}   ; <-- this closes the reset loop


; ------------------------
; Final center offset step: center → down 60, left 40, click once on all
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    markerX := win.x + (win.w // 2)
    markerY := win.y + (win.h // 2)

    offsetX := markerX - 50
    offsetY := markerY + 110

    MouseMove(offsetX, offsetY, 5)
    Sleep 200
    Click "Left"
    Sleep 200
}

; ------------------------
; Final repeat click: offset (+95 right, +125 down), press 5, then fast circle drag for ~4.5s
; ------------------------

for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)

    ; Step 1: click at offset
    offsetX := win.x + (win.w // 2) + 95
    offsetY := win.y + (win.h // 2) + 125
    MouseMove(offsetX, offsetY, 5)
    Sleep 200
    Click "Left"
    Sleep 100
    Send "5"
    Sleep 200

    ; Step 2: fast circle drag from window center
    centerX := win.x + (win.w // 2)
    centerY := win.y + (win.h // 2)
    radius := 60           ; circle radius in pixels
    steps := 90            ; number of points
    interval := 50         ; ms per step → 90*50 ≈ 4500ms total

    MouseMove(centerX, centerY, 2)
    Sleep 50
    Click "Down"           ; hold left click

    Loop steps {
        angle := (A_Index / steps) * (2 * 3.14159)
        x := centerX + radius * Cos(angle)
        y := centerY + radius * Sin(angle)
        MouseMove(x, y, 0) ; faster movement
        Sleep interval
    }

    Click "Up"             ; release left click
    Sleep 200
}

; Reset: Escape → r → Enter twice
for win in robloxWins {
    WinActivate("ahk_id " win.hwnd)
    WinWaitActive("ahk_id " win.hwnd)
    Send "{Escape}"
    Sleep 20
    Send "r"
    Sleep 50
    Send "{Enter}"
    Sleep 100
    Send "{Enter}"
    Sleep 100
}

Sleep 25000
}


