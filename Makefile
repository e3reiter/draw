CC = g++
NVCC = nvcc
INCLUDE = -I$(HOME)/include
CFLAGS = -Wall -lm -O3 
NVCCFLAGS = --compiler-options -Wall -arch=sm_20 -O3 -D_FORCE_INLINES
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
