// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:load", () => {
  // Bootstrap の dropdown を再初期化
  const dropdownTriggerList = [].slice.call(document.querySelectorAll('.dropdown-toggle'))
  dropdownTriggerList.map(function (dropdownToggleEl) {
    return new bootstrap.Dropdown(dropdownToggleEl)
  })
})