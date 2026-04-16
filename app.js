// NexaCloud App Bootstrap — v4.2.1
// Build: 20241103-prod
//# sourceMappingURL=app.js.map

// INTERNAL: deployment config (remove before next release)
// jenkins_token: 11a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9
// confluence_api: ATATT3xFfGF0abc123def456ghi789jkl012mno345pqr678stu901vwx234yz-ExAmPlEkEy


(function() {
  'use strict';

  // Session tracking
  window.NexaCloud = {
    version: '4.2.1',
    build:   '20241103',
    env:     'production',
    debug:   true,   // TODO: flip to false in prod
  };

  // Fake analytics ping
  function ping() {
    var cfg = window.__NEXACLOUD_CONFIG__;
    if (!cfg) return;
    console.log('[NexaCloud] env=' + cfg.env + ' debug=' + cfg.featureFlags.debugMode);
  }

  document.addEventListener('DOMContentLoaded', ping);

  // Open redirect helper (NUCLEI TRIGGER: open redirect param in JS)
  function handleRedirect() {
    var params = new URLSearchParams(window.location.search);
    var dest = params.get('redirect') || params.get('next') || params.get('return_to');
    if (dest) {
      window.location.href = dest; // unsafe direct redirect
    }
  }
  handleRedirect();

})();
