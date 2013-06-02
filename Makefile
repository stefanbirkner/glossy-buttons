ALPHA = grey25
BOOTSTRAP = ./target/bootstrap
GH_PAGES = ./target/gh-pages
GLOSSY_BOOTSTRAP = ./target/glossy-bootstrap
GLOSS_IMAGE = ./target/gloss.png
HOMEPAGE = ./index.html
PATCH = ./gloss.patch

build: $(GLOSSY_BOOTSTRAP) $(GH_PAGES)
	@echo "Success. The patched Twitter Bootstrap is available at ./target/bootstrap."

$(GLOSSY_BOOTSTRAP) : $(BOOTSTRAP) $(GLOSS_IMAGE) $(PATCH)
	@rm -rf $(GLOSSY_BOOTSTRAP)
	@cp -R  $(BOOTSTRAP) $(GLOSSY_BOOTSTRAP)
	@cp $(GLOSS_IMAGE) $(GLOSSY_BOOTSTRAP)/img/
	@cd $(GLOSSY_BOOTSTRAP);git apply ../../gloss.patch; npm install; make

$(BOOTSTRAP):
	git clone git@github.com:twitter/bootstrap.git $(BOOTSTRAP)

$(GLOSS_IMAGE):
	@echo "Create gloss image."
	@convert -size 100x100 canvas:black -fill ${ALPHA} -draw 'rectangle 0,50 100,100' -alpha copy $(GLOSS_IMAGE)

$(GH_PAGES) : $(GLOSSY_BOOTSTRAP) $(HOMEPAGE)
	rm -rf $(GH_PAGES)
	mkdir -p $(GH_PAGES)/css
	mkdir -p $(GH_PAGES)/img
	cp $(HOMEPAGE) $(GH_PAGES)
	cp $(GLOSSY_BOOTSTRAP)/docs/assets/css/bootstrap.css $(GH_PAGES)/css/
	cp $(GLOSSY_BOOTSTRAP)/docs/assets/css/bootstrap-responsive.css $(GH_PAGES)/css/
	cp $(GLOSSY_BOOTSTRAP)/docs/assets/img/gloss.png $(GH_PAGES)/img/

.PHONY: clean
clean:
	@rm -rf ./target

