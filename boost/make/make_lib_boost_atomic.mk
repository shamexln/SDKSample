ifndef __BOOST_ATOMIC__
__BOOST_ATOMIC__=1

include $(REL_VIEW_ROOT)/tools/utils/Make/global/global_$(PLATFORM).mk

# boost presets lib name on some platforms ( e.g. win32 ), see define BOOST_AUTO_LINK_NOMANGLE
BOOST_ATOMIC_LIB_NAME = $(GLOBAL_LIB_DIR)/$(GLOBAL_LIB_PREFIX)boost_atomic.$(GLOBAL_LIB_EXT)

include $(boost_DIR)/make/libBoostAtomic_filelist.incl

BOOST_ATOMIC_EXCLUDE_FILES = 
BOOST_ATOMIC_INCLUDE_FILES = 
BOOST_ATOMIC_SRC_FILES     = $(filter-out $(BOOST_ATOMIC_EXCLUDE_FILES), $(BOOST_ATOMIC_SRC)) $(BOOST_ATOMIC_INCLUDE_FILES)
BOOST_ATOMIC_OBJ_FILES     = $(subst $(boost_DIR),$(GLOBAL_OUT_DIR)/boost,$(addsuffix .$(GLOBAL_EXTOBJ),$(basename $(BOOST_ATOMIC_SRC_FILES))))

$(GLOBAL_OUT_DIR)/boost/%.$(GLOBAL_EXTOBJ): $(boost_DIR)/%.cpp
	$(GLOBAL_CXXCOMPILE)
ifndef NO_DEP_INCLUDE
-include $(BOOST_ATOMIC_OBJ_FILES:.$(GLOBAL_EXTOBJ)=.dep)
endif

# Extra Compiler settings
$(BOOST_ATOMIC_OBJ_FILES) : EXTRA_CXXDEFINES = -I$(boost_DIR)
$(BOOST_ATOMIC_OBJ_FILES) : EXTRA_CCDEFINES  = -I$(boost_DIR)

# Link rule 
$(BOOST_ATOMIC_LIB_NAME):
	if [ ! -f "$@" ]; then\
		echo "$@ does not exist, should have been built by CMake before."; \
		false; \
	fi

endif # __BOOST_ATOMIC__
