cask "microsoft-defender" do
  version "101.25042.0002"
  sha256 "4ef73140d0f38811a61237f70a2f43727a8182b374cb39d00ef6aea9238749aa"

  url "https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Defender_#{version}_Individuals_Installer.pkg"
  name "Microsoft Defender for Endpoint"
  desc "Antivirus software"
  homepage "https://www.microsoft.com/security/business/endpoint-security/microsoft-defender-endpoint"

  livecheck do
    url "https://aka.ms/MacDefender"
    strategy :extract_plist
  end

  auto_updates true
  depends_on cask: "microsoft-auto-update"
  depends_on macos: ">= :big_sur"

  pkg "Microsoft_Defender_#{version}_Individuals_Installer.pkg",
      choices: [
        {
          "choiceIdentifier" => "com.microsoft.package.Microsoft_AutoUpdate.app",
          "choiceAttribute"  => "selected",
          "attributeSetting" => 0,
        },
      ]

  postflight do
    system_command "/bin/bash",
                   args: ["-c", "~/Library/'Mobile Documents'/com~apple~CloudDocs/config/microsoft-defender/" \
                                "MicrosoftDefenderATPOnboardingMacOs.sh"], sudo: true
  end

  uninstall quit:    "com.microsoft.autoupdate2",
            script:  {
              executable: "/Library/Application Support/Microsoft/Defender/uninstall/uninstall",
              sudo:       true,
            },
            pkgutil: [
              "com.microsoft.dlp.agent",
              "com.microsoft.dlp.daemon",
              "com.microsoft.dlp.ux",
            ]

  zap trash: [
    "~/Library/Group Containers/*com.microsoft.wdav/MicrosoftDefender.sqlite*",
    "~/Library/Logs/Microsoft/Defender",
  ]
end
