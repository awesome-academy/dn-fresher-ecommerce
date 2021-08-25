require("jquery")
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import toastr from "toastr"
window.toastr = toastr
import "../src/application.scss"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
