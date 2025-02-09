CC = g++
NVCC = nvcc
INCLUDE = -I$(HOME)/include
INCLUDE+= -I/home/markus/Dokumente/phd/include # thrust library
CFLAGS = -Wall -lm -O3 
NVCCFLAGS = --compiler-options -Wall -arch=sm_20 -O3
#you might check the libs here, cf your glfw installation
GLFLAGS =$$(pkg-config --static --libs glfw3) #glfw3 installation


all: host_window_t device_window_t

host_window_t: host_window_t.cpp host_window.h
	$(CC) $(CFLAGS) $< -o $@ $(GLFLAGS) 

device_window_t: device_window_t.cu device_window.cuh
	$(NVCC) $(NVCCFLAGS) $< -o $@ $(INCLUDE) $(GLFLAGS) -lGLEW

.PHONY: clean doc

doc: 
	doxygen Doxyfile

clean:
	rm -f *_t 
