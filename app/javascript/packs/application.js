// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("bootstrap")
require("trix")
require("@rails/actiontext")
require("controllers")

import "../stylesheets/application";
import "@fortawesome/fontawesome-free/css/all"
import "@fortawesome/fontawesome-free/js/all"
require("selectize")

console.log('Hello World from Webpacker')

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /.js$/)
application.load(definitionsFromContext(context))

document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    });

    if ($('.selectize')){
      $('.selectize').selectize({
          sortField: 'text'
      });
    }

  $(".selectize-tags").selectize({
    create: function(input, callback) {
      $.post('/tags.json', { tag: { name: input } })
        .done(function(response){
          console.log(response)
          callback({value: response.id, text: response.name });
        })
    }
  });
})
