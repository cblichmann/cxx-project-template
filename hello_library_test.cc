#include "hello_library.h"

#include "absl/strings/ascii.h"
#include "absl/strings/string_view.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace hello {
namespace {

using ::testing::HasSubstr;

TEST(HelloTests, EmptyGreetingGreetsWorld) {
  EXPECT_THAT(absl::AsciiStrToLower(hello::GetGreeting("")),
              HasSubstr("world"));
}

TEST(HelloTests, GreetingContainsName) {
  EXPECT_THAT(hello::GetGreeting("Aethelwulf"), HasSubstr("Aethelwulf"));
}

}  // namespace
}  // namespace hello
