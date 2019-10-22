FROM jupyter/datascience-notebook

USER root

RUN apt-get update && \
    	apt-get install -y --no-install-recommends jq && \
   	rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install -c conda-forge -y \
		gspread \
		oauth2client \
		pyopenssl \
		jupyter_contrib_nbextensions \
		jupyter_nbextensions_configurator \
		autopep8 \
		nbdime \
		jupyterlab-git && \
	conda install -c r -y \
		r-hmisc \
		r-psych \
		r-ROCR \
		r-xtable \
		r-stargazer && \
	conda install -y conda-build && \
	conda skeleton cran gvlma && \
	conda build --R 3.6.1 r-gvlma && \
	conda install -y -c local r-gvlma && \
	conda clean --all -f -y && \
	pip install pymystem3 && \
	jupyter nbextension enable freeze/main && \
	jupyter nbextension enable autosavetime/main && \
	jupyter nbextension enable collapsible_headings/main && \
	jupyter nbextension enable execute_time/ExecuteTime && \
	jupyter nbextension enable datestamper/main && \
	jupyter nbextension enable hide_input_all/main && \
	jupyter nbextension enable varInspector/main && \
	jupyter nbextension enable code_prettify/autopep8 && \
	jupyter nbextension enable toc2/main && \
	jq -c '.autosavetime_set_starting_interval = true' /home/jovyan/.jupyter/nbconfig/notebook.json > tmp.$$.json && \
	mv tmp.$$.json /home/jovyan/.jupyter/nbconfig/notebook.json && \
	nbdime extensions --enable
