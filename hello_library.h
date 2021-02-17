#ifndef HELLO_LIBRARY_H_
#define HELLO_LIBRARY_H_

#include <string>

#include "absl/strings/string_view.h"

namespace hello {

// Returns a nice greeting for the specified name.
std::string GetGreeting(absl::string_view for_name);

}  // namespace hello

#endif  // HELLO_LIBRARY_H_
