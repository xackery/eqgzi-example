@echo off
set last=blender

:: change soldungb to your zone name
set zone=crystal

:: change C:\src\eqgzi\out\convert.py to your eqgzi's path with the file
blender --background %zone%.blend --python C:\src\eqgzi\out\convert.py || goto :error

set last=eqgzi
eqgzi import %zone% || goto :error

set last=azone
cd out 
azone %zone% || goto :error 
cd ..
del out\azone.log
rmdir /s /q map\
mkdir map\
move out\%zone%.map map\

set last=awater
cd out 
awater %zone% || goto :error
cd ..
del out\awater.log
move out\%zone%.wtr map\

set last=copy

:: change c:\src\demoncia\client\rof\ to your eq directory
copy out\* c:\src\demoncia\client\rof\ || goto :error
goto :EOF

:error
echo failed during %last% with signal #%errorlevel%
exit /b %errorlevel%