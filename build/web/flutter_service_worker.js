'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "41d509806a003c7cb222f74614c61721",
"assets/assets/bgImage.jpg": "7df2916833ad9e1ebc289a84ce059f60",
"assets/assets/bgImage2.jpg": "14852bd0fce87ad1762c860d385b82a2",
"assets/assets/logo.png": "baf5e16f237ff537b92816da8a9f433d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "14000128ac76ccc2f4908819530d3190",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttertoast/assets/toastify.css": "8beb4c67569fb90146861e66d94163d7",
"assets/packages/fluttertoast/assets/toastify.js": "8f5ac78dd0b9b5c9959ea1ade77f68ae",
"browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"favicon-16x16.png": "0c710b8c54ad9bcb74eac4f30461948a",
"favicon-32x32.png": "ba5b41e78a225641377cd742c6af903d",
"favicon-96x96.png": "c92e7f1ff436bd850c1480cb93ee6468",
"favicon.ico": "63a2ea1d66495d9080eac79a3c5f0782",
"icons/android-icon-144x144.png": "1d33a3de927c686778f43beedece1196",
"icons/android-icon-192x192.png": "f62c59d86cf9c831e748b4ebccc37c17",
"icons/android-icon-36x36.png": "2672dc099ed1b000047d9c8fc11e6ca1",
"icons/android-icon-48x48.png": "479fb408a21b43e238e80e5afd429618",
"icons/android-icon-72x72.png": "2fa80be4a4b6b926f4dbe4b8e85d7884",
"icons/android-icon-96x96.png": "c92e7f1ff436bd850c1480cb93ee6468",
"icons/apple-icon-114x114.png": "9cc1f46fbcd9e7e2e084c795b7e3b024",
"icons/apple-icon-120x120.png": "342ab369d9b21dbc38cbd8271d40b656",
"icons/apple-icon-144x144.png": "1d33a3de927c686778f43beedece1196",
"icons/apple-icon-152x152.png": "a09a3f2c2c5bd5b9c3bb6d15e16b5c2a",
"icons/apple-icon-180x180.png": "23cb177bc95ad5017f815ed9fcffd539",
"icons/apple-icon-57x57.png": "100bfbb5bc6acd2dc46269ff16c8c672",
"icons/apple-icon-60x60.png": "3a5e5a413de246c1c62fb9918528266b",
"icons/apple-icon-72x72.png": "2fa80be4a4b6b926f4dbe4b8e85d7884",
"icons/apple-icon-76x76.png": "79cd97a61397b0e77c5972d46025a2c5",
"icons/apple-icon-precomposed.png": "418650319948acd023f633e7485af972",
"icons/apple-icon.png": "418650319948acd023f633e7485af972",
"icons/favicon.ico": "63a2ea1d66495d9080eac79a3c5f0782",
"icons/ms-icon-144x144.png": "1d33a3de927c686778f43beedece1196",
"icons/ms-icon-150x150.png": "34aa954f1a26fa31c300287aab0d63a8",
"icons/ms-icon-310x310.png": "9fc50c5e79930f4f9ba6162efc6bc2b0",
"icons/ms-icon-70x70.png": "33d6b9d5925f99e41229b64e8a806a8b",
"index.html": "2bbff25e8e50167002747d1be134a882",
"/": "2bbff25e8e50167002747d1be134a882",
"main.dart.js": "d99eaed8f6ed7f59e28e47b91368376c",
"manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"styles.css": "7d9191e0c13de3d4ad5af8cd69587be5",
"version.json": "be06d6cfb7a94b43540d3d40c4304c25"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
