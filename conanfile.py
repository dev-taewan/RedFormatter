from conan import ConanFile
from conan.tools.cmake import CMake, CMakeToolchain, cmake_layout, CMakeDeps


class RedFormatterRecipe(ConanFile):
    name = "redformatter"
    version = "1.0"
    package_type = "application"

    # Optional metadata
    license = "MIT"
    author = "Your Name <your.email@example.com>"
    url = "https://github.com/your/repo"
    description = "A description of the RedFormatter package"
    topics = ("formatter", "redmine", "tool")

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"
    
    # Sources
    exports_sources = "CMakeLists.txt", "src/*"

    def layout(self):
        cmake_layout(self)

    def requirements(self):
        self.requires("cpprestsdk/2.10.19")
        self.requires("boost/1.83.0")
        self.requires("openssl/3.3.2")
        self.requires("bzip2/1.0.8")
        self.requires("libiconv/1.17")
        self.requires("zlib/1.3.1")

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()

        tc = CMakeToolchain(self)
        # 빌드 타입 명확히 전달
        tc.variables["CMAKE_BUILD_TYPE"] = str(self.settings.build_type)
        tc.variables["CMAKE_EXPORT_COMPILE_COMMANDS"] = True
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.bindirs = ["bin"]
        self.cpp_info.libdirs = ["lib"]
    def configure(self):
        self.settings.compiler.cppstd = "20"
