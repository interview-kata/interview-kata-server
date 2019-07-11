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

```
rails g scaffold Issue number:integer title:text body:text labels:jsonb html_url:string state:string{20} locked:boolean comments_count:integer raw:jsonb
```

#### Comment

```
rails g scaffold Comment comment_id:integer issue:references html_url:text issue_url:text user:jsonb body:text
```