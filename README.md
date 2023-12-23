# こんにちは

before starting services with this repository, you must setup these points.

- create .env file
  ```
  cp srcs/.env.template srcs/.env
  ```
  and you can change value if you want like password, login name.
- config Name Resolution in your os
  ```
  echo "127.0.0.1 kakiba.42.fr" >> /etc/hosts
  ```

if you finish setup, **You can ```make all``` !**

when services started, open your browser, then
```
https://kakiba.42.fr:2525
```
you can access (if you change OPEN_PORT in .env, fill in with your value as port.)

> 求めなさい。そうすれば与えられます。探しなさい 。そうすれば見つかります。叩きなさい。そうすれば開かれます
