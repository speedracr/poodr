# Architecture

## "Monolithic microservices"
Idea: Hand-over data from one pseudo-microservice to another via Sidekiq
Requirement: Only works if User and Project model don't get mixed up, so
first, we need to do all the querying via Participation (User domain):

``` ruby
def calculated_csv_fields(participation)
  survey_url = RoutingCreator.
  new(participation,
      project.forwardable_parameter_set).survey_url
  [participation.transaction_amount.cents, survey_url].join(';')
  end
```

This will add the (Project domain) `survey_url` to our
`Participation`-based CSV creation: we hit the `RoutingCreator` with our
participation and get the `survey_url` in return.

Now to pass over the generated CSV to the project, we use Sidekiq as an
"internal API": the first Sidekiq worker generates the CSV data, then
the next worker takes the result and pushes it into the project:

``` ruby
class ProjectDataToCsvWorker
  include Sidekiq::Worker

  def perform(project_id)
    csv_string = ParticipationsCsvBuilder.new(project_id).build_csv_string
    ParticipationsCsvDataToProjectWorker.perform_async(project_id, csv_string)
  end
end
```

``` ruby
class ParticipationsCsvDataToProjectWorker
  include Sidekiq::Worker
  def perform(project_id, csv_string)
    project = Project.find(project_id)

    tmp_file = GapfishStringIO.new(csv_string)
    tmp_file.original_filename = "#{project.internal_name}.csv"
    project.participations_export_file = tmp_file

    project.save!
  end
end
```
