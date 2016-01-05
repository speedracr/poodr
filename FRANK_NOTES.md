# Questions and topics for weekly review

## DONE THIS WEEK
* more ticket work - hooray!
* little confusion
* Linux admin/ Wifi card installed
* tried out Slack, Imgur gems

## Heroku
Add-on pricing looks... interesting:

* Postgres: continuous protection starts at $50/month (cheaper: $9/
  month for expanded hobby DB without extended backup - would have to
  backup w/ handrolled Postgres.dump for up-to-the-minute backup)
* Hobby dyno (never sleeps): $7/ month; standard dyno: $25/month
* SSL encryption: $20/month plus certificate
* NewRelic standard: free, advanced: from $49/month

## QUESTIONS
* OAuth flow: built a little application, only slight issue was around
  callback URLs with Heroku. Then added user info storing and ran local
  server - would have expected Twitter to refuse the callback but it
  came back no worries to `localhost`, even though (functioning)
  callback URL in settings was for `heroku`. So how exactly does OAuth
  callback work???

* Performance diagnostics: How do I find out why Projects#index,
  Wave#create feel slow? New Relic shows many DB hits, but is that
  avoidable?

* Internal logging: Do we track how long QC samples take? Might be
  interesting to see all sampling jobs > 10min for example.

* How do I make the most out of my log file? Sure I can `tail -f
  sidekiq.log`, but if I'm interested in a certain JID or want to see if
  a particular worker caused errors over the weekend, what do I do then?

* Ruby-fu: I have an array of csv imported lines:
```
[PROD] (ec) [9] pry(main)> arr.first.split(";")
=> ["550", "103692", "560e8ab570d6897f50005be9", "GEN25", "\n"]
```

and I want to assign each of those values to the same attribute on a
Struct-based object:
```
[PROD] (ec) [7] pry(main)> class Record = Struct.new(:id, :serialno,
:part_id, :value, :zipcode)
[PROD] (ec) [7] pry(main)* end
```

Pretty sure there is a shorter way to iterate over the results of
`foo.split(";")` and put them into a `Record.new` than `r.id = bar[0]`
etc., right?

-------------

## Ruby mindf
How does this work from `/lib/append/core_ext/array/append.rb`:

``` ruby
class Array
  def sum_with_nils
    if self[0].is_a? Array
      map(&:sum_with_nils).sum_with_nils
    else
      reduce(0) { |a, e| a + (e || 0) }
    end
  end
# ....
end
```
(found via Coveralls)

We are calling... a method on itself, chained to a call to itself?
Turns out: We sort of are! The essential part here is the `else` loop
but in case we're passing a nested array to the function, the `if` part
will first jump in and reduce it down one step. If we're still at a
nested array, a second time etc., until we are left with a nice and
shiny unnested array that then gets the sum of its elements added to it.
(This function takes heavy inspiration from functional programming.)

## Strategic question
Looks to me like we increasingly duct-tape features to the duct-tape.
Yet, even though a JS-focused front-end (cf. WordPress Calypso) may
actually help us immensely, we wouldn't have the ability to pause
feature development for 2-4 months, would we? Is there input/ opinion on
this from the company leadership? Or does it just get pushed back on the
assumption that 'it'll work out when it'll work out'?
cf. LinkedIn CTO pausing feature development 6 months after the IPO to
"revamp" the architecture.

## Switching to `use_cases`
"Wir wollen guard clauses und hooks aus den AASM state changes
herausziehen und auch keine `active_record` before/ after actions mehr
nutzen."

> Wie erklärt sich das? Was sind Vor- und Nachteile?
Langsamkeiten:
* "teure" Jobs: Sidekiq-Queues
* massig Speichervorgänge

Lösungsansatz:
Mit `use_cases` die Arbeit aus den Klassen (hier: dem Model)
herausziehen. D.h. der Controller ruft nicht mehr `Model.save` auf,
sondern `ModelSaveWorker`/ `ModelValidator` / ... Dort wird zB der Input
validiert.

Das Projekt muss gar nicht wissen, dass es ins Data Warehouse geschoben
wird. Aber: Wenn ich einen entsprechenden `after` hook ins Model schreibe,
sind die beiden schon gekoppelt.
Ergebnis: Der Controller übernimmt die Kommunikation mit der Außenwelt,
das Model speichert am Ende; alles dazwischen ist in der
"Business-Logik" der Use-Cases. Dann denkt auch jedes Model nur noch
über sich selbst nach und steht für sich selbst.
(Das heißt zB auch, dass ein Projekt nicht selbst in der Lage sein
muss, seine Eigenschaften als CSV zu exportieren. Im Gegenteil: Wenn es
einen CSV-Export-Worker gibt, können den auch andere Models nutzen. Auch
wenn Rails an vielen Stellen anderes vorlebt: `Model.to_json`)

Und: Durch konsequentes Aufteilen kann ich auch die Test-Suite enorm
beschleunigen - wenn ich meine Code-Base fünfteile, teile ich auch die
Test-Laufzeit durch fünf. Das begünstigt wieder den Workflow, zB weil
ich für eine Änderung im Backoffice nicht mehr alle Stylesheets neu
kompilieren muss.

## Rspec explainer
Ich bin immer noch verwirrt: Was muss ich machen, wenn ich unit tests
schreiben will? Woher kommt `and_call_original`? Wann nutze ich
`double`? Ein Durchgang durch die verschiedenen Szenarien wäre super:
(1) Ich will einen Worker specen. Here is what to do: ...
(2) Ich will das Erstellen eines Nutzers specen. Here is what to do:
...

### Ergebnis
Starten mit integration test, mit Doppelungen für verschiedene Szenarien
ist immer eine valide Option. (Bei Controllern unabdingbar.)
Alles weitere - dbless oder nicht, context, before, ... - sind
Feinheiten und Optimierungen.

`and_call_original`: Wenn ich mit `let` bzw. `allow` zulasse, dass die
Methode eines Objekts gerufen wird, würde das Programm nach gültigem
Aufruf abbrechen. Falls ich aber weitere Schritte habe und/oder das
Ergebnis dieses Calls benötige, zieht mich `and_call_original` mit dem
Ergebnis weiter.

## shell
Wie öffne ich verschiedene "Tabs" in der Shell? (statt guake tabs)
vim registers: Worum geht's da? (ggf. selbst recherchieren)

## Die stumbling blocks
**Docker** und **rspec** sind die beiden Themen, bei denen ich den
Zusammenhang noch nicht verstanden habe - was sind meine Optionen, wie
gehe ich durch die einzelnen Schritte? (Ich will X testen, Ich will Y
testen, Ich will Z testen. >> Ich baue A, Ich baue B, Ich baue C)

## Notes on learning
Ich merke, dass eine Nachmittags-Einheit für den Flow schlecht ist -
oftmals war es in letzter Zeit so, dass ab ca. 15.30/16.00 alles etwas
ruhiger wurde und ich perfekt an den Tickets arbeiten konnte.
