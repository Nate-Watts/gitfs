ping1800:
  schedule.present:
    - function: test.ping
    - seconds: 1800
    - splay: 10

ping15:
  schedule.present:
    - function: test.ping
    - seconds: 15
    - splay:
        start: 10
        end: 20

pingweekdays:
  schedule.present:
    - function: state.sls
    - job_args:
      - httpd
    - job_kwargs:
        test: True
    - when:
        - Monday 5:00pm
        - Tuesday 3:00pm
        - Wednesday 5:00pm
        - Thursday 3:00pm
        - Friday 5:00pm

statecron:
  schedule.present:
    - function: state.sls
    - job_args:
      - httpd
    - job_kwargs:
        test: True
    - cron: '*/5 * * * *'

stateweekdays:
  schedule.present:
    - function: state.sls
    - job_args:
      - httpd
    - job_kwargs:
        test: True
    - when:
        - Monday 5:00pm
        - Tuesday 3:00pm
        - Wednesday 5:00pm
        - Thursday 3:00pm
        - Friday 5:00pm
    - returner: xmpp
    - return_config: xmpp_state_run
    - return_kwargs:
        recipient: user@domain.com

stateskiprange:
  schedule.present:
    - function: state.sls
    - job_args:
      - httpd
    - job_kwargs:
        test: True
    - hours: 1
    - skip_during_range:
        - start: 2pm
        - end: 3pm
    - run_after_skip_range: True
