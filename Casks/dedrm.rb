cask "dedrm" do
  version "10.0.3"
  sha256 "8649e30efb0c26e9cca1131df4c9d02d51eccb5028d396cce857f0fa75a62849"

  url "https://github.com/noDRM/DeDRM_tools/releases/download/v#{version}/DeDRM_tools_#{version}.zip"
  name "dedrm"
  desc "Tools for removing DRM from e-books"
  homepage "https://github.com/noDRM/DeDRM_tools"

  installer script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args:       ["-a", "#{staged_path}/DeDRM_plugin.zip"],
  }
  installer script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args:       ["-a", "#{staged_path}/Obok_plugin.zip"],
  }

  uninstall script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args:       ["-r", "DeDRM"],
  }
  uninstall script: {
    executable: "/Applications/calibre.app/Contents/MacOS/calibre-customize",
    args:       ["-r", "Obok DeDRM"],
  }

  zap trash: [
    "~/Library/Preferences/calibre/plugins/DeDRM",
    "~/Library/Preferences/calibre/plugins/dedrm.json",
    "~/Library/Preferences/calibre/plugins/obok_dedrm_prefs.json",
  ]
end
