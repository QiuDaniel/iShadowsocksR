source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

def library
    pod 'ICSMainFramework', :path => "./Library/ICSMainFramework/"
    pod 'KeychainAccess', '~> 3.1.1'
end

def model
    pod 'RealmSwift', '~> 2.10.2'
end

target "iShadowsocksR" do
    pod 'Aspects', :path => "./Library/Aspects/"
    pod 'Cartography'
    pod 'AsyncSwift'
    pod 'SwiftColor'
    pod 'Appirater'
    pod 'MBProgressHUD'
    pod 'ICDMaterialActivityIndicatorView'
    pod 'ICSPullToRefresh'
    pod 'ISO8601DateFormatter'
    pod 'Alamofire'
    pod 'ObjectMapper'
    pod 'PSOperations'
    library
    model
end

target "TodayWidget" do
    pod 'Cartography'
    pod 'SwiftColor'
    library
    model
end

target "PotatsoLibrary" do
    library
    model
end

target "PotatsoModel" do
    model
end
