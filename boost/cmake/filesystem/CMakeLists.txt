include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/filesystem/src ABSOLUTE)

add_boost_library(TARGET filesystem)

target_sources(${target}
    PRIVATE
        ${src}/codecvt_error_category.cpp
        ${src}/operations.cpp
        ${src}/path.cpp
        ${src}/path_traits.cpp
        ${src}/portability.cpp
        ${src}/unique_path.cpp
        ${src}/utf8_codecvt_facet.cpp
        ${src}/windows_file_codecvt.cpp
)

global_target_dependencies(${target}
    PUBLIC
        Boost::system
)
