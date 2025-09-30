document.addEventListener("DOMContentLoaded", function () {
  const mapDiv = document.getElementById("map");
  if (!mapDiv) return;

  const lat = parseFloat(mapDiv.dataset.lat);
  const lng = parseFloat(mapDiv.dataset.lng);

  const map = new google.maps.Map(mapDiv, {
    zoom: 14,
    center: { lat, lng },
  });

  new google.maps.Marker({
    position: { lat, lng },
    map: map,
  });
});
