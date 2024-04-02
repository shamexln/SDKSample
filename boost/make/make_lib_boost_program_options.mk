ifndef __BOOST_PROGRAMOPTIONS__
__BOOST_PROGRAMOPTIONS__=1

include $(REL_VIEW_ROOT)/tools/utils/Make/global/global_$(PLATFORM).mk

# boost presets lib name on some platforms ( e.g. win32 ), see define BOOST_AUTO_LINK_NOMANGLE
BOOST_PROGRAMOPTIONS_LIB_NAME = $(GLOBAL_LIB_DIR)/$(GLOBAL_LIB_PREFIX)boost_program_options.$(GLOBAL_LIB_EXT)

include $(boost_DIR)/make/libBoostProgramOptions_filelist.incl

BOOST_PROGRAMOPTIONS_EXCLUDE_FILES = 
BOOST_PROGRAMOPTIONS_INCLUDE_FILES = 
BOOST_PROGRAMOPTIONS_SRC_FILES     = $(filter-out $(BOOST_PROGRAMOPTIONS_EXCLUDE_FILES), $(BOOST_PROGRAMOPTIONS_SRC)) $(BOOST_PROGRAMOPTIONS_INCLUDE_FILES)
BOOST_PROGRAMOPTIONS_OBJ_FILES     = $(subst $(boost_DIR),$(GLOBAL_OUT_DIR)/boost,$(addsuffix .$(GLOBAL_EXTOBJ),$(basename $(BOOST_PROGRAMOPTIONS_SRC_FILES))))
$(GLOBAL_OUT_DIR)/boost/%.$(GLOBAL_EXTOBJ): $(boost_DIR)/%.cpp
	$(GLOBAL_CXXCOMPILE)

ifndef NO_DEP_INCLUDE
-include $(BOOST_PROGRAMOPTIONS_OBJ_FILES:.$(GLOBAL_EXTOBJ)=.dep)
endif

$(BOOST_PROGRAMOPTIONS_OBJ_FILES) : EXTRA_CXXDEFINES = -I$(boost_DIR)
$(BOOST_PROGRAMOPTIONS_OBJ_FILES) : EXTRA_CCDEFINES  = -I$(boost_DIR)

# Link rule 
$(BOOST_PROGRAMOPTIONS_LIB_NAME):
		if [ ! -f "$@" ]; then\
		echo "$@ does not exist, should have been built by CMake before."; \
		false; \
	fi

endif # __BOOST_PROGRAMOPTIONS__
