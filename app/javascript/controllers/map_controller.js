import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async connect() {
    console.log("✅ map controller connected")

    const GOOGLE_MAPS_API_KEY = process.env.GOOGLE_MAPS_API_KEY;
    console.log("✅ Injected API Key:", GOOGLE_MAPS_API_KEY);

    const lat = parseFloat(this.element.dataset.lat)
    const lng = parseFloat(this.element.dataset.lng)

    // Google Maps API 非同期ローダ（DMM式）
    const loader = (g => {
      var h, a, k, p = "The Google Maps JavaScript API", c = "google", l = "importLibrary", q = "__ib__", m = document, b = window;
      b = b[c] || (b[c] = {});
      var d = b.maps || (b.maps = {}), r = new Set, e = new URLSearchParams, u = () => h || (h = new Promise(async (f, n) => {
        await (a = m.createElement("script"));
        e.set("libraries", [...r] + "");
        for (k in g) e.set(k.replace(/[A-Z]/g, t => "_" + t[0].toLowerCase()), g[k]);
        e.set("callback", c + ".maps." + q);
        a.src = `https://maps.${c}apis.com/maps/api/js?` + e;
        d[q] = f;
        a.onerror = () => h = n(Error(p + " could not load."));
        a.nonce = m.querySelector("script[nonce]")?.nonce || "";
        m.head.append(a);
      }));
      d[l] ? console.warn(p + " only loads once. Ignoring:", g) : d[l] = (f, ...n) => r.add(f) && u().then(() => d[l](f, ...n));
    })({
      key: GOOGLE_MAPS_API_KEY
    });

    await loader;

    const { Map } = await google.maps.importLibrary("maps");
    const {AdvancedMarkerElement} = await google.maps.importLibrary("marker")

    const map = new Map(this.element, {
      center: { lat: lat, lng: lng },
      zoom: 15,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false
    });
    try {
      const response = await fetch("/farmer/location.json");
      if (!response.ok) throw new Error('Network response was not ok');
  
      const { data: { farmers } } = await response.json();
      if (!Array.isArray(farmers)) throw new Error("Farmers is not an array");
  
      farmers.forEach( farmer => {
        const latitude = farmer.latitude;
        const longitude = farmer.longitude;
        const farmerName = farmer.name;
  
        const marker = new google.maps.marker.AdvancedMarkerElement ({
          position: { lat: latitude, lng: longitude },
          map,
          title: farmerName,
          // 他の任意のオプションもここに追加可能
        });
      });
    } catch (error) {
      console.error('Error fetching or processing locations:', error);
    }
  }
}

