# Job
A Job creates one or more pods and ensures they run to completion successfully. It tracks completion status and manages retries for failed pods. Jobs are designed for finite work that should run to completion, unlike other controllers that maintain continuously running pods. They can be configured to run pods in parallel or sequentially, and automatically clean up completed pods based on specified policies.

- A pod which runs to completion and exits

- Useful for running jobs/tasks

- Supports cron style scheduling

- Also supports parallel, sequential and combinations - so you can run workflows almost!