# README

## 本地开发服务配置

https://developer.github.com/webhooks/configuring/

./ngrok http 3000

## Configure

* [Create webhook](https://developer.github.com/webhooks/creating/)

* Copy `config/application.yml.example` to `config/application.yml`

## rails run

* bundle

* rails db:migrate

* rails s

## DDl

#### Issue

number  title  body  labels(jsonb)  html_url  state  locked  comments_count  raw(jsonb)

```
rails g scaffold Issue number:integer title:text body:text labels:jsonb html_url:string state:string{20} locked:boolean comments_count:integer raw:jsonb
```

#### Comment

comment_id issue:reference html_url  issue_url  user(jsonb)  body:text 

