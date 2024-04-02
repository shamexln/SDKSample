ifndef __BOOST_THREAD__
__BOOST_THREAD__=1

include $(REL_VIEW_ROOT)/tools/utils/Make/global/global_$(PLATFORM).mk

# boost presets lib name on some platforms ( e.g. win32 ), see define BOOST_AUTO_LINK_NOMANGLE
BOOST_THREAD_LIB_NAME = $(GLOBAL_LIB_DIR)/$(GLOBAL_LIB_PREFIX)boost_thread.$(GLOBAL_LIB_EXT)

include $(boost_DIR)/make/make_lib_boost_system_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_chrono_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_datetime_$(PLATFORM).mk
include $(boost_DIR)/make/libBoostThread_filelist_$(PLATFORM).incl

BOOST_THREAD_EXCLUDE_FILES = 
BOOST_THREAD_INCLUDE_FILES = 
BOOST_THREAD_SRC_FILES     = $(filter-out $(BOOST_THREAD_EXCLUDE_FILES), $(BOOST_THREAD_SRC)) $(BOOST_THREAD_INCLUDE_FILES)
BOOST_THREAD_OBJ_FILES     = $(subst $(boost_DIR),$(GLOBAL_OUT_DIR)/boost,$(addsuffix .$(GLOBAL_EXTOBJ),$(basename $(BOOST_THREAD_SRC_FILES))))

$(GLOBAL_OUT_DIR)/boost/%.$(GLOBAL_EXTOBJ): $(boost_DIR)/%.cpp
	$(GLOBAL_CXXCOMPILE)
ifndef NO_DEP_INCLUDE
-include $(BOOST_THREAD_OBJ_FILES:.$(GLOBAL_EXTOBJ)=.dep)
endif

# Extra Compiler settings
$(BOOST_THREAD_OBJ_FILES) : EXTRA_CXXDEFINES = -I$(boost_DIR)
$(BOOST_THREAD_OBJ_FILES) : EXTRA_CCDEFINES  = -I$(boost_DIR)

# Dependency rule 
$(BOOST_THREAD_LIB_NAME): $(BOOST_SYSTEM_LIB_NAME) $(BOOST_CHRONO_LIB_NAME) $(BOOST_DATETIME_LIB_NAME)

# Link rule 
$(BOOST_THREAD_LIB_NAME):
		if [ ! -f "$@" ]; then\
		echo "$@ does not exist, should have been built by CMake before."; \
		false; \
	fi

endif # __BOOST_THREAD__
