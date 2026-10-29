# package

Package manager notes and small install scripts for Windows, Unix-like systems,
Android tooling, and cross-platform runtime managers.

## Layout

| Path | Purpose |
| --- | --- |
| `windows/` | Windows package managers and developer tooling. |
| `unix/` | Unix/Linux package manager notes. |
| `android/` | Android app and platform-tool resource links. |
| `wsa/` | Windows Subsystem for Android resource links. |
| `cross/` | Cross-platform runtime managers such as SDKMAN and mise. |

## Usage

Review a script before running it, then execute the relevant file from the
repository root:

```bash
bash cross/sdkman.sh
bash cross/mise/mise.sh
bash cross/mise/list.sh
bash unix/brew/brew.sh
```

PowerShell scripts are under `windows/develop/`:

```powershell
.\windows\develop\erlang.ps1
.\windows\develop\haskell.ps1
.\windows\develop\ada.ps1
```

Some scripts install software directly. Others print curated links where the
installer is better handled manually.

## Package Managers

| Manager | Platform | Notes |
| --- | --- | --- |
| `winget` | Windows | Built-in Windows package manager on modern Windows. |
| `choco` | Windows | Community package manager for Windows. |
| `brew` | macOS/Linux | Homebrew package manager. |
| `apt` | Debian/Ubuntu | Debian family package manager. |
| `dnf`/`yum` | Fedora/RHEL/CentOS | Red Hat family package managers. |
| `apk` | Alpine Linux | Alpine package manager. |
| `sdkman` | Cross-platform | SDK manager for JVM ecosystem tools. |
| `mise` | Cross-platform | Runtime/tool version manager. |
| `pip` | Python | Python package manager. |
| `composer` | PHP | PHP package manager. |
| `maven`/`gradle` | Java/JVM | Build and dependency tools. |
| `rubygems` | Ruby | Ruby package manager. |
| `nuget` | .NET | .NET package manager. |
| `npm` | JavaScript | Node.js package manager. |
| `cargo` | Rust | Rust package manager. |
| `vcpkg` | C/C++ | C/C++ dependency manager. |

