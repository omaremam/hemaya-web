'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".idea/workspace.xml": "cc5f609be0f96835c87839f62217d14b",
".idea/modules.xml": "15f82c74d58a12c3aff959b78d483f13",
".idea/libraries/KotlinJavaRuntime.xml": "4b0df607078b06360237b0a81046129d",
".idea/libraries/Dart_SDK.xml": "b00d912c3b60957bdcce37710807c4b9",
".idea/runConfigurations/main_dart.xml": "2b82ac5d547e7256de51268edfd10dc3",
"hemaya_860b8.iml": "731a1a3080009db8d4572ef3fb1679c3",
".dart_tool/package_config.json": "8e57e40405c488c19f68bc252bff89a8",
".dart_tool/version": "66db5d5fb15776e263f6846edf466daa",
".dart_tool/package_config_subset": "934d92af91d8723a4e17424708c746d5",
".dart_tool/dartpad/web_plugin_registrant.dart": "7ed35bc85b7658d113371ffc24d07117",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/gen_localizations.stamp": "436d2f2faeb7041740ee3f49a985d62a",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/web_static_assets.stamp": "3dceac1dd2d9418c26fbb1f1bc2290d4",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/web_plugin_registrant.dart": "7ed35bc85b7658d113371ffc24d07117",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/main.dart": "ff0523aaf0a94c1ae436890884a776cb",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/web_entrypoint.stamp": "fc07f5fe448f17b152e50e5295dd197b",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/app.dill": "f0bcb45400c940c9da8ac29e89965bd9",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/app.dill.deps": "36506c2c2226fdd87c63c24381cb64e9",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/main.dart.js": "90c3b84c4cd67683e3160dcf9f841c5a",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/main.dart.js.deps": "6b668342fedac3a8477c9b46c39e5266",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/dart2js.d": "962d289fa01e885ea24c52e717b1879b",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/dart2js.stamp": "3bab46d715060ddd44e8438dc5d6bd53",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/flutter_assets.d": "63ad9a56c3198efe2f6003ec407781e5",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/web_resources.d": "b65abbafffcf6473c71f6c895f2b4f8a",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/web_release_bundle.stamp": "1a4c07c94cebe8c0f1e2284d07a1da16",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/service_worker.d": "31910dcb4170727d40c2d38ec97d61e8",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/web_service_worker.stamp": "064485f152185fc07151b163e35589a2",
".dart_tool/flutter_build/119c16d2d274e8b2ad2868f903ccc732/outputs.json": "b7167dce85dd9dfb64b2f82e7fda8171",
"build/web/canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"build/web/canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"build/web/canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"build/web/canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"build/web/canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"build/web/canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"build/web/canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"build/web/flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"build/web/main.dart.js": "90c3b84c4cd67683e3160dcf9f841c5a",
"build/web/version.json": "c62b3fd2567ad4e93c134cef2de6af08",
"build/web/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"build/web/assets/fonts/MaterialIcons-Regular.otf": "52fc34a70b225832e47b13c384bc9b3e",
"build/web/assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"build/web/assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"build/web/assets/AssetManifest.smcbin": "a3d922a0b0bb96200631d1d9f758ce7d",
"build/web/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"build/web/assets/NOTICES": "65927a9256022709295bd07d61a17fc5",
"build/web/index.html": "021d104284ac45e3bedc305b86b3ef61",
"/": "86d140195f7b14e08b8fd05d86a38221",
"build/web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"build/web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"build/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"build/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"build/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"build/web/manifest.json": "a336d4e501fab01f0fc6c74e502187c9",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"version.json": "afe511108fe7bba62f56fe72e9c19ed7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/fonts/MaterialIcons-Regular.otf": "9729aa24d39d63e71a28970f5d8d36fa",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/AssetManifest.smcbin": "a3d922a0b0bb96200631d1d9f758ce7d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/NOTICES": "76d72c6150befb9d3997f9c36cd3c4a0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"manifest.json": "78c213ea90c15c6d88c700a1dfdeda26",
"index.html": "86d140195f7b14e08b8fd05d86a38221",
"main.dart.js": "9bf417afc2abff2ff25ac092455e3f69"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
