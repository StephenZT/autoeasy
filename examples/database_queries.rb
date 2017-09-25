# encoding=utf-8
require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"

G_ConfigHelper.conifg_enironment(["QA4"])
G_ConfigHelper.config_databases("QA4","default",{:dataserver=>'servername',:database=>'dbname'})
G_ConfigHelper.config_current_stage("QA4","desktop","chrome","Windows","Error")

customerQuery = "SELECT top 10 A.* FROM Customer A WITH (NOLOCK) order BY A.CreateDate desc"

G_QueryRegister.registerQuery('q_customer',customerQuery)
G_DBHelper.query_default_db('my_cus','q_customer')

#result2 = G_DBHelper.action('my_cus').get_first_row
#puts result2

#result3 = G_DBHelper.action('my_cus').get_rows_meet_condition({"CustomerKey"=>8838753})
#puts result3

#result4 = G_DBHelper.action('my_cus').get_rows_not_meet_condition({"CustomerKey"=>8838753})
#puts result4

# result4 = G_DBHelper.action('my_cus').get_rows_not_match_condition({"CustomerKey"=>8838753})
# puts result4
G_DBHelper.assert('my_cus').assert_size("==",10)
G_DBHelper.assert('my_cus').assert_data_match_exist({"CustomerKey"=>8838753})
G_DBHelper.assert('my_cus').assert_data_not_match_exist_rows({"CustomerKey"=>8838753},9)
