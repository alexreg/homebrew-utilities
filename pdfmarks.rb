require 'formula'

class Pdfmarks < Formula
  homepage 'https://bitbucket.org/alexreg/pdfmarks'
  url 'https://bitbucket.org/alexreg/pdfmarks/get/v0.2.1.tar.gz'
  sha256 '6e68b92418ed40046b71bbc0eb976b7e2e18cc91cb3b1fa14f4df5d0b3fbdf46'

  depends_on 'ghostscript'

  def install
    inreplace 'pdfmarks' do |s|
      s.gsub! "source \"common\"", "source \"#{libexec}/common\""
      s.gsub! "\"pdfmarks.ps\"", "\"#{share}/pdfmarks.ps\""
    end

    share.install 'pdfmarks.ps'
    libexec.install 'common'
    bin.install 'pdfmarks'
  end

  test do
    system "#{bin}/pdfmarks", "-h"
  end
end
