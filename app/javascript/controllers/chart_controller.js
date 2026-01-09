import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

export default class extends Controller {
  static values = {
    type: String,
    data: Object,
    options: Object
  }

  connect() {
    const ctx = this.element.getContext("2d")
    if (!ctx) return

    Chart.register(...registerables)
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
