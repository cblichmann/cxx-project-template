#include "hello_library.h"

#include "absl/strings/ascii.h"
#include "absl/strings/str_cat.h"

namespace hello {

std::string GetGreeting(absl::string_view for_name) {
  absl::string_view clean_name = absl::StripAsciiWhitespace(for_name);
  return absl::StrCat("Hello, ", clean_name.empty() ? "world" : clean_name,
                      "!");
}

}  // namespace hello
