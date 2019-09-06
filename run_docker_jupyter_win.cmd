REM
REM Attention: Windows Toolbox users - you MUST put the course repo in C:\Users\%username\mlcourse.ai
REM Attention: Use Ctrl-C to shut down. If you close the window, the container may still be running.
REM 

SET IMAGE="gumlooter/jupyter"
SET PORT="4544"

REM check for new versin of the image
docker pull %IMAGE%

docker run --rm -p %PORT%:8888 -v %cd%:/home/jovyan/work %IMAGE% start-notebook.sh ^
    --notebook-dir=/home/jovyan/work ^
    --NotebookApp.ip=0.0.0.0 ^
    --NotebookApp.password_required=False ^
    --NotebookApp.token='' ^
    --NotebookApp.custom_display_url='http://localhost:%PORT%'
