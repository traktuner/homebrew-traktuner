cask "network-share-mounter" do
  version "3.1.3"
  sha256 "72229308a283f8787ca24a7267942680e3a8caa6c41deaa393f932d87263153b"

  url "https://gitlab.rrze.fau.de/api/v4/projects/506/packages/generic/networksharemounter/release-#{version}/NetworkShareMounter-#{version}.dmg"
  name "Network Share Mounter"
  desc "Tool for managing network shares"
  homepage "https://gitlab.rrze.fau.de/faumac/networkShareMounter"

  livecheck do
    url "https://gitlab.rrze.fau.de/faumac/networkShareMounter/-/releases.json"
    regex(/"tag":"release-([0-9]+\.[0-9]+\.[0-9]+)"/i)
  end

  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Network Share Mounter.app"

  zap trash: [
    "~/Library/Application Scripts/de.fau.rrze.NetworkShareMounter-LaunchAtLoginHelper",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/de.fau.rrze.networksharemounter.sfl*",
    "~/Library/Containers/de.fau.rrze.NetworkShareMounter-LaunchAtLoginHelper",
    "~/Library/HTTPStorages/de.fau.rrze.NetworkShareMounter",
    "~/Library/Preferences/de.fau.rrze.NetworkShareMounter.plist",
  ]
end
