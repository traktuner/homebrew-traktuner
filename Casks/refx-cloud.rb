cask "refx-cloud" do
  version "3.0.14"
  sha256 "859e1e486d95b92cd4af34970466939e0466cb6bb244d133afe1cfdeadb1eea7"
  url "https://cloud.refx.com/update/reFX_Cloud_#{version}.pkg"
  name "reFX Cloud Application"
  desc "Software to download reFX plugins and content"
  homepage "https://refx.com"

  livecheck do
    url "https://refx.com/cloud/version/"
    strategy :page_match
    regex(/<div class="version mt-4">.*?<h1>(\d+\.\d+\.\d+)<\/h1>.*?<h2>\d{4}-\d{2}-\d{2}<\/h2>/i)
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  pkg "reFX_Cloud_#{version}.pkg"

  uninstall quit: "com.refx.cloud",
            pkgutil: [
              "com.refx.pkg.reFXCloud"
            ]

  zap trash: [
    "~/Library/Application Support/reFX",
    "~/Library/Saved Application State/com.refx.cloud.savedState",
    "~/Library/Caches/reFX Cloud",
  ]
end
