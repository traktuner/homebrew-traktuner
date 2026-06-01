cask "urbackup-client" do
  version "2.5.30"
  sha256 "f99999633cd7ec5f0885e0f27c799cc9f39f9933d9c8931d106d3c05a5b8287a"

  url "https://hndl.urbackup.org/Client/#{version}/UrBackup%20Client%20#{version}.pkg"
  name "UrBackup Client"
  desc "Client for UrBackup network backup system"
  homepage "https://www.urbackup.org/"

  livecheck do
    url "https://hndl.urbackup.org/Client/"
    strategy :page_match do |page, url|
      versions = page.scan(%r{href="(\d+\.\d+\.\d+)/"}).flatten.map { |v| Gem::Version.new(v) }.sort.reverse
      
      versions.each do |version|
        version_str = version.to_s
        client_url = "https://hndl.urbackup.org/Client/#{version_str}/UrBackup%20Client%20#{version_str}.pkg"
        
        response = Utils::URI.send(:open, client_url, method: :head)
        return version_str if response.status[0] == "200"
      end
      
      nil
    end
  end

  depends_on macos: :big_sur

  pkg "UrBackup Client #{version}.pkg"

  postflight do
    system_command "/usr/bin/sudo", args: ["-u", "root", "touch", "/Library/Application Support/UrBackup Client/var/urbackup/.installed_by_brew"]
  end

  uninstall quit: "org.urbackup.client",
            script: {
              executable: "/Library/Application Support/UrBackup Client/uninstall.sh",
              sudo:       true,
            },
            pkgutil: "org.urbackup.client"

  zap trash: [
    "/Library/Application Support/UrBackup Client",
    "/Library/LaunchDaemons/org.urbackup.client.plist",
    "/Library/LaunchAgents/org.urbackup.client.plist",
    "~/Library/Application Support/UrBackup Client",
    "~/Library/Logs/UrBackup Client",
  ]
end
