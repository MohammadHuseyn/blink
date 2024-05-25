'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4df07821787a774c274c06b954deaabf",
"assets/AssetManifest.json": "657dff6afc5d95535096be33858e22ef",
"assets/assets/fonts/Shabnam.ttf": "7b18a4a8f65b3f5eac92df3c91fe4400",
"assets/FontManifest.json": "b33dd4996e4d4d6bf1e63fd05885aab4",
"assets/fonts/MaterialIcons-Regular.otf": "d58f97d2b3dcf5e286c11f241aa1f263",
"assets/images/account.png": "ea6d23dc06d40833350c5534ab1f840f",
"assets/images/addimage.png": "87093fabc2c2444d4ee8b2b094bc192c",
"assets/images/arayeshi.png": "bbb0f9fc747f94fdf9a0486bab6b791c",
"assets/images/bell.png": "baa5faad1dae2d89a0405f3f359d4eec",
"assets/images/blink.png": "8dcdac1b6cf4bfa93d93e1146cc201df",
"assets/images/boxing.png": "d76ba67ea4a775b1714c1ce2ac86c0d4",
"assets/images/cart.png": "17eed03646e94352004850402e88a379",
"assets/images/chat_background.png": "652414028421f8abb84e59db073f0bac",
"assets/images/commentratesent.png": "3e64668c653dcdc05cfcd0db91e0e181",
"assets/images/copy.png": "17768aff3989bdc739a3dc2d95f3611b",
"assets/images/cross.png": "50d2b399f14e5e18b88aeee658a7114d",
"assets/images/customer.png": "ede5c8a99e9228f62074b86d85e76ecd",
"assets/images/deliverd.png": "2532f8c3d14c4df4aa3be42d012a6f31",
"assets/images/delivery.png": "b1c4f7a41497ade82c10321cc74eedd0",
"assets/images/digital.png": "98ead4515b5f17d685b0d96fa300a3bf",
"assets/images/fast.png": "b657452fa0b8812c0efb281d3c2f2d0f",
"assets/images/graph.png": "441c722d9b390189a6b0f3490436e588",
"assets/images/home.png": "4b02b646fe186980573cffa58b7a7f32",
"assets/images/img.png": "e588b38a7a82bd9267152bf860ece77c",
"assets/images/key.png": "9af756b8716c9f589ad8c5b9cf48f6ed",
"assets/images/lebas.png": "e132351a6960723f24410c13a475e955",
"assets/images/location.png": "9d446f2898f4defd4bc4d2065a3f6dbf",
"assets/images/logo.png": "e283fa244db9a6fc6761683e44dbe3d2",
"assets/images/market.png": "ba60e758f5e835b6cd3e8dc2b10ebd19",
"assets/images/motorbike.png": "3cf6820580b3162b53774ac37147c48a",
"assets/images/notification.png": "0e745cf7d2f073407da360a37efb2677",
"assets/images/options.png": "5dfd6b87a2e4fab841d20104fb1bdcf3",
"assets/images/packing.png": "32e826f77d5d4f2b2a7156b567c21b58",
"assets/images/pencil.png": "2ab7a1586c3be6c1341db918f5bb9e69",
"assets/images/people.png": "24d884cc4763aadcbf5edeaeb26a7dd6",
"assets/images/pizza.png": "287f7cd86caceafb435212437f196ec7",
"assets/images/plus.png": "bcf7e295a0bb081b7c004c23bd9f0450",
"assets/images/product.png": "43eef6fe52e76400f48af5d3e731743d",
"assets/images/question.png": "bebca626b6122a2f1ee1e02c9a0a8c2e",
"assets/images/remove.png": "9645ee5bef5dfe97d02c2bc06f40b6d9",
"assets/images/search.png": "322688b42043c51e776063c03554e47b",
"assets/images/seller.png": "c40afb03addb15154b0ec79108ec69b6",
"assets/images/send-message.png": "5e5cbda507a2b4ffda1f0b0e404e97dc",
"assets/images/shop.png": "ad2d32ee12a550aa500c04bc625b96f0",
"assets/images/star.png": "c7624bda39cc768b8172a12dbd721d6c",
"assets/images/star_empty.png": "a97459805e849dd037ff9934112b3e6c",
"assets/images/store.png": "f67eadb1dbd0153cdee4671648c0bf5f",
"assets/images/tick.png": "564c48a93cf24f7fdc18facf6865c2c3",
"assets/images/trash.png": "89c21e8c04786eef5773d68eaab53937",
"assets/images/user.png": "cb65cd74af18c214072f934b59650d26",
"assets/images/user2.png": "b2cd5315fd90b688b21d09bc20a9affc",
"assets/NOTICES": "f537f00b11ea15aeaccccc621ecf178a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "8738a9a96572faa5dbfe9e70ba411bd5",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "a1fcf72eef13b3c6a19917e2c9d8c640",
"icons/Icon-512.png": "0e8b8b5a93da2e62255f38c246d1f79b",
"icons/Icon-maskable-192.png": "a1fcf72eef13b3c6a19917e2c9d8c640",
"icons/Icon-maskable-512.png": "0e8b8b5a93da2e62255f38c246d1f79b",
"index.html": "e96083ce9d1e54d605f6e85bea7bcc28",
"/": "e96083ce9d1e54d605f6e85bea7bcc28",
"main.dart.js": "a4587871b66262b976e199299615c924",
"manifest.json": "d918c6306482480837f906f7da97cd8b",
"splash/img/dark-1x.png": "9f3a1291c5412da74bf57e211d3072a6",
"splash/img/dark-2x.png": "2d9ffa53ccc1eb2f3b4395e4405dd104",
"splash/img/dark-3x.png": "80de8142b6c39e930a886e4a3a926caf",
"splash/img/dark-4x.png": "0e8b8b5a93da2e62255f38c246d1f79b",
"splash/img/light-1x.png": "9f3a1291c5412da74bf57e211d3072a6",
"splash/img/light-2x.png": "2d9ffa53ccc1eb2f3b4395e4405dd104",
"splash/img/light-3x.png": "80de8142b6c39e930a886e4a3a926caf",
"splash/img/light-4x.png": "0e8b8b5a93da2e62255f38c246d1f79b",
"version.json": "0bd8923bfd1f9ee0695a03e7aea93996"};
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
