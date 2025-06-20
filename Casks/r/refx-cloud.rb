cask "refx-cloud" do
  version "3.0.18"
  sha256 "c74577f826413bd04aef310bf7cbc6e6e20ee8d8790945845551fe0775fcd73b"

  url "https://cloud.refx.com/update/reFX_Cloud_#{version}.pkg"
  name "reFX Cloud Application"
  desc "Software to download reFX plugins and content"
  homepage "https://refx.com/"

  livecheck do
    url "https://refx.com/cloud/version/"
    strategy :page_match
    regex(%r{<div class="version mt-4">.*?<h1>(\d+\.\d+\.\d+)</h1>.*?<h2>\d{4}-\d{2}-\d{2}</h2>}i)
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  pkg "reFX_Cloud_#{version}.pkg"

  uninstall quit:    "com.refx.cloud",
            pkgutil: "com.refx.pkg.reFXCloud"

  zap trash: [
    "~/Library/Application Support/reFX",
    "~/Library/Caches/reFX Cloud",
    "~/Library/Saved Application State/com.refx.cloud.savedState",
  ]
end
