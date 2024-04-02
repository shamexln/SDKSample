get_filename_component(openssl_root ${CMAKE_CURRENT_LIST_DIR} ABSOLUTE)

if(NOT OpenSSL_FIND_COMPONENTS)
    set(OpenSSL_FIND_COMPONENTS Crypto SSL)
    if(NOT VXWORKS)
        list(APPEND OpenSSL_FIND_COMPONENTS Binary)
    endif()
endif()

if("SSL" IN_LIST OpenSSL_FIND_COMPONENTS)
    list(PREPEND OpenSSL_FIND_COMPONENTS "Crypto")
endif()

foreach(comp IN LISTS OpenSSL_FIND_COMPONENTS)
    if(TARGET OpenSSL::${comp})
        continue()
    endif()

    if(comp STREQUAL "Binary")
        add_executable(OpenSSL::Binary IMPORTED GLOBAL)
        set_target_properties(OpenSSL::Binary
            PROPERTIES
                IMPORTED_LOCATION ${openssl_root}/bin/openssl${CMAKE_EXECUTABLE_SUFFIX}
        )
    elseif(comp STREQUAL "Crypto")
        add_library(OpenSSL::Crypto SHARED IMPORTED GLOBAL)
        set_target_properties(OpenSSL::Crypto
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES ${openssl_root}/include
                INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${openssl_root}/include
        )
        if(WIN32)
            set_target_properties(OpenSSL::Crypto
                PROPERTIES
                    IMPORTED_IMPLIB "${openssl_root}/lib/libcrypto.lib"
                    IMPORTED_IMPLIB_DEBUG "${openssl_root}/lib-debug/libcrypto.lib"
                    IMPORTED_LOCATION "${openssl_root}/bin/libcrypto-1_1-x64.dll"
                    IMPORTED_LOCATION_DEBUG "${openssl_root}/bin-debug/libcrypto-1_1-x64.dll"
            )
        else()
            file(REAL_PATH "${openssl_root}/lib/libcrypto.dll" crypto_path)
            set_target_properties(OpenSSL::Crypto
                PROPERTIES
                    IMPORTED_LOCATION "${crypto_path}"
            )
        endif()
        if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND NOT CMAKE_CROSSCOMPILING)
            target_link_libraries(OpenSSL::Crypto
                INTERFACE
                    dl
                    pthread
            )
        endif()
    elseif(comp STREQUAL "SSL")
        add_library(OpenSSL::SSL SHARED IMPORTED GLOBAL)
        set_target_properties(OpenSSL::SSL
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES ${openssl_root}/include
                INTERFACE_SYSTEM_INCLUDE_DIRECTORIES  ${openssl_root}/include
        )
        target_link_libraries(OpenSSL::SSL
            INTERFACE
                OpenSSL::Crypto
                $<$<CXX_COMPILER_ID:MSVC>:ws2_32>
        )
        if(WIN32)
            set_target_properties(OpenSSL::SSL
                PROPERTIES
                    IMPORTED_IMPLIB "${openssl_root}/lib/libssl.lib"
                    IMPORTED_IMPLIB_DEBUG "${openssl_root}/lib-debug/libssl.lib"
                    IMPORTED_LOCATION "${openssl_root}/bin/libssl-1_1-x64.dll"
                    IMPORTED_LOCATION_DEBUG "${openssl_root}/bin-debug/libssl-1_1-x64.dll"
        )
        else()
            file(REAL_PATH "${openssl_root}/lib/libssl.dll" ssl_path)
            set_target_properties(OpenSSL::SSL
                PROPERTIES
                    IMPORTED_LOCATION "${ssl_path}"
            )
        endif()
    else()
        message(FATAL_ERROR "Unknown OpenSSL component: ${comp}")
    endif()
endforeach()
