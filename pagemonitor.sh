#!/bin/bash
echo "如果需要cookies，请导出cookies (Netscape Cookies格式)"
echo "Chrome Entension https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid"
read -p "请输入cookies的名字或绝对目录,若没有请输入0 " COOKIESDIR
NOCOOKIES=n
if [ $COOKIESDIR -eq 0 ]
then read -p "请输入想要监控的网页:" PAGE
     read -p "请输入监控频率 几分钟一次" FRE
     wget -P $HOME -O page.old "$PAGE"
     while true
         do 
         sleep $FRE\m
         wget -P $HOME -O page "$PAGE"
         diff page page.old
         if [ $? -eq 1 ]
             then echo "Page has changed!"
                  exit 0
             else rm -f $HOME/page.old
                  mv $HOME/page $HOME/page.old
         fi
     done
else read -p "请输入想要监控的网页:" PAGE
     read -p "请输入监控频率 几分钟一次" FRE
          wget --load-cookies -P $HOME $COOKIESDIR -O page.old "$PAGE"
     while true
         do 
         sleep $FRE\m
         wget --load-cookies -P $HOME $COOKIESDIR -O page "$PAGE"
         diff page page.old
         if [ $? -eq 1 ]
             then echo "Page has changed!"
                  exit 0
             else rm -f $HOME/page.old     
                  mv $HOME/page $HOME/page.old
         fi
     done
fi
rm -f $HOME/page.old && rm -f $HOME/page
