cask "dedrm" do
  version "10.0.9"
  sha256 "d46e7ff94a46dc871eb9b7e639e6da1883823cd5a9d705d53f51bd9c251aabda"

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
