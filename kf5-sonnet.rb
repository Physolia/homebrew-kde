require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.22/sonnet-5.22.0.tar.xz"
  sha1 "33c98287623e1c95551e37791a859d76184e7292"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
