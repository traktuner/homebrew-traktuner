cask "jdownloader2-safari" do
  version "1.0.2"
  sha256 "e4595027e090b0691d7c0fd2196a944642fe51b6b895261517749abf0bd1de60"

  url "https://github.com/traktuner/jdownloader2-safari-extension/releases/download/v#{version}/MyJDownloader.zip"
  name "MyJDownloader Safari Extension"
  desc "Personal Safari port of the MyJDownloader browser extension"
  homepage "https://github.com/traktuner/jdownloader2-safari-extension"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "MyJDownloader.app"

  # CI ships an ad-hoc signed app. Re-sign it locally with this Mac's
  # "Apple Development" identity (auto-detected) so Safari loads the extension
  # without "Allow Unsigned Extensions". Entitlements/flags are preserved.
  postflight do
    app_path = "#{appdir}/MyJDownloader.app"
    appex = "#{app_path}/Contents/PlugIns/MyJDownloader Extension.appex"

    identity = `/usr/bin/security find-identity -v -p codesigning`[/Apple Development: [^"]+/]
    odie "No 'Apple Development' code-signing identity found in your keychain." if identity.to_s.strip.empty?

    [appex, app_path].each do |target|
      system_command "/usr/bin/codesign",
                     args: ["--force",
                            "--preserve-metadata=identifier,entitlements,requirements,flags,runtime",
                            "--sign", identity, target]
    end

    # Homebrew quarantines the downloaded app; the locally re-signed (but not
    # notarized) app would be blocked by Gatekeeper. Clear the quarantine flag
    # now that it's signed with this Mac's own trusted Development identity.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", app_path]

    # Launch once so Safari registers the extension.
    system_command "/usr/bin/open", args: [app_path]
  end

  uninstall quit: "org.myjdownloader.MyJDownloader"

  zap trash: [
    "~/Library/Application Scripts/org.myjdownloader.MyJDownloader",
    "~/Library/Application Scripts/org.myjdownloader.MyJDownloader.Extension",
    "~/Library/Containers/org.myjdownloader.MyJDownloader",
    "~/Library/Containers/org.myjdownloader.MyJDownloader.Extension",
  ]
end
