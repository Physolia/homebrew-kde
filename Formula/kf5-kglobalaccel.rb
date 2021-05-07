require_relative "../lib/cmake"

class Kf5Kglobalaccel < Formula
  desc "Add support for global workspace shortcuts"
  homepage "https://api.kde.org/frameworks/kglobalaccel/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.81/kglobalaccel-5.81.0.tar.xz"
  sha256 "ff33288695af403eaf3ddd2a142e3ea7d3451c897e6d49a3746b6977aba3b829"
  head "https://invent.kde.org/frameworks/kglobalaccel.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcrash"
  depends_on "kde-mac/kde/kf5-kdbusaddons"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5GlobalAccel REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
