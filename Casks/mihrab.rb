cask "mihrab" do
  version "2.10.1"
  sha256 "442059ce2e1302c5f0cecaf3931a995733828b1b170e883567638fa780ec7940"

  url "https://github.com/Hassan-PS/Mihrab/releases/download/v#{version}/Mihrab-macOS-#{version}.zip"
  name "Mihrab"
  desc "Prayer times, Quran, and daily worship tools - private by design"
  homepage "https://github.com/Hassan-PS/Mihrab"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Mihrab.app"

  zap trash: [
    "~/Library/Containers/maccatalyst.com.hassan.prayerapp",
  ]

  caveats <<~EOS
    Mihrab for Mac is the same app as the iPad version, built with Mac
    Catalyst. If the release is not notarized yet, macOS may block the
    first launch - right-click Mihrab.app and choose Open once.
  EOS
end
