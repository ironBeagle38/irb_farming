Config = {}

-- Active language/locale
Config.defaultlang = 'fr_lang'

Config.TimeToGrow = 60 -- 1800 = 30 mins / testing 60 = 60 seconds

Config.Harvest = {
	key = 0xB2F377E8, -- [F]
	keyLabel = '[F]',
	min = 2,
	max = 5
}

Config.FarmZone = {
    [1] = {
        zones = { -- farmzone1
			vector2(-866.50738525391, 379.50839233398),
			vector2(-895.23333740234, 316.94226074219),
			vector2(-785.49139404297, 309.60153198242),
			vector2(-783.16119384766, 376.96636962891)
        },
		name = 'farmzone1',
		minZ = 94.61107635498,
		maxZ = 96.225868225098,
		showBlips = true,
		blips = {
			sprite = 2350572198,
			x = -817.22, 
			y = 338.99, 
			z = 96.36
		}
    },
	[2] = {
        zones = { -- farmzone2
			vector2(-416.44311523438, 877.68499755859),
			vector2(-340.73004150391, 882.06268310547),
			vector2(-327.01953125, 949.17590332031),
			vector2(-419.45263671875, 948.95648193359)
        },
		name = 'farmzone2',
		minZ = 115.60678100586,
		maxZ = 125.75849914551,
		showBlips = true,
		blips = {
			sprite = 2350572198,
			x = -394.73, 
			y = 915.15, 
			z = 117.47
		}
    },
    [3] = {
        zones = { -- farmzone3
			vector2(867.71990966797, 830.55853271484),
			vector2(827.24829101562, 978.51281738281),
			vector2(776.88360595703, 942.62603759766),
			vector2(722.10461425781, 843.55340576172),
			vector2(762.76971435547, 831.14996337891)
        },
		name = 'farmzone3',
		minZ = 116.7624130249,
		maxZ = 121.97254180908,
		showBlips = true,
		blips = {
			sprite = 2350572198,
			x = 810.98, 
			y = 855.69, 
			z = 116.77
		}
    },
    [4] = {
        zones = { -- farmzone4
			vector2(1057.3891601562, -1813.7116699219),
			vector2(1037.1082763672, -1936.9809570312),
			vector2(993.06481933594, -1935.6380615234),
			vector2(993.91253662109, -1889.6791992188),
			vector2(938.37463378906, -1889.8885498047),
			vector2(948.02667236328, -1807.7596435547)
        },
		name = 'farmzone4',
		minZ = 44.672874450684,
		maxZ = 48.551219940186,
		showBlips = true,
		blips = {
			sprite = 2350572198,
			x = 1000.18, 
			y = -1858.65, 
			z = 45.45
		}
    },
    [5] = {
        zones = { -- farmzone5 (gang house 2)
			vector2(-636.91583251953, -8.6817226409912),
			vector2(-642.67010498047, -87.87540435791),
			vector2(-562.67651367188, -59.754615783691),
			vector2(-607.54565429688, 14.365551948547)
        },
		name = 'farmzone5',
		minZ = 80.278839111328,
		maxZ = 87.275184631348,
		showBlips = true,
		blips = {
			sprite = 2350572198,
			x = -614.07, 
			y = -7.75, 
			z = 86.65
		}
    },
    [6] = {
        zones = { -- farmzone6 (braithwaite manore1)
			vector2(1110.6455078125, -1526.8820800781),
			vector2(1115.7180175781, -1485.7622070312),
			vector2(1035.0233154297, -1485.4185791016),
			vector2(1035.2568359375, -1525.4301757812)
        },
		name = 'farmzone6',
		minZ = 49.336120605469,
		maxZ = 54.163547515869,
		showBlips = false,
		blips = {
			sprite = 2350572198,
			x = 1088.57, 
			y = -1507.65, 
			z = 53.02
		}
    }
}

Config.Items = {
	{
		seedName = 'tobaccoseed',
		name = 'tobaccoLeaves',
		plant1 = 'CRP_TOBACCOPLANT_AA_SIM',
		plant2 = 'CRP_TOBACCOPLANT_AB_SIM',
		plant3 = 'CRP_TOBACCOPLANT_AC_SIM',
    },
	{
		seedName = 'sugarcaneseed',
		name = 'sugar',
		plant1 = 'CRP_SUGARCANE_AA_SIM',
		plant2 = 'CRP_SUGARCANE_AB_SIM',
		plant3 = 'CRP_SUGARCANE_AC_SIM'
    },
	{
		seedName = 'cornseed',
		name = 'corn',
		plant1 = 'CRP_CORNSTALKS_CB_SIM',
		plant2 = 'CRP_CORNSTALKS_CA_SIM',
		plant3 = 'CRP_CORNSTALKS_AB_SIM'
    },
	{
		seedName = 'dixonappleseed',
		name = 'dixonApples',
		plant1 = 'p_tree_magnolia_01',
		plant2 = 'p_tree_magnolia_02',
		plant3 = 'p_tree_magnolia_02_MD'
    },
	{
		seedName = 'bananaseed',
		name = 'banana',
		plant1 = 'p_tree_banana_01_crt',
		plant2 = 'p_tree_banana_01_MD_crt',
		plant3 = 'p_tree_banana_01_MD_crt'
    },
	{
		seedName = 'cottonseed',
		name = 'cotton',
		plant1 = 'CRP_COTTON_AD_SIM',
		plant2 = 'CRP_COTTON_BA_SIM',
		plant3 = 'CRP_COTTON_BB_SIM'
    },
	{
		seedName = 'ginsengseed',
		name = 'ginseng',
		plant1 = 'CRP_GINSENG_AA_SIM',
		plant2 = 'CRP_GINSENG_AB_SIM',
		plant3 = 'CRP_GINSENG_AD'
    },
	{
		seedName = 'potatoseed',
		name = 'potato',
		plant1 = 'crp_potato_aa_sim',
		plant2 = 'crp_potato_har_aa_sim',
		plant3 = 'crp_potato_sap_aa_sim'
    },
	{
		seedName = 'tomatoseed',
		name = 'tomato',
		plant1 = 'crp_tomatoes_aa_sim',
		plant2 = 'crp_tomatoes_har_aa_sim',
		plant3 = 'crp_tomatoes_sap_aa_sim'
    },
	{
		seedName = 'cocaseed',
		name = 'cocaLeaves',
		plant1 = 'p_sap_maple_aa_sim',
		plant2 = 'p_sap_maple_ab_sim',
		plant3 = 'p_sap_maple_ad_sim'
    },
	{
		seedName = 'wheatseed',
		name = 'wheat',
		plant1 = 'crp_wheat_dry_aa_sim',
		plant2 = 'crp_wheat_sap_long_ab_sim',
		plant3 = 'crp_wheat_stk_ab_sim'
    },
	{
		seedName = 'barleyseed',
		name = 'barley',
		plant1 = 'crp_wheat_dry_aa_sim',
		plant2 = 'crp_wheat_sap_long_ab_sim',
		plant3 = 'crp_wheat_dry_long_aa_sim'
    },
    {
		seedName = 'grapeseed',
		name = 'grape',
		plant1 = 'rdr_bush_neat_ac_sim',
		plant2 = 'rdr_bush_neat_ab_sim',
		plant3 = 'rdr_bush_hedgecore_ac'
    }
}
