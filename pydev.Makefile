# Copyright (C) 2022  FREIA Laboratory

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


# The following lines are required
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS

# Most modules only need to be built for x86_64
ARCH_FILTER += linux-x86_64

USR_LDFLAGS += -lpthread -ldl -lutil -lm -lpython3.6m -Xlinker -export-dynamic
USR_CXXFLAGS += -I/usr/include/python3.6m -fno-strict-aliasing -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv -DNDEBUG -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv
USR_CXXFLAGS += -std=c++11
LIB_SYS_LIBS += python3.6m

# If your module has dependencies, you will generate want to include them like
#
#     REQUIRED += asyn
#     ifneq ($(strip $(ASYN_DEP_VERSION)),)
#       asyn_VERSION=$(ASYN_DEP_VERSION)
#     endif
#
# with $(ASYN_DEP_VERSION) defined in `configure/CONFIG_MODULE`

# Since this file (pydev.Makefile) is copied into
# the module directory at build-time, these paths have to be relative
# to that path
APP := .
APPDB := $(APP)/Db
APPSRC := $(APP)/src

# If you have files to include, you will generally want to include these, e.g.
#
#     SOURCES += $(APPSRC)/pydevMain.cpp
#     SOURCES += $(APPSRC)/library.c
#     HEADERS += $(APPSRC)/library.h
#     USR_INCLUDES += -I$(where_am_I)$(APPSRC)

SOURCES   += $(APPSRC)/asyncexec.cpp
SOURCES   += $(APPSRC)/epicsdevice.cpp
#SOURCES   += $(APPSRC)/pycalcRecord.cpp
SOURCES   += $(APPSRC)/pydev_ai.cpp
SOURCES   += $(APPSRC)/pydev_ao.cpp
SOURCES   += $(APPSRC)/pydev_bi.cpp
SOURCES   += $(APPSRC)/pydev_bo.cpp
SOURCES   += $(APPSRC)/pydev_longin.cpp
SOURCES   += $(APPSRC)/pydev_longout.cpp
SOURCES   += $(APPSRC)/pydev_lsi.cpp
SOURCES   += $(APPSRC)/pydev_lso.cpp
SOURCES   += $(APPSRC)/pydev_mbbi.cpp
SOURCES   += $(APPSRC)/pydev_mbbo.cpp
SOURCES   += $(APPSRC)/pydev_stringin.cpp
SOURCES   += $(APPSRC)/pydev_stringout.cpp
SOURCES   += $(APPSRC)/pydev_waveform.cpp
SOURCES   += $(APPSRC)/pywrapper.cpp
SOURCES   += $(APPSRC)/util.cpp

#TEMPLATES += $(wildcard $(APPDB)/*.db)
#TEMPLATES += $(wildcard $(APPDB)/*.proto)
#TEMPLATES += $(wildcard $(APPDB)/*.template)

############################################################################
#
# Add any .dbd files that should be included (e.g. from user-defined functions, etc.)
#
############################################################################

DBDS   += $(APPSRC)/pydev.dbd
#DBDS   += $(APPSRC)/pycalcRecord.dbd


############################################################################
#
# Add any header files that should be included in the install (e.g. 
# StreamDevice or asyn header files that are used by other modules)
#
############################################################################

#HEADERS   += 


############################################################################
#
# Add any startup scripts that should be installed in the base directory
#
############################################################################

SCRIPTS += $(wildcard ../iocsh/*.iocsh)

# Same as with any source or header files, you can also use $SUBS and $TMPS to define
# database files to be inflated (using MSI), e.g.
#
#     SUBS = $(wildcard $(APPDB)/*.substitutions)
#     TMPS = $(wildcard $(APPDB)/*.template)

USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(APPDB)

.PHONY: vlibs
vlibs:
