cask "2fhey" do
  version "1.3"
  sha256 "abdd1afbd8e9a02656ef7d09fdbff6698107676b29c451dbbad6fd20ca314654"

  url "https://gumroad.com/r/8ead109659ab27fde77bb34e76c05b75/product_files?product_file_ids%5B%5D=SzwZXLb7jNWhYM4gmZiz7A%3D%3D"
  name "2FHey"
  desc "iMessage OTP/2FA AutoFill"
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
