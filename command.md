wget \
     --recursive \
     --level 5 \
     --no-clobber \
     --page-requisites \
     --adjust-extension \
     --span-hosts \
     --convert-links \
     --restrict-file-names=windows \
     --domains linkedin.com \
     --no-parent linkedin.com \
    --load-cookies www.linkedin.com_cookies.txt https://www.linkedin.com/in/gael-varoqaux-960b5b10/

    wget --recursive --level 1 --page-requisites --adjust-extension --span-hosts --convert-links --restrict-file-names=unix --domains linkedin.com --no-parent --load-cookies www.linkedin.com_cookies.txt https://www.linkedin.com/