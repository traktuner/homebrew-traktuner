cask "2fhey" do
  version "2.1"
  sha256 :no_check

  url "https://gumroad.com/r/b87af1395e7d054f9f9c0e4a34bfaa81/product_files?product_file_ids%5B%5D=fdmIwtxcrCV5vfmwzVd_nw%3D%3D"
  name "2FHey"
  desc "IMessage OTP/2FA AutoFill"
  homepage "https://sofriendly.gumroad.com/l/2fhey"

  livecheck do
    url "https://raw.githubusercontent.com/SoFriendly/2fhey/main/TwoFHey.xcodeproj/project.pbxproj"
    strategy :page_match
    regex(/PRODUCT_NAME = 2FHey;.*?MARKETING_VERSION = (\d+\.\d+(?:\.\d+)?);/m)
  end

  auto_updates true
  depends_on macos: ">= :monterey"

  app "2FHey.app"

  uninstall quit: "com.sofriendly.2fhey"

  zap trash: [
    "~/Library/Application Support/2FHey",
    "~/Library/Caches/com.sofriendly.2fhey",
    "~/Library/Preferences/com.sofriendly.2fhey.plist",
    "~/Library/Saved Application State/com.sofriendly.2fhey.savedState",
  ]
end
