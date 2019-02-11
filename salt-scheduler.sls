job3:
  schedule.present:
    - function: test.ping
    - seconds: 1800
    - splay: 10

job2:
  schedule.present:
    - function: test.ping
    - seconds: 15
    - splay:
        start: 10
        end: 20

job1:
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

job1:
  schedule.present:
    - function: state.sls
    - job_args:
      - httpd
    - job_kwargs:
        test: True
    - cron: '*/5 * * * *'

job1:
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

job1:
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
