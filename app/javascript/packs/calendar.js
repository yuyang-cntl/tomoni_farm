import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list";
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('[id^="calendar-"]').forEach(function(calendarEl) {
    const itemId = calendarEl.id.split('-')[1];
    const startDate = calendarEl.dataset.startDate;
    const calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin, interactionPlugin],
      initialView: 'dayGridMonth',
      initialDate: startDate,
      locale: 'ja',
      events: `/items/${itemId}/calendar_events`,
      eventClick: function(info) {
        window.location.href = info.event.url;
      }
    });
    calendar.render();
  });
});