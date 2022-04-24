cask "dedrm" do
  version "10.0.2"
  sha256 "2009abe968460e41188454331901e62a57e459629b2da9d7088fe003bf3e8ce3"
  url "https://github.com/noDRM/DeDRM_tools/releases/download/v#{version}/DeDRM_tools_#{version}.zip"
  name "dedrm"
  desc "DeDRM tools for e-books"
  homepage "https://github.com/noDRM/DeDRM_tools"

  installer script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args: ["-a", "#{staged_path}/DeDRM_plugin.zip"],
  }

  installer script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args: ["-a", "#{staged_path}/Obok_plugin.zip"],
  }

  uninstall script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args: ["-r", "DeDRM"],
  }

  uninstall script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args: ["-r", "Obok DeDRM"],
  }

  zap trash: [
    "~/Library/Preferences/calibre/plugins/DeDRM",
    "~/Library/Preferences/calibre/plugins/dedrm.json",
    "~/Library/Preferences/calibre/plugins/obok_dedrm_prefs.json",
  ]
end
