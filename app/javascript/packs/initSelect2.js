import $ from 'jquery';
import 'select2';

const dataset = ["ice", 'lime', 'blah']

const initSelect2 = () => {
  $('.select2').select2({ data: dataset }); // (~ document.querySelectorAll)
};

export { initSelect2 };
