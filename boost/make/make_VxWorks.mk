include $(boost_DIR)/make/make_lib_boost_chrono_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_atomic_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_datetime_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_exception_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_filesystem_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_graph_$(PLATFORM).mk
# not working (yet):
#include $(boost_DIR)/make/make_lib_boost_iostreams_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_math_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_program_options_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_random_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_regex_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_serialization_$(PLATFORM).mk
# signals has been deprecated use signals2 (header-only) instead
#include $(boost_DIR)/make/make_lib_boost_signals_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_system_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_thread_$(PLATFORM).mk
include $(boost_DIR)/make/make_lib_boost_wave_$(PLATFORM).mk
