cask "mihrab" do
  version "2.13.0"
  sha256 "30aa6aa0265e0221897d47e569c0dc1cb00c3524eb4d46c11f4183961a032e76"

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
