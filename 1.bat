echo off

set /a "x = 0"
:while1
    if %x% leq 240 (
    	echo %x%
    	more +%x% test.txt | head -1 | xargs t timeline -n=1 -l | awk '{print $1}' | xargs t favorite
        set /a "x = x + 1"
        goto :while1
    )
endlocal