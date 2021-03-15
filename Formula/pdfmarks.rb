class Pdfmarks < Formula
  desc "Renumber pages of PDF files"
  homepage "https://github.com/alexreg/pdfmarks"
  url "https://github.com/alexreg/pdfmarks/archive/v0.2.2.tar.gz"
  sha256 "c2d8ca244f34d6bd936a4b7c23603b4b841d372bf46a2f0574bd80aa600ddb4a"
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
