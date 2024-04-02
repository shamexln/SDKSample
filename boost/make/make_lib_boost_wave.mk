ifndef __BOOST_WAVE__
__BOOST_WAVE__=1

include $(REL_VIEW_ROOT)/tools/utils/Make/global/global_$(PLATFORM).mk

# boost presets lib name on some platforms ( e.g. win32 ), see define BOOST_AUTO_LINK_NOMANGLE
BOOST_WAVE_LIB_NAME = $(GLOBAL_LIB_DIR)/$(GLOBAL_LIB_PREFIX)boost_wave.$(GLOBAL_LIB_EXT)

include $(boost_DIR)/make/libBoostWave_filelist.incl

BOOST_WAVE_EXCLUDE_FILES = 
BOOST_WAVE_INCLUDE_FILES = 
BOOST_WAVE_SRC_FILES     = $(filter-out $(BOOST_WAVE_EXCLUDE_FILES), $(BOOST_WAVE_SRC)) $(BOOST_WAVE_INCLUDE_FILES)
BOOST_WAVE_OBJ_FILES     = $(subst $(boost_DIR),$(GLOBAL_OUT_DIR)/boost,$(addsuffix .$(GLOBAL_EXTOBJ),$(basename $(BOOST_WAVE_SRC_FILES))))

$(GLOBAL_OUT_DIR)/boost/%.$(GLOBAL_EXTOBJ): $(boost_DIR)/%.cpp
	$(GLOBAL_CXXCOMPILE)
ifndef NO_DEP_INCLUDE
-include $(BOOST_WAVE_OBJ_FILES:.$(GLOBAL_EXTOBJ)=.dep)
endif

# Extra Compiler settings
$(BOOST_WAVE_OBJ_FILES) : EXTRA_CXXDEFINES = -I$(boost_DIR)
$(BOOST_WAVE_OBJ_FILES) : EXTRA_CCDEFINES  = -I$(boost_DIR)

# Link rule 
$(BOOST_WAVE_LIB_NAME):
		if [ ! -f "$@" ]; then\
		echo "$@ does not exist, should have been built by CMake before."; \
		false; \
	fi

endif # __BOOST_WAVE__
