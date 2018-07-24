# README

Why a new document that's built through the `has_one` relationship won't show up in the `has_many` relationship unless it's saved? Is there a way to change this behavior?

```
Running via Spring preloader in process 8210
Loading development environment (Rails 5.2.0)

irb(main):001:0> u = User.first
  User Load (0.1ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<User id: 1, name: "bob", created_at: "2018-07-24 14:01:43", updated_at: "2018-07-24 14:01:43">

irb(main):002:0> u.proof_of_id
  Document::ProofOfId Load (0.1ms)  SELECT  "documents".* FROM "documents" WHERE "documents"."type" IN ('Document::ProofOfId') AND "documents"."user_id" = ? LIMIT ?  [["user_id", 1], ["LIMIT", 1]]
=> #<Document::ProofOfId id: nil, user_id: 1, type: "Document::ProofOfId", state: nil, created_at: nil, updated_at: nil>

irb(main):004:0> u.documents
  Document Load (0.2ms)  SELECT  "documents".* FROM "documents" WHERE "documents"."user_id" = ? LIMIT ?  [["user_id", 1], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy []>

irb(main):006:0> d = u.documents.new
=> #<Document id: nil, user_id: 1, type: nil, state: nil, created_at: nil, updated_at: nil>

irb(main):007:0> u.documents
  Document Load (0.4ms)  SELECT "documents".* FROM "documents" WHERE "documents"."user_id" = ?  [["user_id", 1]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Document id: nil, user_id: 1, type: nil, state: nil, created_at: nil, updated_at: nil>]>

irb(main):008:0> u.save
   (0.2ms)  begin transaction
  Document Create (0.3ms)  INSERT INTO "documents" ("user_id", "created_at", "updated_at") VALUES (?, ?, ?)  [["user_id", 1], ["created_at", "2018-07-24 14:07:42.292712"], ["updated_at", "2018-07-24 14:07:42.292712"]]
  Document::ProofOfId Create (0.1ms)  INSERT INTO "documents" ("user_id", "type", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["user_id", 1], ["type", "Document::ProofOfId"], ["created_at", "2018-07-24 14:07:42.293952"], ["updated_at", "2018-07-24 14:07:42.293952"]]
   (6.8ms)  commit transaction
=> true

irb(main):009:0> u.reload.documents
  User Load (0.5ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Document Load (0.3ms)  SELECT  "documents".* FROM "documents" WHERE "documents"."user_id" = ? LIMIT ?  [["user_id", 1], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Document id: 1, user_id: 1, type: nil, state: nil, created_at: "2018-07-24 14:07:42", updated_at: "2018-07-24 14:07:42">, #<Document::ProofOfId id: 2, user_id: 1, type: "Document::ProofOfId", state: nil, created_at: "2018-07-24 14:07:42", updated_at: "2018-07-24 14:07:42">]>

irb(main):010:0> u.reload.documents.count
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
   (0.4ms)  SELECT COUNT(*) FROM "documents" WHERE "documents"."user_id" = ?  [["user_id", 1]]
=> 2
```
