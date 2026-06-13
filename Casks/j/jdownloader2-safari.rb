cask "jdownloader2-safari" do
  version "1.0.1"
  sha256 "3661123ba2a944cf34e83c7e587fe6b0b3b467bb1f55cac228e03d6821fe4614"

  # OCI blob in GitHub Packages (ghcr). Homebrew auto-detects the ghcr URL and
  # pulls it (anonymously for a public package). The digest == sha256 of the
  # zip; bump version + sha256 + the digest in the URL on each release (the CI
  # job summary prints all three).
  url "https://ghcr.io/v2/traktuner/jdownloader2-safari/blobs/sha256:3661123ba2a944cf34e83c7e587fe6b0b3b467bb1f55cac228e03d6821fe4614"
  name "MyJDownloader Safari Extension"
  desc "Personal Safari port of the MyJDownloader browser extension"
  homepage "https://github.com/traktuner/jdownloader2-safari-extension"

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
