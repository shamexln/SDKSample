include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/serialization/src ABSOLUTE)

add_boost_library(TARGET serialization REQUIRED)

set_target_properties(${target} PROPERTIES UNITY_BUILD OFF)

target_compile_definitions(${target}
    PRIVATE
        $<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
)

target_sources(${target}
    PRIVATE
        ${src}/archive_exception.cpp
        ${src}/basic_archive.cpp
        ${src}/basic_iarchive.cpp
        ${src}/basic_iserializer.cpp
        ${src}/basic_oarchive.cpp
        ${src}/basic_oserializer.cpp
        ${src}/basic_pointer_iserializer.cpp
        ${src}/basic_pointer_oserializer.cpp
        ${src}/basic_serializer_map.cpp
        ${src}/basic_text_iprimitive.cpp
        ${src}/basic_text_oprimitive.cpp
        ${src}/basic_xml_archive.cpp
        ${src}/binary_iarchive.cpp
        ${src}/binary_oarchive.cpp
        ${src}/codecvt_null.cpp
        ${src}/extended_type_info.cpp
        ${src}/extended_type_info_no_rtti.cpp
        ${src}/extended_type_info_typeid.cpp
        ${src}/polymorphic_iarchive.cpp
        ${src}/polymorphic_oarchive.cpp
        ${src}/stl_port.cpp
        ${src}/text_iarchive.cpp
        ${src}/text_oarchive.cpp
        ${src}/utf8_codecvt_facet.cpp
        ${src}/void_cast.cpp
        ${src}/xml_archive_exception.cpp
        ${src}/xml_grammar.cpp
        ${src}/xml_iarchive.cpp
        ${src}/xml_oarchive.cpp
)
