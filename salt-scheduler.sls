job3:
  schedule.present:
    - function: test.ping
    - seconds: 1800
    - splay: 10

#This will schedule the command: test.ping every 1800 seconds
#(every half hour) splaying the time between 0 and 10 seconds

job2:
  schedule.present:
    - function: test.ping
    - seconds: 15
    - splay:
        start: 10
        end: 20

#This will schedule the command: test.ping every 15 seconds
#splaying the time between 10 and 20 seconds

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

#This will schedule the command: state.sls httpd test=True at 5pm on Monday,
#Wednesday and Friday, and 3pm on Tuesday and Thursday.  Requires that
#python-dateutil is installed on the minion.

job1:
  schedule.present:
    - function: state.sls
    - job_args:
      - httpd
    - job_kwargs:
        test: True
    - cron: '*/5 * * * *'

#Scheduled jobs can also be specified using the format used by cron.  This will
#schedule the command: state.sls httpd test=True to run every 5 minutes.  Requires
#that python-croniter is installed on the minion.

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

#This will schedule the command: state.sls httpd test=True at 5pm on Monday,
#Wednesday and Friday, and 3pm on Tuesday and Thursday.  Using the xmpp returner
#to return the results of the scheduled job, with the alternative configuration
#options found in the xmpp_state_run section.

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

#This will schedule the command: state.sls httpd test=True at 5pm on Monday,
#Wednesday and Friday, and 3pm on Tuesday and Thursday.  Requires that
#python-dateutil is installed on the minion.
