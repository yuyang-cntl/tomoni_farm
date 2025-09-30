import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const lat = parseFloat(this.element.dataset.lat)
    const lng = parseFloat(this.element.dataset.lng)

    const map = new google.maps.Map(this.element, {
      zoom: 14,
      center: { lat, lng },
    })

    new google.maps.Marker({
      position: { lat, lng },
      map: map,
    })
  }
}
