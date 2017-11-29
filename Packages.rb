# encoding=utf-8
#Author: Stephen Zhang
require File.expand_path(File.dirname(__FILE__)) + "/Core/Config/ConfigHelper.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Assert.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Element.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Page.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/PageRegister.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/DriverRegister.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Action/BrowserAction.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Action/ElementAction.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Action/DBResultAction.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Assert/BrowserAssert.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Assert/ElementAssert.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Assert/DBResultAssert.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Factories/PageFactory.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Factories/DriverFactory.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Database/SqlClient.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Database/DBHelper.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/QueryRegister.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/VariableRegister.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Service/HttpHelper.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Service/RestService.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Service/SoapService.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Utils/CodeUtil.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Utils/ColorUtil.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Utils/DateUtil.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Utils/RandomUtil.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Utils/VarUtil.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Providers/DataProvider.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Providers/StepProvider.rb"

require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/AuthRegister.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/DataProviderRegister.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/ServiceRegister.rb"
require File.expand_path(File.dirname(__FILE__)) + "/Core/Register/StepProviderRegister.rb"

