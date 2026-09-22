---
img: /uploads/indoor-learning.jpg
title: 联系我们
tags:
  - 联系我们
  - 咨询
date: 2026-07-18 09:00:00
layout: contact
toc: false
class: sunny-page
---

<div class="contact-info-grid">
<div class="contact-info-copy">
<p class="contact-intro">欢迎对拾光中文学校感兴趣的家庭与我们联系。</p>
<div class="contact-detail-block">
<h3>地点</h3>
<p>17251 Great Oaks Dr Unit C<br>Round Rock, TX 78681</p>
</div>
<div class="contact-detail-block">
<h3>Office Hours</h3>
<p>Monday - Friday<br>具体课后托管时间将围绕放学接送到傍晚安排。</p>
</div>
<div class="contact-detail-block">
<h3>邮箱</h3>
<p><a href="mailto:glimmergroveacademy@gmail.com">glimmergroveacademy@gmail.com</a></p>
</div>
<div class="contact-detail-block">
<h3>电话</h3>
<p><a href="tel:15122005002">512-200-5002</a></p>
</div>
<div class="contact-detail-block">
<h3>微信</h3>
<p>shenshiqian</p>
</div>
</div>
<div class="contact-map" aria-label="拾光中文学校地图">
<iframe title="拾光中文学校 Google Map" src="https://www.google.com/maps?q=17251%20Great%20Oaks%20Drive%2C%20Round%20Rock%2C%20TX%2078681&output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
</div>
</div>

<div class="inquiry-panel">
  <h3>招生咨询</h3>
  <p>请留下你的联系方式和想了解的内容。点击 Submit 后，信息会直接记录到我们的 Google Sheet，方便我们尽快回复。</p>
  <form class="inquiry-form" data-inquiry-form data-endpoint="https://script.google.com/macros/s/AKfycbw_gSWcXP0IYhYZke5Q2KysZAVbcoSR3v33q-vHp1apM8rHbDYhcRi8tDIH2OJnTwSG/exec" data-subject="拾光中文学校招生咨询" data-source="中文联系我们页面">
    <label>
      <span>Name</span>
      <input type="text" name="name" autocomplete="name" required>
    </label>
    <label>
      <span>Email Address</span>
      <input type="email" name="email" autocomplete="email" required>
    </label>
    <label>
      <span>Phone</span>
      <input type="tel" name="phone" autocomplete="tel">
    </label>
    <label class="inquiry-full">
      <span>How can we help?</span>
      <textarea name="message" rows="6" placeholder="请告诉我们孩子的年级、学校、中文背景、接送需求，以及你想了解的问题。" required></textarea>
    </label>
    <button type="submit" class="waves-effect waves-light btn sunny-primary">Submit</button>
    <p class="inquiry-status" data-inquiry-status aria-live="polite"></p>
  </form>
</div>

<script>
(function () {
  function field(form, name) {
    return (form.elements[name] && form.elements[name].value || '').trim();
  }

  function setStatus(form, message, kind) {
    var status = form.querySelector('[data-inquiry-status]');
    if (!status) return;
    status.textContent = message;
    status.className = 'inquiry-status' + (kind ? ' ' + kind : '');
  }

  document.querySelectorAll('[data-inquiry-form]').forEach(function (form) {
    if (form.dataset.bound === '1') return;
    form.dataset.bound = '1';

    form.addEventListener('submit', function (event) {
      event.preventDefault();
      var endpoint = form.dataset.endpoint;
      var button = form.querySelector('button[type="submit"]');
      var payload = {
        name: field(form, 'name'),
        email: field(form, 'email'),
        phone: field(form, 'phone'),
        message: field(form, 'message'),
        subject: form.dataset.subject || 'Website inquiry',
        source: form.dataset.source || window.location.href,
        page: window.location.href
      };

      if (!endpoint) {
        setStatus(form, '提交暂时没有成功，请稍后再试，或直接邮件联系 glimmergroveacademy@gmail.com。', 'error');
        return;
      }

      if (button) button.disabled = true;
      setStatus(form, '提交中...', '');

      fetch(endpoint, {
        method: 'POST',
        mode: 'no-cors',
        headers: { 'Content-Type': 'text/plain;charset=utf-8' },
        body: JSON.stringify(payload)
      }).then(function () {
        form.reset();
        setStatus(form, '已提交成功，谢谢！我们会尽快联系你。', 'success');
      }).catch(function () {
        setStatus(form, '提交暂时没有成功，请稍后再试，或直接邮件联系 glimmergroveacademy@gmail.com。', 'error');
      }).finally(function () {
        if (button) button.disabled = false;
      });
    });
  });
})();
</script>
