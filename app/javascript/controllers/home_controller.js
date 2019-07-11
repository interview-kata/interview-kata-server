import { Controller } from "stimulus";
import qs from 'qs';
import hljs from 'highlight.js';
import 'highlight.js/styles/github.css';

export default class extends Controller {

  connect() {
    console.log('home connect');

    const search = location.search.slice(1);
    const q = qs.parse(search);

    $.ajax({
      type: 'get',
      dataType: 'json',
      url: `/issues`,
      data: {
        a: ''
      },
      success: (result) => {
        this.renderList();
      }
    });

    // this.createMarkDown();
  }

  createMarkDown() {
    $("pre code").prettyPre();
    hljs && hljs.initHighlightingOnLoad();
  }

  renderList() {

  }

  disconnect() {
    console.log('home disconnect');
  }
}
