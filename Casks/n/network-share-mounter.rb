cask "network-share-mounter" do
  version "3.1.7"
  sha256 "7bf94f45e7d4e4aeea37af2ee93a9d9d23a321b18580d7de11cabf7dbcebc3ee"

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
