require_relative "../lib/cmake"

class Drkonqi < Formula
  desc "Crash handler for KDE software"
  homepage "https://kde.org/plasma-desktop/"
  url "https://download.kde.org/stable/plasma/5.25.4/drkonqi-5.25.4.tar.xz"
  sha256 "c48de791bf9d25f817c08eab40cdae308336ce607f76223249ad2f213a21ca1a"
  head "https://invent.kde.org/plasma/drkonqi.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kdeclarative"
  depends_on "kde-mac/kde/kf5-kidletime"
  depends_on "kde-mac/kde/kf5-kxmlrpcclient"
  depends_on "kde-mac/kde/kf5-syntax-highlighting"

  # isn't packaged on ARM64 macOS
  depends_on "gdb" => :recommended if OS.linux? || (OS.mac? && Hardware::CPU.intel?)
  depends_on "kde-mac/kde/kf5-kirigami2" => :recommended

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_predicate lib/"drkonqi", :exist?
  end
end
