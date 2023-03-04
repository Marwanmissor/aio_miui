SKIPUNZIP=0
SKIPMOUNT=false
Manufacturer=$(getprop ro.product.vendor.manufacturer)
Codename=$(getprop ro.product.device)
Model=$(getprop ro.product.vendor.model)
Build=$(getprop ro.build.version.incremental)
Android=$(getprop ro.build.version.release)
CPU_ABI=$(getprop ro.product.cpu.abi)
MIUI=$(getprop ro.miui.ui.version.code)
MINMIUI=13
MINSDK=31
MAXSDK=0
PACKAGES="
com.miui.gallery
com.android.fileexplorer
com.miui.home
miui.systemui.plugin
com.miui.player
com.miui.personalassistant
com.miui.securitycenter
com.android.thememanager
"
# Set what you want to display when installing your module

print_modname() {
  ui_print "*******************************"
  ui_print "---------- AIO MODULE for MIUI    "
  ui_print "---------- By Just Call Me Marwan (JCMM)  "
  ui_print "---------- FOLLOW @Mi10TupdateEgypt "
  ui_print "----------- UNNECESSARY MODULE TO FLASH IT"
  ui_print "*******************************"
  sleep 5
  ui_print " ×• HERE •×"
  sleep 1 
  ui_print " ×• We •×"
  sleep 1
  ui_print " ×• GO •×"
  sleep 1
  ui_print " ×• TO •×"
  sleep 1
  ui_print " »• F**K •«"
  sleep 1
  ui_print " ×• MIUI •×"
  sleep 1
  ui_print " || NOW ||"
  sleep 1
}

# output some system spec.
print_specs() {
	ui_print "===================================================="
	sleep 0.05
	ui_print "- Device:           $Model"
	sleep 0.05
    ui_print "- Manufacturer:     $Manufacturer"
    sleep 0.05
	ui_print "- SDK Platform:     API level $API"
	sleep 0.05
	ui_print "- Android Version:  Android $Android"
	sleep 0.05
	ui_print "- MIUI Version:     MIUI $MIUI"
	sleep 0.05
	ui_print "- Build version:    $Build"
	ui_print "===================================================="
	sleep 0.3
}


# Check for min/max api version
check_sdk() {
	local error=false
	if [ $MINSDK -gt 0 -a $MINSDK -gt $API ]
	    then
		ui_print " "
		ui_print "  Your SDK version $API is less than the required ";
		ui_print "  SDK version. ";
		error=true
    fi

	if [ $MAXSDK -gt 0 -a $MAXSDK -lt $API ]
	    then
		ui_print " "
		ui_print "  Your SDK version $API is higher than the required ";
		ui_print "  SDK version. ";
		error=true
    fi

	if $error; then
		abort
	fi
}

# check minimum MIUI version 
check_miui() {
	local error=false
	if [ $MINMIUI -gt 0 -a $MIUI -lt $MINMIUI ]
	    then
		ui_print " "
		ui_print "  Your MIUI version $MIUI is less than the required ";
		ui_print "  MIUI version. ";
		error=true
    fi

	if $error; then
		abort
	fi
	
}

install_files() {
	ui_print "-- Do you want to install all mods?"
	ui_print "-- Warning: Miui 14 CN is not supported for modded luncher"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No, I want to choose"
	ui_print " "
	
	chooseport
	if chooseport; then
       ui_print "Let's start installing miui luncher first"
       launcher_install
		ui_print "- installing all mods"
	
	    for PACKAGE in $PACKAGES; do
		    install_file
	    done

		cp -rf $MODPATH/apps/FileExplorer $MODPATH/system/app
		#cp -rf $MODPATH/apps/MiuiGallery $MODPATH/system/priv-app
		cp -rf $MODPATH/apps/MiuiSystemUIPlugin $MODPATH/system/app
		cp -rf $MODPATH/apps/MIUIMusic $MODPATH/system/app
		cp -rf $MODPATH/apps/PersonalAssistant $MODPATH/system/priv-app
		cp -rf $MODPATH/apps/SecurityCenter $MODPATH/system/priv-app
		cp -rf $MODPATH/apps/ThemeManager $MODPATH/system/app
		ui_print "- all mods installed"
	else {
		ui_print "- choosing mods"
		choose_mod
	}
	fi 
}
launcher_install(){
ui_print "Choose your Miui Version:"
ui_print "  Vol+ = Miui 13 or lower"
ui_print "  Vol- = Miui 14 Android 13 Xiaomi.eu based"
ui_print " "

if chooseport; then
    ui_print "- Miui 13 or lower selected"
    cp -rf $MODPATH/files/launcher/MiuiHome.apk $MODPATH/system/priv-app/aMiuiHome
else
{
    ui_print "- Miui 14 Eu selected"
    cp -rf $MODPATH/files/launcher/MiuiHome.apk $MODPATH/system/product/priv-app/aMiuiHome
}

fi
    ui_print " "
    ui_print " Is your device POCO?"
    ui_print "  Vol+ = Yes"
    ui_print "  Vol- = No"
    ui_print " "

if chooseport; then
    ui_print "- Deleting POCO Launcher and adding MiuiHome support."
    cp -rf $MODPATH/files/poco/Framework_resoverlay.apk $MODPATH/system/product/overlay
else
{
    ui_print "- Skipping..."
}

fi


}
install_file() {
    APP=$(pm path $PACKAGE)
    if [ ! -z $APP ]
	    then
		$(pm uninstall-system-updates $PACKAGE 2>&1)
		sleep 1
		FULLPATH=${APP:8}
		FOLDER=${FULLPATH%/*}
		APK=${FULLPATH##*/}
		FILE=${APK%????}
		mkdir -p $MODPATH$FOLDER/
		touch $MODPATH$FOLDER/.replace
    	rm -f `find /data/system/package_cache -type f -name *$FILENAME*`
    	rm -f `find /data/dalvik-cache -type f -name *$FILENAME*.apk`
	fi
}

choose_mod() {
	#ui_print " "
	#ui_print "-- Do you want to install gallery?"
	#ui_print "  Vol+ = Yes"
	#ui_print "  Vol- = No"
	#ui_print " "
	#chooseport
	#if chooseport; then
		#PACKAGE="com.miui.gallery"
		#ui_print "- installing gallery"
		#cp -rf $MODPATH/apps/MiuiGallery $MODPATH/system/priv-app
		#install_file
	#fi

# repeat this for all apps to be 
	ui_print " "
	ui_print "-- Do you want to install file manager?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="com.android.fileexplorer"
		ui_print "- installing file manager"
		cp -rf $MODPATH/apps/FileExplorer $MODPATH/system/app
		install_file
	fi

ui_print " "
	ui_print "-- Do you want to miui 14 luncher?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="com.miui.home"
		ui_print "- installing miui 14 luncher"
		launcher_install
		install_file
		
	fi

ui_print " "
	ui_print "-- Do you want to install System Ui Plugin?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="miui.systemui.plugin"
		ui_print "- installing System Ui Plugin"
		cp -rf $MODPATH/apps/MiuiSystemUIPlugin $MODPATH/system/app
		install_file
	fi

ui_print " "
	ui_print "-- Do you want to install miui music global?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="com.miui.player"
		ui_print "- installing miui music global"
		cp -rf $MODPATH/apps/MIUIMusic $MODPATH/system/app
		install_file
	fi

ui_print " "
	ui_print "-- Do you want to install app vault?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="com.miui.personalassistant"
		ui_print "- installing app valut"
		cp -rf $MODPATH/apps/PersonalAssistant $MODPATH/system/priv-app
		install_file
	fi

ui_print " "
	ui_print "-- Do you want to install security center mod?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="com.miui.securitycenter"
		ui_print "- installing security center mod"
		cp -rf $MODPATH/apps/SecurityCenter $MODPATH/system/priv-ap
		install_file
	fi

ui_print " "
	ui_print "-- Do you want to install theme manger modded?"
	ui_print "  Vol+ = Yes"
	ui_print "  Vol- = No"
	ui_print " "
	chooseport
	if chooseport; then
		PACKAGE="com.android.thememanager"
		ui_print "- installing theme manger modded"
		cp -rf $MODPATH/apps/ThemeManager $MODPATH/system/app
		install_file
	fi
}
# cleanup extra files & junk after installation
cleanup() {
	rm -rf $MODPATH/addon 2>/dev/null
	rm -rf $MODPATH/app 2>/dev/null
	rm -f $MODPATH/customize.sh 2>/dev/null
	rm -f $MODPATH/LICENSE 2>/dev/null
    rm -rf /data/system/package_cache/*
    rm -rf /data/resource-cache/*
    rm -rf /data/dalvik-cache/*
    rm -rf /cache/*
}
# You can add more functions to assist your custom script code

# main installer
run_install() {
	. $MODPATH/addon/Volume-Key-Selector/install.sh
	ui_print " "
	print_modname
	sleep 1
    ui_print " "
	ui_print "- Checking requirements"
	ui_print " "
	sleep 1
	print_specs
	sleep 1
	check_sdk
	check_miui
	sleep 2
	ui_print " "
	ui_print "- Installing files"
	sleep 0.5
	install_files
	sleep 1
	ui_print " "
	ui_print "- Cleaning up"
	ui_print " "
	cleanup
	sleep 2
	print_credits
}

# start the installation
run_install