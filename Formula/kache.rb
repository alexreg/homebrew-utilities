class Kache < Formula
  desc "Utility for caching output of command-line programs"
  homepage "https://github.com/alexreg/kache"
  url "https://github.com/alexreg/kache/archive/v0.2.0.tar.gz"
  sha256 "597ba136fed55952305634f499f9aa7a2d5bb08148d773b4a21c635fdd1ba23a"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/alexreg/dev"
    sha256 cellar: :any_skip_relocation, monterey:     "7d708f5f78ca6ef66a706206d13b333525ce007e76c4170a9cd6232f3439b137"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3862f5d6967225b77b89935655c18e8f5e2bf74660ef5a81b6efe55e4104b2c6"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    cache_dir = testpath/".kache"

    command = "#{bin}/kache --cache #{cache_dir} -d 2s date +%s%N"
    date = shell_output(command)
    sleep 1
    assert date == shell_output(command)
    sleep 4
    assert date != shell_output(command)
  end
end
