class Pdfmarks < Formula
  desc "Renumber pages of PDF files"
  homepage "https://github.com/alexreg/pdfmarks"
  url "https://github.com/alexreg/pdfmarks/archive/v0.2.3.tar.gz"
  sha256 "6b8fb1002c4edfcb3363b3f7701171da7540662f6aa5d2570296b165628a9a13"
  revision 1
  head "https://github.com/alexreg/pdfmarks.git"

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
