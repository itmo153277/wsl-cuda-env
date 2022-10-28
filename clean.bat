@echo off
wsl --unregister alpine
wsl --unregister ubuntu-cuda
rmdir /s/q install
pause
