require "formula"

class QtWebkit < Formula
  desc "Classes for a WebKit2 based implementation and a new QML API"
  homepage "http://qt-project.org/"
  url "https://github.com/annulen/webkit/releases/download/qtwebkit-5.212.0-alpha2/qtwebkit-5.212.0-alpha2.tar.xz"
  sha256 "f8f901de567e11fc5659402b6b827eac75505ff9c5072d8e919aa306003f8f8a"

  head "https://github.com/annulen/webkit.git"

  patch do
    # Fix null point dereference (Fedora) https://github.com/annulen/webkit/issues/573
    url "https://git.archlinux.org/svntogit/packages.git/plain/trunk/qt5-webkit-null-pointer-dereference.patch?h=packages/qt5-webkit"
    sha256 "510e1f78c2bcd76909703a097dbc1d5c9c6ce4cd94883c26138f09cc10121f43"
  end

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "sqlite3" => :build

  depends_on "qt"
  depends_on "zlib"
  depends_on "webp"
  depends_on "libxslt"
  #depends_on "hyphen"

  def install
    args = std_cmake_args
    args << "-DPORT=Qt"
    args << "-DENABLE_TOOLS=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
