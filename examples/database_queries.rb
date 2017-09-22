# encoding=utf-8
require File.expand_path(File.dirname(__FILE__)) + "/../Packages.rb"

G_ConfigHelper.conifg_enironment(["QA3","QA4"])
G_ConfigHelper.config_databases("QA4","default",{:dataserver=>'svname',:database=>'dbname'})
G_ConfigHelper.config_current_stage("QA4","desktop","chrome","Windows","Error")

customerQuery = "SELECT A.*
    FROM Customer A WITH (NOLOCK)
  WHERE %{queryParam} 
  order BY A.CreateDate desc"

qry = G_QueryRegister.transferQuery(customerQuery,
  {
    "queryParam" => "A.AccountKey=%{accountKey}"
  }
)

G_QueryRegister.registerQuery('q_customer',qry)

result = G_DBHelper.query_default_db('my_cus','q_customer',{'accountKey'=>'5293594'})
puts result
result2 = G_DBHelper.get_result('my_cus')
puts result2
