if executable("xmllint")
    au FileType xml setlocal equalprg="xmllint --format --recover -"
endif
