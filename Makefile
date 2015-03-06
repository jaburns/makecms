IN_POSTS=$(wildcard posts/*)
OUT_POSTS=$(subst posts,public,$(IN_POSTS:=.html))

default: all

all: public public/index.html $(OUT_POSTS)

public:
	mkdir public

public/%.html: posts/%
	./gen_post $^ > $@

post_index.inc: posts/*
	./gen_post_index > post_index.inc

public/index.html: index.template.html post_index.inc
	cpp index.template.html | sed '/^#.*/d' > public/index.html

clean:
	rm -f *.inc

reset:
	rm -f $(OUT_POSTS) *.inc public/index.html
