IMAGE=kohanyirobert/crossbuild-i383-linux-gnu:test
C_TARGET=helloworld-c/helloworld-c
CXX_TARGET=helloworld-cxx/helloworld-cxx
EXPECTED_FILE_FORMAT=elf32-i386

all: test

.PHONY: test
test: build
	docker run --rm --volume $(PWD)/test:/test $(IMAGE) bash -c "\
	  mkdir /build && \
	  cd /build && \
	  cmake /test && \
	  make && \
	  objdump -f $(C_TARGET) | grep -q $(EXPECTED_FILE_FORMAT) && \
	  objdump -f $(CXX_TARGET) | grep -q $(EXPECTED_FILE_FORMAT)"

.PHONY: build
build:
	docker build --tag $(IMAGE) .
