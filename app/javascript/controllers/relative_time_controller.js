import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    timestamp: String
  }

  connect() {
    this.render()
    this.startRefreshing()
  }

  disconnect() {
    if (this.interval) clearInterval(this.interval)
  }

  startRefreshing() {
    this.interval = setInterval(() => this.render(), 30000)
  }

  render() {
    if (!this.hasTimestampValue) return

    const timestamp = new Date(this.timestampValue)
    if (Number.isNaN(timestamp.getTime())) return

    this.element.textContent = this.relativeTimeLabel(timestamp)
  }

  relativeTimeLabel(timestamp) {
    const seconds = Math.floor((Date.now() - timestamp.getTime()) / 1000)

    if (seconds < 60) return "less than a minute ago"

    const minutes = Math.floor(seconds / 60)
    if (minutes < 60) {
      return `${minutes} minute${minutes === 1 ? "" : "s"} ago`
    }

    const hours = Math.floor(minutes / 60)
    if (hours < 24) {
      return `${hours} hour${hours === 1 ? "" : "s"} ago`
    }

    const days = Math.floor(hours / 24)
    if (days < 30) {
      return `${days} day${days === 1 ? "" : "s"} ago`
    }

    const months = Math.floor(days / 30)
    if (months < 12) {
      return `${months} month${months === 1 ? "" : "s"} ago`
    }

    const years = Math.floor(months / 12)
    return `${years} year${years === 1 ? "" : "s"} ago`
  }
}
