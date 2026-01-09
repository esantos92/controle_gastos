import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    type: String,
    data: Object,
    options: Object
  }

  connect() {
    const { Chart } = window
    if (!Chart) return

    const ctx = this.element.getContext("2d")
    if (!ctx) return

    this.chart = new Chart(ctx, {
      type: this.typeValue || "bar",
      data: this.dataValue || {},
      options: this.optionsValue || {}
    })
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }
}
