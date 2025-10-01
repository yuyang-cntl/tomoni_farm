import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async connect() {
    console.log("✅ map controller connected")

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
      key: process.env.Maps_API_Key // ここは Webpacker環境変数で注入する必要あり
    });

    await loader;

    const { Map } = await google.maps.importLibrary("maps");

    const map = new Map(this.element, {
      center: { lat: lat, lng: lng },
      zoom: 15,
      mapTypeControl: false
    });
  }
}
