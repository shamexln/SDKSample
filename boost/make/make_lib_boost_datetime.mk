ifndef __BOOST_DATETIME__
__BOOST_DATETIME__=1

include $(REL_VIEW_ROOT)/tools/utils/Make/global/global_$(PLATFORM).mk

# boost presets lib name on some platforms ( e.g. win32 ), see define BOOST_AUTO_LINK_NOMANGLE
BOOST_DATETIME_LIB_NAME = $(GLOBAL_LIB_DIR)/$(GLOBAL_LIB_PREFIX)boost_date_time.$(GLOBAL_LIB_EXT)

include $(boost_DIR)/make/libBoostDatetime_filelist.incl

BOOST_DATETIME_EXCLUDE_FILES = 
BOOST_DATETIME_INCLUDE_FILES = 
BOOST_DATETIME_SRC_FILES     = $(filter-out $(BOOST_DATETIME_EXCLUDE_FILES), $(BOOST_DATETIME_SRC)) $(BOOST_DATETIME_INCLUDE_FILES)
BOOST_DATETIME_OBJ_FILES     = $(subst $(boost_DIR),$(GLOBAL_OUT_DIR)/boost,$(addsuffix .$(GLOBAL_EXTOBJ),$(basename $(BOOST_DATETIME_SRC_FILES))))
$(GLOBAL_OUT_DIR)/boost/%.$(GLOBAL_EXTOBJ): $(boost_DIR)/%.cpp
	$(GLOBAL_CXXCOMPILE)

ifndef NO_DEP_INCLUDE
-include $(BOOST_DATETIME_OBJ_FILES:.$(GLOBAL_EXTOBJ)=.dep)
endif

# Extra Compiler settings
$(BOOST_DATETIME_OBJ_FILES) : EXTRA_CXXDEFINES = -I$(boost_DIR)
$(BOOST_DATETIME_OBJ_FILES) : EXTRA_CCDEFINES  = -I$(boost_DIR)

# Link rule 
$(BOOST_DATETIME_LIB_NAME):
		if [ ! -f "$@" ]; then\
		echo "$@ does not exist, should have been built by CMake before."; \
		false; \
	fi

endif # __BOOST_DATETIME__
