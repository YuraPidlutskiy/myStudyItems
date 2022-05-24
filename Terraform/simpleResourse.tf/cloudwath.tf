resource "aws_cloudwatch_metric_alarm" "webserver_cpu" {
    alarm_name = "WEB-CPUUtilization"
    alarm_description = "the metcric monitor web server CPU"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"           # кожні 120 с робити датапоінт
    evaluation_periods = "5" # пять разів робити по одному датапоінт
    datapoints_to_alarm = "3" # якщо 3 з 5 датапоінт поза трешхолд тоді статус алярм
    statistic = "avarage"
    threshold = "80"
    ok_actions = [aws_sns_topic.alarm_resolved.arn]
    alarm_actions = [aws_sns_topic.alarm_created.arn]
    insufficient_data_actions = [aws_sns_topic_issue.arn]
    dimensions = {
      "Id" = "target"
    }
  
}