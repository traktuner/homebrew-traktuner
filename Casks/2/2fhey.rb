cask "2fhey" do
  version "1.3"
  sha256 "33722dcb8836be1667076051ced8bc737d0f0ef0817910969c57a7b00c1aadcf"

  url "https://gumroad.com/r/e1621c37618aab38f0491222389c0595/product_files?product_file_ids%5B%5D=67GXU9CWO5B0AaTBx7cNqA%3D%3D"
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
