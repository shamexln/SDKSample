include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/regex/src ABSOLUTE)

add_boost_library(TARGET regex)

set_target_properties(${target} PROPERTIES UNITY_BUILD OFF)

target_sources(${target}
    PRIVATE
        ${src}/c_regex_traits.cpp
        ${src}/cpp_regex_traits.cpp
        ${src}/cregex.cpp
        ${src}/fileiter.cpp
        ${src}/icu.cpp
        ${src}/instances.cpp
        ${src}/posix_api.cpp
        ${src}/regex.cpp
        ${src}/regex_debug.cpp
        ${src}/regex_raw_buffer.cpp
        ${src}/regex_traits_defaults.cpp
        ${src}/static_mutex.cpp
        ${src}/usinstances.cpp
        ${src}/w32_regex_traits.cpp
        ${src}/wc_regex_traits.cpp
        ${src}/wide_posix_api.cpp
        ${src}/winstances.cpp
    )
