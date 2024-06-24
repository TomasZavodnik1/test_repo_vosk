set(CMAKE_CXX_COMPILER "/nix/store/a9kr77jici5pfcv8hprqncnmjlsrjhi4-gcc-wrapper-12.3.0/bin/g++")
set(CMAKE_CXX_COMPILER_ARG1 "")
set(CMAKE_CXX_COMPILER_ID "GNU")
set(CMAKE_CXX_COMPILER_VERSION "12.3.0")
set(CMAKE_CXX_COMPILER_VERSION_INTERNAL "")
set(CMAKE_CXX_COMPILER_WRAPPER "")
set(CMAKE_CXX_STANDARD_COMPUTED_DEFAULT "17")
set(CMAKE_CXX_EXTENSIONS_COMPUTED_DEFAULT "ON")
set(CMAKE_CXX_COMPILE_FEATURES "cxx_std_98;cxx_template_template_parameters;cxx_std_11;cxx_alias_templates;cxx_alignas;cxx_alignof;cxx_attributes;cxx_auto_type;cxx_constexpr;cxx_decltype;cxx_decltype_incomplete_return_types;cxx_default_function_template_args;cxx_defaulted_functions;cxx_defaulted_move_initializers;cxx_delegating_constructors;cxx_deleted_functions;cxx_enum_forward_declarations;cxx_explicit_conversions;cxx_extended_friend_declarations;cxx_extern_templates;cxx_final;cxx_func_identifier;cxx_generalized_initializers;cxx_inheriting_constructors;cxx_inline_namespaces;cxx_lambdas;cxx_local_type_template_args;cxx_long_long_type;cxx_noexcept;cxx_nonstatic_member_init;cxx_nullptr;cxx_override;cxx_range_for;cxx_raw_string_literals;cxx_reference_qualified_functions;cxx_right_angle_brackets;cxx_rvalue_references;cxx_sizeof_member;cxx_static_assert;cxx_strong_enums;cxx_thread_local;cxx_trailing_return_types;cxx_unicode_literals;cxx_uniform_initialization;cxx_unrestricted_unions;cxx_user_literals;cxx_variadic_macros;cxx_variadic_templates;cxx_std_14;cxx_aggregate_default_initializers;cxx_attribute_deprecated;cxx_binary_literals;cxx_contextual_conversions;cxx_decltype_auto;cxx_digit_separators;cxx_generic_lambdas;cxx_lambda_init_captures;cxx_relaxed_constexpr;cxx_return_type_deduction;cxx_variable_templates;cxx_std_17;cxx_std_20;cxx_std_23")
set(CMAKE_CXX98_COMPILE_FEATURES "cxx_std_98;cxx_template_template_parameters")
set(CMAKE_CXX11_COMPILE_FEATURES "cxx_std_11;cxx_alias_templates;cxx_alignas;cxx_alignof;cxx_attributes;cxx_auto_type;cxx_constexpr;cxx_decltype;cxx_decltype_incomplete_return_types;cxx_default_function_template_args;cxx_defaulted_functions;cxx_defaulted_move_initializers;cxx_delegating_constructors;cxx_deleted_functions;cxx_enum_forward_declarations;cxx_explicit_conversions;cxx_extended_friend_declarations;cxx_extern_templates;cxx_final;cxx_func_identifier;cxx_generalized_initializers;cxx_inheriting_constructors;cxx_inline_namespaces;cxx_lambdas;cxx_local_type_template_args;cxx_long_long_type;cxx_noexcept;cxx_nonstatic_member_init;cxx_nullptr;cxx_override;cxx_range_for;cxx_raw_string_literals;cxx_reference_qualified_functions;cxx_right_angle_brackets;cxx_rvalue_references;cxx_sizeof_member;cxx_static_assert;cxx_strong_enums;cxx_thread_local;cxx_trailing_return_types;cxx_unicode_literals;cxx_uniform_initialization;cxx_unrestricted_unions;cxx_user_literals;cxx_variadic_macros;cxx_variadic_templates")
set(CMAKE_CXX14_COMPILE_FEATURES "cxx_std_14;cxx_aggregate_default_initializers;cxx_attribute_deprecated;cxx_binary_literals;cxx_contextual_conversions;cxx_decltype_auto;cxx_digit_separators;cxx_generic_lambdas;cxx_lambda_init_captures;cxx_relaxed_constexpr;cxx_return_type_deduction;cxx_variable_templates")
set(CMAKE_CXX17_COMPILE_FEATURES "cxx_std_17")
set(CMAKE_CXX20_COMPILE_FEATURES "cxx_std_20")
set(CMAKE_CXX23_COMPILE_FEATURES "cxx_std_23")

set(CMAKE_CXX_PLATFORM_ID "Linux")
set(CMAKE_CXX_SIMULATE_ID "")
set(CMAKE_CXX_COMPILER_FRONTEND_VARIANT "GNU")
set(CMAKE_CXX_SIMULATE_VERSION "")




set(CMAKE_AR "/nix/store/a9kr77jici5pfcv8hprqncnmjlsrjhi4-gcc-wrapper-12.3.0/bin/ar")
set(CMAKE_CXX_COMPILER_AR "/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/bin/gcc-ar")
set(CMAKE_RANLIB "/nix/store/a9kr77jici5pfcv8hprqncnmjlsrjhi4-gcc-wrapper-12.3.0/bin/ranlib")
set(CMAKE_CXX_COMPILER_RANLIB "/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/bin/gcc-ranlib")
set(CMAKE_LINKER "/nix/store/a9kr77jici5pfcv8hprqncnmjlsrjhi4-gcc-wrapper-12.3.0/bin/ld")
set(CMAKE_MT "")
set(CMAKE_TAPI "CMAKE_TAPI-NOTFOUND")
set(CMAKE_COMPILER_IS_GNUCXX 1)
set(CMAKE_CXX_COMPILER_LOADED 1)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_CXX_ABI_COMPILED TRUE)

set(CMAKE_CXX_COMPILER_ENV_VAR "CXX")

set(CMAKE_CXX_COMPILER_ID_RUN 1)
set(CMAKE_CXX_SOURCE_FILE_EXTENSIONS C;M;c++;cc;cpp;cxx;m;mm;mpp;CPP;ixx;cppm;ccm;cxxm;c++m)
set(CMAKE_CXX_IGNORE_EXTENSIONS inl;h;hpp;HPP;H;o;O;obj;OBJ;def;DEF;rc;RC)

foreach (lang C OBJC OBJCXX)
  if (CMAKE_${lang}_COMPILER_ID_RUN)
    foreach(extension IN LISTS CMAKE_${lang}_SOURCE_FILE_EXTENSIONS)
      list(REMOVE_ITEM CMAKE_CXX_SOURCE_FILE_EXTENSIONS ${extension})
    endforeach()
  endif()
endforeach()

set(CMAKE_CXX_LINKER_PREFERENCE 30)
set(CMAKE_CXX_LINKER_PREFERENCE_PROPAGATES 1)
set(CMAKE_CXX_LINKER_DEPFILE_SUPPORTED TRUE)

# Save compiler ABI information.
set(CMAKE_CXX_SIZEOF_DATA_PTR "8")
set(CMAKE_CXX_COMPILER_ABI "ELF")
set(CMAKE_CXX_BYTE_ORDER "LITTLE_ENDIAN")
set(CMAKE_CXX_LIBRARY_ARCHITECTURE "")

if(CMAKE_CXX_SIZEOF_DATA_PTR)
  set(CMAKE_SIZEOF_VOID_P "${CMAKE_CXX_SIZEOF_DATA_PTR}")
endif()

if(CMAKE_CXX_COMPILER_ABI)
  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_CXX_COMPILER_ABI}")
endif()

if(CMAKE_CXX_LIBRARY_ARCHITECTURE)
  set(CMAKE_LIBRARY_ARCHITECTURE "")
endif()

set(CMAKE_CXX_CL_SHOWINCLUDES_PREFIX "")
if(CMAKE_CXX_CL_SHOWINCLUDES_PREFIX)
  set(CMAKE_CL_SHOWINCLUDES_PREFIX "${CMAKE_CXX_CL_SHOWINCLUDES_PREFIX}")
endif()





set(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES "/nix/store/v4hi0x85i9f6y5rnk5ldqyz3k6dy8q3w-libtool-2.4.7/include;/nix/store/8125v3x3mbzdzrm1cjgc5m58mqmclha5-file-5.45-dev/include;/nix/store/pxbbz0fr49ly3nglp6wrzg1xgplkbl2z-python-2.7.18.7/include;/nix/store/gdbnfxhqls37zywbnpfd8j9jcqwwk791-subversion-1.14.2-dev/include;/nix/store/akyvqc1qabybiv40vj8rp2nkapwhixaa-python3-3.9.19/include;/nix/store/4ykhpsdcjwbzwq61wd5hlqai1qvhk9gc-sox-unstable-2021-05-09-dev/include;/nix/store/8hakrs12dkdmcfbg9650pmxg80mb2m7q-gfortran-12.3.0/include;/nix/store/4ri27bck8rh5r589x92982nr7qy41s5m-zlib-1.3-dev/include;/nix/store/z7mzccnisx6jp2q535wq2rs7ndrvw15i-gnumake-4.4.1/include;/nix/store/g48y3945z3k8gdq28pfvf34jgjqbs0mk-openblas-0.3.24-dev/include;/nix/store/rri2d3vpdkrifscyawpbwvv2a0whc2cy-openblas-0.3.24-dev/include;/nix/store/vyk8wgaw2hrh1bry6hsx98sanzma0jdc-bash-5.2-p15-dev/include;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/include/c++/12.3.0;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/include/c++/12.3.0/x86_64-unknown-linux-gnu;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/include/c++/12.3.0/backward;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/lib/gcc/x86_64-unknown-linux-gnu/12.3.0/include;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/include;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/lib/gcc/x86_64-unknown-linux-gnu/12.3.0/include-fixed;/nix/store/62pbcx7vqyjj4yg10cc16ywbzbvrdpsm-glibc-2.38-66-dev/include")
set(CMAKE_CXX_IMPLICIT_LINK_LIBRARIES "stdc++;m;gcc_s;gcc;c;gcc_s;gcc")
set(CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES "/nix/store/r46aibnxb5151ijrywmmqk0m9hmpw0v8-file-5.45/lib;/nix/store/9sga41znf2cl59fvibrikw0b10mh5865-libtool-2.4.7-lib/lib;/nix/store/pxbbz0fr49ly3nglp6wrzg1xgplkbl2z-python-2.7.18.7/lib;/nix/store/wzljwk6grxzq1jqrh56vp43j6za94v4l-subversion-1.14.2/lib;/nix/store/akyvqc1qabybiv40vj8rp2nkapwhixaa-python3-3.9.19/lib;/nix/store/6l4g8wj0fyd0hxjpdwnbk76yl4ibb60q-sox-unstable-2021-05-09-lib/lib;/nix/store/8hakrs12dkdmcfbg9650pmxg80mb2m7q-gfortran-12.3.0/lib;/nix/store/00s1y6c07dxjw099mavlpx2wxkcqwp01-gfortran-12.3.0-lib/lib;/nix/store/iz05mrzi4g4kaml85lx6sp97f5fxd8fq-zlib-1.3/lib;/nix/store/w3j8xfgmxvgvxykiysl7ymj77im2lp96-openblas-0.3.24/lib;/nix/store/nc9li1c1rslzds3r44a8n1imgiyras3l-openblas-0.3.24/lib;/nix/store/p9ysh5rk109gyjj3cn6jr54znvvlahfl-glibc-2.38-66/lib;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/lib/gcc/x86_64-unknown-linux-gnu/12.3.0;/nix/store/31axfs6jsslijkdybyl3410zwfy1gvky-gcc-12.3.0-lib/lib;/nix/store/a9kr77jici5pfcv8hprqncnmjlsrjhi4-gcc-wrapper-12.3.0/bin;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/lib64;/nix/store/h2abv2l8irqj942i5rq9wbrj42kbsh5y-gcc-12.3.0/lib")
set(CMAKE_CXX_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")