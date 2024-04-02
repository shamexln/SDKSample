include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/program_options/src ABSOLUTE)

add_boost_library(TARGET program_options)

target_sources(${target}
    PRIVATE
        ${src}/cmdline.cpp
        ${src}/config_file.cpp
        ${src}/convert.cpp
        ${src}/options_description.cpp
        ${src}/parsers.cpp
        ${src}/positional_options.cpp
        ${src}/split.cpp
        ${src}/utf8_codecvt_facet.cpp
        ${src}/value_semantic.cpp
        ${src}/variables_map.cpp
        ${src}/winmain.cpp
)
