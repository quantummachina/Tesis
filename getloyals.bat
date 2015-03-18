echo off

set /a "x = 0"
:while1
    if %x% leq 553 (
    	echo %x%
    	more +%x% rodrigotellomF.txt | head -1 | xargs t favorites -n=30 >> temp.txt

    	::evaluate
    	findstr "@rodrigotellom" temp.txt && (
    		more +%x% rodrigotellomF.txt | head -1 >> rodrigotellomL.txt
    	)
    	del temp.txt
        set /a "x = x + 1"
        goto :while1
    )
endlocal