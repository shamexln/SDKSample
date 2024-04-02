cmake_minimum_required(VERSION 3.12)

get_filename_component(boost_root ${CMAKE_CURRENT_LIST_DIR}/.. ABSOLUTE)

include(global_helper)

function(add_boost_library)
    cmake_parse_arguments(LIB "HEADER_ONLY" "TARGET" "" ${ARGN})

    if(LIB_HEADER_ONLY)
        set(target Boost_${LIB_TARGET})
        set(target Boost_${LIB_TARGET} PARENT_SCOPE)

        add_library(${target} INTERFACE)
        add_library(Boost::${LIB_TARGET} ALIAS ${target})

        target_include_directories(${target} SYSTEM
            INTERFACE
                ${boost_root}
        )

        # by setting this flag we tell boost.interprocess that we have implemented a function
        # which tells boost.interprocess in which folder the interprocess-resource-files shall
        # be placed into this functionality is only used/available for windows
        # for further details see boost.interprocess documentation
        # https://www.boost.org/doc/libs/1_70_0/doc/html/interprocess/acknowledgements_notes.html#interprocess.acknowledgements_notes.notes_windows.notes_windows_shm_folder
        #
        # once docker is established for providing the build environment this functionality can be disabled
        target_compile_definitions(${target}
            INTERFACE
                $<$<PLATFORM_ID:Windows>:BOOST_INTERPROCESS_SHARED_DIR_FUNC>
        )
    else()
        set(target Boost_${LIB_TARGET}_obj)
        set(target Boost_${LIB_TARGET}_obj PARENT_SCOPE)

        add_library(${target} OBJECT)
        target_include_directories(${target} SYSTEM
            PUBLIC
                ${boost_root}
        )
        target_compile_features(${target}
            PRIVATE
                cxx_std_11
        )

        if(SUPPORT_LEGACY_GLOBAL_MAKE)
            target_compile_definitions(${target}
                PUBLIC
                    BOOST_AUTO_LINK_NOMANGLE
            )

            # used by framework library
            add_library(Boost::${LIB_TARGET}_obj ALIAS ${target})

            add_library(Boost_${LIB_TARGET} STATIC)
            target_link_libraries(Boost_${LIB_TARGET}
                PUBLIC
                    ${target}
                INTERFACE
                    $<TARGET_GENEX_EVAL:${target},$<TARGET_PROPERTY:${target},LINK_INTERFACE_LIBRARIES>>
                PRIVATE
                    $<TARGET_GENEX_EVAL:${target},$<TARGET_PROPERTY:${target},LINK_LIBRARIES>>
            )
            global_install_gnu_make_libs(TARGET Boost_${LIB_TARGET}
                                         VXWORKS libboost_${LIB_TARGET}
                                         WIN boost_${LIB_TARGET})
        else()
            target_compile_definitions(${target}
                PUBLIC
                    BOOST_ALL_NO_LIB
                    $<$<BOOL:${BUILD_SHARED_LIBS}>:BOOST_ALL_DYN_LINK>
            )

            add_library(Boost_${LIB_TARGET})
            target_link_libraries(Boost_${LIB_TARGET}
                PUBLIC
                    ${target}
                INTERFACE
                    $<TARGET_GENEX_EVAL:${target},$<TARGET_PROPERTY:${target},LINK_INTERFACE_LIBRARIES>>
                PRIVATE
                    $<TARGET_GENEX_EVAL:${target},$<TARGET_PROPERTY:${target},LINK_LIBRARIES>>
            )
        endif()
        add_library(Boost::${LIB_TARGET} ALIAS Boost_${LIB_TARGET})
    endif()
endfunction()
