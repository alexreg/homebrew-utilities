class Pdfmarks < Formula
  desc "Renumber pages of PDF files"
  homepage "https://github.com/alexreg/pdfmarks"
  url "https://github.com/alexreg/pdfmarks/archive/v0.2.3.tar.gz"
  sha256 "6b8fb1002c4edfcb3363b3f7701171da7540662f6aa5d2570296b165628a9a13"
  revision 1
  head "https://github.com/alexreg/pdfmarks.git"

  bottle do
    root_url "https://ghcr.io/v2/alexreg/dev"
    sha256 cellar: :any_skip_relocation, monterey:     "fa183ccb4a7c251dc9e32774a38d546193a28797a57c33efb0b5be2508d35fc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8162f8d7f9f27b3e209776d7961ccec14987316466121d935594053c0b8e2afd"
  end

  depends_on "ghostscript"

  def install
    inreplace "pdfmarks" do |s|
      s.gsub! "source \"common\"", "source \"#{libexec}/common\""
      s.gsub! "\"pdfmarks.ps\"", "\"#{share}/pdfmarks.ps\""
    end

    share.install "pdfmarks.ps"
    libexec.install "common"
    bin.install "pdfmarks"
  end

  test do
    system "#{bin}/pdfmarks", "-h"
  end
end
