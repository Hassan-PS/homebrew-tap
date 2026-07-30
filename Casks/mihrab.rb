cask "mihrab" do
  version "2.7.43"
  sha256 "76a27c7b4419e0a1e5794d5bb586d0c77505ef825260d6c3f31842c825b0b77b"

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
