class Kache < Formula
  desc "Utility for caching output of command-line programs"
  homepage "https://github.com/alexreg/kache"
  url "https://github.com/alexreg/kache/archive/v0.1.0.tar.gz"
  sha256 "3df3ae263cf311f91f4d1cefa986b38510d6092774b54a4e7cb10cd664d715ae"
  license "BSD-3-Clause"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # TODO
  end
end
