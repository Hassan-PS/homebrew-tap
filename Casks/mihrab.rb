cask "mihrab" do
  version "2.13.3"
  sha256 "60bf1a31a1fc347734515dde156a65054d59ad91ecfc5c00f724fc790b4084cb"

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

  # Restart the widget daemon after the app is replaced.
  #
  # WidgetKit archives each widget's timeline AND its gallery preview to
  # disk, and chronod validates those archives against the bundle they were
  # produced by. Replacing the app in place invalidates that check: every
  # reload then fails with
  #
  #   bundleStubNotSupported("Bundle version did not match;
  #                           LaunchServices DB may need to be rebuilt")
  #
  # and it does not recover — retries were observed being pushed out an
  # hour, then a full day, while every card kept drawing the last archive
  # that validated. Measured on 2026-08-28: widgets and previews frozen at
  # the moment of the previous upgrade, still frozen a day later.
  #
  # `lsregister -f -R` was tried and does NOT clear it, despite what the
  # message suggests. Restarting chronod does, immediately. It is a per-user
  # launchd agent, comes straight back, and the only visible effect is the
  # widgets redrawing — which is the point.
  postflight do
    system_command "/usr/bin/killall",
                   args: ["chronod"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Containers/maccatalyst.com.hassan.prayerapp",
  ]

  caveats <<~EOS
    Mihrab for Mac is the same app as the iPad version, built with Mac
    Catalyst. If the release is not notarized yet, macOS may block the
    first launch - right-click Mihrab.app and choose Open once.
  EOS
end
