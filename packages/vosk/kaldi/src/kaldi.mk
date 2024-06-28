# This file was generated using the following command:
# configure --openblas-root=../tools/extras/OpenBLAS/install --fst-root=../tools/fst_out --static --fst-version=1.8.0

CONFIGURE_VERSION := 14

# Toolchain configuration

CXX = g++
AR = ar
AS = as
RANLIB = ranlib

# Target achitecture
ARCH = x86_64

# Base configuration

DEBUG_LEVEL = 1
DOUBLE_PRECISION = 0
OPENFSTINC = /root/tii/test_repo_vosk/packages/vosk/kaldi/tools/fst_out/include
OPENFSTLIBS = /root/tii/test_repo_vosk/packages/vosk/kaldi/tools/fst_out/lib/libfst.a
OPENFSTLDFLAGS = 

CUBROOT = /root/tii/test_repo_vosk/packages/vosk/kaldi/tools/cub-1.8.0
WITH_CUDADECODER = true

OPENBLASINC = /root/tii/test_repo_vosk/packages/vosk/kaldi/tools/extras/OpenBLAS/install/include
OPENBLASLIBS = -L/root/tii/test_repo_vosk/packages/vosk/kaldi/tools/extras/OpenBLAS/install/lib -l:libopenblas.a -lgfortran

# OpenBLAS specific Linux configuration

ifndef DEBUG_LEVEL
$(error DEBUG_LEVEL not defined.)
endif
ifndef DOUBLE_PRECISION
$(error DOUBLE_PRECISION not defined.)
endif
ifndef OPENFSTINC
$(error OPENFSTINC not defined.)
endif
ifndef OPENFSTLIBS
$(error OPENFSTLIBS not defined.)
endif
ifndef OPENBLASINC
$(error OPENBLASINC not defined.)
endif
ifndef OPENBLASLIBS
$(error OPENBLASLIBS not defined.)
endif

CXXFLAGS = -std=c++17 -I.. -isystem $(OPENFSTINC) -O1 $(EXTRA_CXXFLAGS) \
           -Wall -Wno-sign-compare -Wno-unused-local-typedefs \
           -Wno-deprecated-declarations -Winit-self \
           -DKALDI_DOUBLEPRECISION=$(DOUBLE_PRECISION) \
           -DHAVE_EXECINFO_H=1 -DHAVE_CXXABI_H -DHAVE_OPENBLAS -I$(OPENBLASINC) \
           -pthread \
           -g

ifeq ($(KALDI_FLAVOR), dynamic)
CXXFLAGS += -fPIC
endif

ifeq ($(DEBUG_LEVEL), 0)
CXXFLAGS += -DNDEBUG
endif
ifeq ($(DEBUG_LEVEL), 2)
CXXFLAGS += -O0 -DKALDI_PARANOID
endif

# Compiler specific flags
COMPILER = $(shell $(CXX) -v 2>&1)
ifeq ($(findstring clang,$(COMPILER)),clang)
# Suppress annoying clang warnings that are perfectly valid per spec.
CXXFLAGS += -Wno-mismatched-tags
endif

LDFLAGS = $(EXTRA_LDFLAGS) $(OPENFSTLDFLAGS) -rdynamic
LDLIBS = $(EXTRA_LDLIBS) $(OPENFSTLIBS) $(OPENBLASLIBS) -lm -lpthread -ldl

# Environment configuration

CXXFLAGS += -DKALDI_NO_EXPF
