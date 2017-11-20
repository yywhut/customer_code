/*
 * Copyright (C) 2016 MediaTek Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See http://www.gnu.org/licenses/gpl-2.0.html for more details.
 */
#include <linux/types.h>
#include <mt-plat/mtk_battery.h>
#include "mtk_charger_intf.h"
#include <mt-plat/mtk_boot.h>
#include <mach/mtk_battery_property.h>

#if defined(CONFIG_OZ8806_SUPPORT) 
extern int oz8806_get_soc(void);
extern void oz8806_battery_update_data(void);
extern int oz8806_get_battery_temp(void);
extern int oz8806_get_battery_voltage(void);
extern int oz8806_get_battry_current(void);
#endif

/************** New Interface *******************/
bool battery_get_bat_current_sign(void)
{
#if defined(CONFIG_OZ8806_SUPPORT) 
	if(oz8806_get_battry_current() > 0)
		return true;
	else
		return false;
#else
	int ret = 0;
	bool curr_sign = 0;

	if (battery_meter_ctrl != NULL)
		ret = battery_meter_ctrl(BATTERY_METER_CMD_GET_HW_FG_CURRENT_SIGN, &curr_sign);

	return curr_sign;
#endif
}

signed int battery_get_bat_current(void)
{
	int curr_val;
#if defined(CONFIG_OZ8806_SUPPORT) 
	curr_val = oz8806_get_battry_current();
	if (curr_val > 0) return curr_val;
	else return (0 - curr_val);
#else
	int ret;

	if (battery_meter_ctrl != NULL)
		ret = battery_meter_ctrl(BATTERY_METER_CMD_GET_HW_FG_CURRENT, &curr_val);

	return curr_val;
#endif
}

signed int battery_get_bat_avg_current(void)
{
#if defined(CONFIG_OZ8806_SUPPORT) 
	return oz8806_get_battry_current();
#else
	int bat_avg_curr;
	int ret;

	if (battery_meter_ctrl != NULL)
		ret = battery_meter_ctrl(BATTERY_METER_CMD_GET_FG_CURRENT_IAVG, &bat_avg_curr);

	return bat_avg_curr;
#endif
}

signed int battery_get_bat_voltage(void)
{
#if defined(CONFIG_OZ8806_SUPPORT) 
	return oz8806_get_battery_voltage();
#endif
	return pmic_get_battery_voltage();
}

signed int battery_get_bat_avg_voltage(void)
{
#if defined(CONFIG_OZ8806_SUPPORT) 
	return oz8806_get_battery_voltage();
#endif
	/*return battery_get_bat_voltage();*/
	return FG_status.nafg_vbat;
}

signed int battery_get_bat_soc(void)
{
#if defined(CONFIG_OZ8806_SUPPORT) 
	return oz8806_get_soc();
#endif
	return FG_status.soc;
}

signed int battery_get_bat_uisoc(void)
{
	int boot_mode = get_boot_mode();

	if ((boot_mode == META_BOOT) ||
		(boot_mode == ADVMETA_BOOT) ||
		(boot_mode == FACTORY_BOOT) ||
		(boot_mode == ATE_FACTORY_BOOT))
		return 75;

#if defined(CONFIG_OZ8806_SUPPORT) 
	return oz8806_get_soc();
#endif
	return FG_status.ui_soc;
}

signed int battery_get_bat_temperature(void)
{
#if defined(CONFIG_OZ8806_SUPPORT) 
	return oz8806_get_battery_temp();
#endif
	/* TODO */
	if (is_battery_init_done())
		return force_get_tbat(true);
	else
		return -127;
}

signed int battery_get_ibus(void)
{
	return pmic_get_ibus();
}

signed int battery_get_vbus(void)
{
	return pmic_get_vbus();
}

unsigned int battery_get_is_kpoc(void)
{
	return bat_is_kpoc();
}

bool battery_is_battery_exist(void)
{
	int is_bat_exist = 0;

	battery_meter_ctrl(BATTERY_METER_CMD_GET_IS_BAT_EXIST, &is_bat_exist);
	if (is_bat_exist == 1)
		return true;
	return false;
}

/************** Old Interface *******************/
void wake_up_bat(void)
{

}
EXPORT_SYMBOL(wake_up_bat);

signed int battery_meter_get_battery_temperature(void)
{
	return battery_get_bat_temperature();
}

signed int battery_meter_get_charger_voltage(void)
{
	return battery_get_vbus();
}

unsigned long BAT_Get_Battery_Current(int polling_mode)
{
	return (long)battery_get_bat_avg_current();
}

unsigned long BAT_Get_Battery_Voltage(int polling_mode)
{
	long int ret;

	ret = (long)battery_get_bat_avg_voltage() / 10;
	return ret;
}

unsigned int bat_get_ui_percentage(void)
{
	return battery_get_bat_uisoc();
}

/*user: mtk_pe20_intf.c: pe20_check_leave_status()*/
int get_soc(void)
{
	return battery_get_bat_soc();
}

/*user: mtk_charger.c: show_Pump_Express()*/
int get_ui_soc(void)
{
	return battery_get_bat_uisoc();
}

signed int battery_meter_get_battery_current(void)
{
	return battery_get_bat_current();
}

bool battery_meter_get_battery_current_sign(void)
{
	return battery_get_bat_current_sign();
}

