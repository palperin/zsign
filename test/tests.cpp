#include <gtest/gtest.h>

#include "../common/common.h"


TEST(zSignTest, GetCanonicalizePath) {
  string result = GetCanonicalizePath("just_file_name.extension");
  EXPECT_EQ("/Users/marek/_repos/zsign_my_fork/zsign/test/just_file_name.extension", result);
  result = GetCanonicalizePath("../another_file_name.ext");
  EXPECT_EQ("/Users/marek/_repos/zsign_my_fork/zsign/test/../another_file_name.ext", result);
  result = GetCanonicalizePath("some_folder/yet_another_file_name.ext");
  EXPECT_EQ("/Users/marek/_repos/zsign_my_fork/zsign/test/some_folder/yet_another_file_name.ext", result);
  //EXPECT_TRUE(false) << "result: " << result << std::endl;
}
