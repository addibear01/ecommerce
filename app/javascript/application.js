// app/javascript/packs/application.js

import 'bootstrap/dist/css/bootstrap';
import 'bootstrap';
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "stylesheets/application"; // Assuming you have a folder structure under app/javascript/stylesheets/application.css
