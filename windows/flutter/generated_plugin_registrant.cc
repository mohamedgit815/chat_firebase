//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <connectivity_plus_windows/connectivity_plus_windows_plugin.h>
#include <desktop_webview_auth/desktop_webview_auth_plugin.h>
#include <network_info_plus_windows/network_info_plus_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  DesktopWebviewAuthPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("DesktopWebviewAuthPlugin"));
  NetworkInfoPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NetworkInfoPlusWindowsPlugin"));
}
