#include <iostream>

#include "absl/strings/string_view.h"
#include "hello_library.h"

int main(int argc, char* argv[]) {
  absl::string_view for_name = argc > 1 ? argv[1] : "";
  std::cout << hello::GetGreeting(for_name) << std::endl;
}
