$(function(){
  function buildHTML(message){
    if (message.image){
      let html = `<div class="main-chat__message__box" data-message-id=${message.id}>
                    <div class="main-chat__message__box__info">
                      <div class="main-chat__message__box__info__username">
                        ${message.user_name}
                      </div>
                      <div class="main-chat__message__box__info__date">
                        ${message.created_at}
                      </div>
                    </div>
                    <div class="main-chat__message__box__body">
                      <p class="Message__body">
                        ${message.body}
                      </p>
                      <img class="Message__image" src="${message.image}">
                    </div>
                  </div>`
      return html;
    } else {
      let html =`<div class="main-chat__message__box" data-message-id=${message.id}>
                  <div class="main-chat__message__box__info">
                    <div class="main-chat__message__box__info__username">
                      ${message.user_name}
                    </div>
                    <div class="main-chat__message__box__info__date">
                      ${message.created_at}
                    </div>
                  </div>
                  <div class="main-chat__message__box__body">
                    <p class="Message__body">
                      ${message.body}
                    </p>
                  </div>
                  </div>`
      return html;
    };
  }

  $('.Form').on('submit', function(e){
    e.preventDefault()
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.main-chat__message').append(html);
      $('form')[0].reset();
      $('.main-chat__message').animate({ scrollTop: $('.main-chat__message')[0].scrollHeight});
      $('.main-chat__footer__form--submit').prop('disabled', false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    });
  });
});
