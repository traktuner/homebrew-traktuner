cask "microsoft-defender" do
  version "101.24072.0006"
  sha256 "1c181a43a866428ad4ed2e7832b6b1175cc44fcf2273d2b7497a95976b89cd07"

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
