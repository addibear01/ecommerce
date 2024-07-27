import "app/assets/stylesheets/application.tailwind.css"; // Adjusted path to match the directory structure
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
