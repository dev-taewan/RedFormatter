#pragma once

#include <vector>
#include <string>


#ifdef _WIN32
  #define REDFOMATTER_EXPORT __declspec(dllexport)
#else
  #define REDFOMATTER_EXPORT
#endif

REDFOMATTER_EXPORT void redfomatter();
REDFOMATTER_EXPORT void redfomatter_print_vector(const std::vector<std::string> &strings);
