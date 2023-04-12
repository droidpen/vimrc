if exist cscope.files del cscope.files
rem dir/s/b/a:-d *.c *.cpp *.h *.s *.reg *.bib *.inc *.def make* dirs* sources* *.ini > cscope.files
rem dir/s/b/a:-d *.c *.cpp *.h *.s *.inc *.def make* dirs* sources* > cscope.files
dir/s/b/a:-d *.c *.cpp *.h *.s > cscope.files
cscope -b -k

