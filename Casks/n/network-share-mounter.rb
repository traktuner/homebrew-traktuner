cask "network-share-mounter" do
  version "3.0.4"
  sha256 "2f9f84f5e918630dbe0f149632a6f2d818c3ae22f22e3967fee01cbf6903bea9"

  url "https://gitlab.rrze.fau.de/faumac/networkShareMounter/-/releases/download/release-#{version}/NetworkShareMounter-#{version}.dmg"
  name "Network Share Mounter"
  desc "Tool for managing network shares"
  homepage "https://gitlab.rrze.fau.de/faumac/networkShareMounter"

  livecheck do
    url "https://gitlab.rrze.fau.de/api/v4/projects/506/releases"
    regex(/"tag_name":"release-(\d+(?:\.\d+)+)"/i)
    strategy :json do |json, regex|
      json.map { |release| release["tag_name"] }.select { |tag| tag.match?(regex) }.map { |tag| tag.match(regex)[1] }
    end
  end

  app "NetworkShareMounter.app"

  zap trash: [
    "~/Library/Application Scripts/de.fau.rrze.NetworkShareMounter-LaunchAtLoginHelper",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/de.fau.rrze.networksharemounter.sfl3",
    "~/Library/Containers/de.fau.rrze.NetworkShareMounter-LaunchAtLoginHelper",
    "~/Library/HTTPStorages/de.fau.rrze.NetworkShareMounter",
    "~/Library/Preferences/de.fau.rrze.NetworkShareMounter.plist",
  ]
end