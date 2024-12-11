import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  async loadMore() {
    const response = await fetch(this.urlValue, { headers: { "Accept": "application/json" } })
    if (!response.ok) return

    const data = await response.json()

    // Append the new posts to the container
    const postsContainer = document.getElementById("posts-container")
    postsContainer.insertAdjacentHTML('beforeend', data.html)

    const loadMoreContainer = document.querySelector('.load-more-container')
    if (loadMoreContainer) {
      postsContainer.appendChild(loadMoreContainer)
    }
    // If there are more posts, update the URL for the next request.
    // If not, remove the button.
    if (data.has_more) {
      const currentUrl = new URL(this.urlValue, window.location.origin)
      const currentPage = currentUrl.searchParams.get("page") || 1
      currentUrl.searchParams.set("page", Number(currentPage) + 1)
      this.urlValue = currentUrl.toString()

    } else {
      loadMoreContainer.remove() // no more posts, remove the load-more button element
    }
  }
}
