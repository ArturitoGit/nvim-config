autocmd BufEnter {.classpath,.project} set filetype=xml
autocmd BufEnter {all.yaml,all.yml,hosts.yaml,hosts.yml,default.yaml,default.yml} set filetype=ansible
autocmd BufEnter Jenkinsfile set filetype=groovy
autocmd BufEnter Jenkinsfile.* set filetype=groovy
autocmd BufEnter Dockerfile.* set filetype=dockerfile
autocmd BufEnter *.conf set filetype=apache
