# 定义 CMake 最低版本
cmake_minimum_required(VERSION 3.10)

# 定义项目名称和语言
project(MyProject VERSION 1.0 LANGUAGES C CXX)

# 设置编译选项
set(CMAKE_C_STANDARD 99)  # 设置 C 标准为 C99
set(CMAKE_CXX_STANDARD 11)  # 设置 C++ 标准为 C++11

# 指定源文件
set(SOURCES
    src/main.c
    src/foo.c
    src/bar.c
)

# 定义可执行目标
add_executable(my_program ${SOURCES})

# 包含头文件目录
target_include_directories(my_program PUBLIC ${PROJECT_SOURCE_DIR}/include)

# 链接库文件 (如果有)
# target_link_libraries(my_program PRIVATE my_library)
