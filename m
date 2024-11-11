Return-Path: <linux-tip-commits+bounces-2839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF689C45F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 20:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A8AB20D6B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854F4594D;
	Mon, 11 Nov 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkX6n89M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF62139597;
	Mon, 11 Nov 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353695; cv=fail; b=eJbE/lT7CscTU9qYNjU+YFVln03btAV0PjzxIzswXc2lKgqdR2/gP9g7sU+qfVo75HeOLjq9OnU4IyzZQ/XhqsOxnZ7+5fVyIQTEFqcag/YMvwcHbWcPv9p2u9neb35Dj3PWExz/4Z4VVu3KnoE9F+HgGyoMHE7vIxlWrR1Q6TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353695; c=relaxed/simple;
	bh=NN/EDakM2H+PCQq8gY+Lr1spMnCjh+FF36sHklRBy1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIYBW93td0qMroEiofg++jM9x5oM4bOE4S6yiDAXBVSa33gMdVHETrbs6tcHBfxsWAv09pR1EGNPpk6UFalMRhH5hW2YqAx47zA3JfaghTa9YWJBG0kKZM4EolKwT5rylBrkmDwtF0s1QG6Oi23rMxQxiwFP7eOyo0HRHuLMKh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkX6n89M; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731353694; x=1762889694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NN/EDakM2H+PCQq8gY+Lr1spMnCjh+FF36sHklRBy1U=;
  b=TkX6n89MhAEkLMO/3P8ZYGOQDXN0hwNZcG54aY5Soh44cmoGkreM+8lT
   OeYVgpqWsl/t0SQAY7LC1A54oZZG1HNwbvCxjsj2R/p1drcJ5P6wFXmFk
   g4INfI6oC9ww4oAIflOtljL/ESRPadc67I/ly9TAIYs5n5XTaFdVaHwkb
   1mkZe+uEzLmnvRhhutt6QIbPIlpaunlvdIje6eoabXEGqfrK17qKfgyDs
   HTY1GlZ23SFtefVkcniT+GQ80fOGZ82Q6TuMWeHXARKOK2BlwUCKUnLZ+
   WI6fNW84xl7QiZ2pLIjy2LDaR07PuaEQ7Y+qYlh99SFfNTrerQIDlb0Js
   Q==;
X-CSE-ConnectionGUID: yHnSWPPXQNiwBjepiVZjfw==
X-CSE-MsgGUID: LMKTkDSFQBSkUhDg1mGUMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31403412"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="31403412"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 11:34:53 -0800
X-CSE-ConnectionGUID: r821Lq6USJKMxGNlHMpAKA==
X-CSE-MsgGUID: tb0qjjKBT5OLxE8e2mxjEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="117993018"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 11:34:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 11:34:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 11:34:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 11:34:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw2X3FyvRZfVAnBGM48SRPFpR32op4odNzqGlLhAGvZ/kSryiacG/+o5G6mxr/VN3xvnW3ituKfwmyFSQWoP9mQXQMyvfS9Kv+qxJSBmJjjeun6YRh/YDpxa0jVhTjQt0D6zd1eMfzReI8MlSHSRAceMgidOgxlarUbI6UiSEA57y980Dk+AS+ofkYcuLV+Rb3FeoA7NBgRIMNPssbZuTVfbGIP/OUc9u/XPu+x/6AqhYReWbtpEa8G86xMF5wFgToaEeUHOCqhxLl/S1z5uImO0tH4WZkbqu9NOH8f5pp0YWkzXyGTM4htOUBzfYjobrXVxXdlh1Af8++Q4/53l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN/EDakM2H+PCQq8gY+Lr1spMnCjh+FF36sHklRBy1U=;
 b=mufd+pXjnR7VKiKYwyos+2ld8zcsGNaTtzlNKY78lROvXPf+pbmNAl1ZMj1Uv4fMUIzYr04dcF5izifAvxOOovDdwAhsJ2pEfKdBagJIPz9xbn7wmnmsgCS0UkCKDa6mGa3dDryIwfNlJOI2+/ZZTUBinSHxlJyeAMSzH3Qs9sIIExuIH1ZAXLUC76sNcHjrdhwqq15td+w6FogUUVtn5VHytgSlBVhsh+J0qtiplU6pM9MpmP0iRDzTzIAu1+YNy1mFq75yB7svZO8wXAmat/VoCaQn9Nf9H9QNRYRFPybYTZjky9M4XTcgvrrXvsNhbbDjff7F/qNXzGCQpOM1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 19:34:49 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 19:34:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [tip: objtool/core] objtool: Exclude __tracepoints data from
 ENDBR checks
Thread-Topic: [tip: objtool/core] objtool: Exclude __tracepoints data from
 ENDBR checks
Thread-Index: AQHbMg6LCEqJv3/czE6q5cLrhTP8ybKx7WuAgACQAIA=
Date: Mon, 11 Nov 2024 19:34:49 +0000
Message-ID: <d72e8a038c57fbd105a018cf6bd816516b103533.camel@intel.com>
References: <20241108184618.GG38786@noisy.programming.kicks-ass.net>
	 <173132276382.32228.11223762940167419288.tip-bot2@tip-bot2>
In-Reply-To: <173132276382.32228.11223762940167419288.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|SJ0PR11MB5866:EE_
x-ms-office365-filtering-correlation-id: f4f86e9a-a139-4950-50a7-08dd0287e846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a3RDVTY0Q0hZekdYeDRSamdMcDdzYnZkRWVlRiswZzd5cXovdk5UM1ZxS2dm?=
 =?utf-8?B?ei9aVDlUR05TZUFBcnB2QVNJR1FFT2JHR2hTOEZ1R0VnKzlqNkFKbU1rUkxT?=
 =?utf-8?B?UGg2S0lGamlFejRQTUkwMzF5cThEK3laMEc4dzF5R25COXN4YWZ4MzYwRS8r?=
 =?utf-8?B?Z1BWT2laM3k1Qzd5WWlmaE53WGRrUm9PY0Z2Zm1VQ2JFcExzS3F1akd0L0hB?=
 =?utf-8?B?bFMyZWtIejA5NXRPSUhzbnk0SGU5UXJ4ZGxURXpkNTdubXg4VEdEZjhPcUx6?=
 =?utf-8?B?b203SHpNVkp1emVpVElhS3V4T3hQL2hBNjZ4ZXl5WVhuaFl2VU8zazRvZHdS?=
 =?utf-8?B?ckdUMERYQzIyVEhKUDhkL1VwaXlJWTloVkl4R0MwYWJLaERWRU91QnBFWEI3?=
 =?utf-8?B?NFBPekRPT1RzcEdxRTZjYXJWNE5WV1d2WTJEYlIvMlp1aTA4Wk0zeHRGQThN?=
 =?utf-8?B?aTY0em1PNEZpN0FDQ01HYjRwd2E0TkVsYjBqSDJ0TkN3bnhTc2RtZTRyajAx?=
 =?utf-8?B?d1lHSkRFR1ZqSHBpbXJ1cm9OdkxZUUwwWjhBVGtEVld0d1FHMUNPaWVDMFNz?=
 =?utf-8?B?UzdyM1owVGI0amxzVE1ZdmRMeHNyUlI2QTFQZ1NlLzNJN1M0dXU1eEtYWnBU?=
 =?utf-8?B?dkZhYmZlV2hFR2Z4bGUzVzZTT21ubWkrbllxdURxQzhEZnc1Unc2QVpmblkw?=
 =?utf-8?B?c1RFNDZRVkVESHlOZEVFbHg2KzhlUmEwdk9ldGhNVklyNXEzMkY1Z0JDN2tP?=
 =?utf-8?B?NmluSGVXOHhIZW5BMDFmNnhRRVFYa0JuOHJzSW91TlBNRUV4OFBUb0dqa3BI?=
 =?utf-8?B?Y1pQRDB4VVpUZ1Q5ekM3YnlJUnkrYnJpRXRGNVhaS1dzT3U0Y0VxemV0NHp1?=
 =?utf-8?B?NXp6WVJER0N4N0J6U28walFONWxES1cxTysxazNmTmVSSit6WWg4SjYxdDZM?=
 =?utf-8?B?MGFOV1pPd25XcjZVNEJVNFpvcmZuZ21UdHd3KzFrRW5XS2FydlhPY1RNZE1m?=
 =?utf-8?B?d0ZnWlhPYTNRc1o2MFhvL1N0eEpxMnMyUmczeVphWkEyWm16SXc5SUk0d1Fx?=
 =?utf-8?B?K1hwZWlmQ0ZIVnVTNlpMU1RnemJwamdqQWF4ZDdFbHV3amluMmNwc2NHa2RH?=
 =?utf-8?B?UGJCSnc5VWQxTWR1K3hZVVM4QURPN1BjWVV3Zm5QaUh5eUFJT1M2OGl6S3RC?=
 =?utf-8?B?Yi9BMVZmR2R1UjJzcHFab01sNnNBcTJ3TnAyK2Y3N3BJMHE3KzNKZXVEL2Jy?=
 =?utf-8?B?RS9sdlZva2wxa3FMcmVLOVRheFE4SXZjR2RsQ0VEVFNEQ0pjOGhMaUJSdWNs?=
 =?utf-8?B?Y05TbjZBQWh3K2VHSXZJQ2dtR1prbFloL2V2ZTRUWWVSRzNUOVpEVHhiTy9j?=
 =?utf-8?B?WHE4TjF1UXJWdG9RbFlYRkxkMGN5SGtidE9xSG1aclF5OHJCOWNheWQyalpB?=
 =?utf-8?B?V0Jia2FJbzJlTHJsSlVyQyt4a1hYSmdiVjA0aGVvczR3VFE1alRzU0lpUWFK?=
 =?utf-8?B?RG1BTWRpdVpTVWt1cmpZc3pvWmxPK1JJMlpyQjhqMWJxR3VjOXFOUnExSFZm?=
 =?utf-8?B?R3UyVzdOaVJCTmJzVUpENnJ4MEtrVUsxRkFTRG1JTDNKNEJJLzV2OWdkT0VD?=
 =?utf-8?B?S1N4T0IycEsxdkVvYjBsK1dFNTRLZ3VCeUZ1ZThtd25LZmVZaXBVQ1hnWWZG?=
 =?utf-8?B?cnd2QVR1VFE1NzdVMXdsQ05sTEpWQ1NTazV2TEg5WEVNazN6dnQ2NDRGRjJl?=
 =?utf-8?Q?DShLAyiL07OI/j5kxI2md6N+y9g4ENXbpeNMOlT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEFjMU1YRHVWdzl6aXJrTUcxQWNUQVhVekxSUHlRakp0cDNQUVBTYXZQNU9r?=
 =?utf-8?B?ekkyajhSaEdsVytoazhvanlhM3hxL1FYQ3FoQ3VEcklyRXBLeHRLcDZFRXpW?=
 =?utf-8?B?OU8zU3NNaGhZbkM4TWRyMm5CL1lUejF5MFV2WC9DdDVwTk9oSmtnejNGRHBJ?=
 =?utf-8?B?ZURTRVM3KzduTzZjMGJob2JTQit2TjhyNUFPWng4bTUrZC9KM3V3SmQyaHMx?=
 =?utf-8?B?dmIrNjBwd3Qwb2F4d1pFWDNOK2FsalEwWXZ6bmZEZ0FSbXlKUUxVV1BrVzRq?=
 =?utf-8?B?VEZFQkFIckZpRkxUWFJmNHVjQURLZ0oveVVIT2FqaXhtckVCTTBhT3ZnRlM3?=
 =?utf-8?B?UDF2M1FOam5NdktvOXhtWTV3SHI4b09Fam1DYXErbzRBdm9BMU5ENGRNSnhn?=
 =?utf-8?B?ZGE1TjRzM0pIMTR3T0NWTHQrOUt4QzE1ZzBsUk9QRnFydk5WSGNYbGFmTGZo?=
 =?utf-8?B?ZHR0SkZueStFVHl6TzFPSTd1dk1HZjBNMlV3M0M4UzIyNzFLVTRzVGdsaFMv?=
 =?utf-8?B?WVViWmhuZThpR01BL3A5bXRRMXltY2YydE1WMGhTOXAzdHNFc05ZZVRKb0pt?=
 =?utf-8?B?dGdqS09odGRjT2VMV1dQMllZWk5PWHBNdWlDNTk0NkVCN0I3eERCRDhnWFVr?=
 =?utf-8?B?Q1pqQ2RmZkloaUtjaFBacUc4Sm91WkNhSTFGRHQ1SFBBOHl0WVpHM1ZCMmpr?=
 =?utf-8?B?c1U5K21QQ2lNaGFTUnplM3ZhOENnbmR6ekI5NTN1S3dFbDFGSHpTRk5yVjRW?=
 =?utf-8?B?OVRSNTM3djAyWnp1cFlid0dFK21lYzBJVzhVQ1VmQmV2cnkzb2NoNURxdXF5?=
 =?utf-8?B?V1lKai9CVjk1NTF5RmVIRmNRMFRqYzY2SHcvaXhrOVlxZlRMREhNcm9mUnNV?=
 =?utf-8?B?WkpvaG90STNwUURBY0hTVVpHcm9JNDQ3ZnNTRjlSOEJ5bndJTk04SEtobFZE?=
 =?utf-8?B?VnEwNnBkby9MN1V1dHhtSDZGSmVCOWYyZlpqV1VqVm9IQkVOUWhlUktYSWJ3?=
 =?utf-8?B?L0pZcjRhcFEvemtOcVZVNU9ZU0xFc280ZDBLdkF2dnRoN3VyTW5oTGdBN29S?=
 =?utf-8?B?WVNXbXluZHNjUHNPQTU1c2hmU2JvK05lNE1KdnBOa1BYMWR3SVBteVpZNnli?=
 =?utf-8?B?ODhLVUdxTVFkVzBKdUh3bVQ3MU5Fb1JjcnhoQjAyQ2ZjajJwdjZ2MmJiU3lJ?=
 =?utf-8?B?N0RIVEY5WkdPRStoZWRVUDFISjBGOEhqT0xJZnRUNGR3OENqcWJBeVprbUFh?=
 =?utf-8?B?c0pUV1lYMlRFOGxZd0RSL2dxMFVMSyttK0x4UnFHWk1YYThWZWdJMko1RUhx?=
 =?utf-8?B?bUVMWUFCaXZPYkc3WEgyMmlMWWxFUHh3NGdIMEJhVCtSblowNGJmNms3N0d5?=
 =?utf-8?B?MWE4TkZ1QVIyeDlaNXBRMWZNZmdJdGVLeDZpamRtV1kyMHBDWU1vVzV6TXlB?=
 =?utf-8?B?cVJNbFdJM0pOWG1wcFBUT3ZaWFYrVEFFd1gyL1pRaDhmZmhyYnlBNFF4bHVJ?=
 =?utf-8?B?MWdJVVkxcmhNRUVSN1UzMm1WMk9yM3RMbU40VFBwWkNTcVZwZGhxQjhWeGZs?=
 =?utf-8?B?UEM5VGVPd1BsaWR2RXA1Y0JOZWMvRVppa096d2tIbC8wWCt5VDVobmRxN3ZL?=
 =?utf-8?B?YWo0Tkl6U2ZwRXVVNnpXOGEvNEQ1Y3dIUXVKcHZaOUlpckVyditHMS9HcDVv?=
 =?utf-8?B?MlFQWFlPckJZRDBmYXZYSHNXU3VUWFBwaVJuOTFjTnRiSkV3REZaMDNwcXJj?=
 =?utf-8?B?TFJJckZuOG5mOUEvdHo5UGtaRjdFckE4Sk54bTdxdFRjQlU0L2ZzU1lkalVG?=
 =?utf-8?B?bFNueGU5a2EvMmtHV1cvU2VJK3pROWhQMU5ZRlEzcy9adER5VnRxOFlUdWQ3?=
 =?utf-8?B?bG9tL1d2TWlScXZXNVMwNFRHUDZRN2pXcmxkSG15bHE4TC9BVTdTZnJmeW8r?=
 =?utf-8?B?dW8rMFdZRWUyN3lHTVBhVDRQSnZ2TmU1TnVoa2xjN2ZHZTEzSnJTVXhYSW9y?=
 =?utf-8?B?czA5NVZXL3FPQ0loYWRWS0tWU20vdVZSRlNXZTFxbC9jc3VZNkx0R1gxUmx2?=
 =?utf-8?B?aklOQUZYbkZLd29vVlpMYXZxa21qcWM4Z2J6UkNRZ1dEcXVaNlJFam4xNm4r?=
 =?utf-8?Q?+k5u8UCyhQANIjqYmhtbhLle0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E3BF059278EF244B2BBFE3B9B41F98B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f86e9a-a139-4950-50a7-08dd0287e846
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 19:34:49.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7/5AFAvnwCPIJJiXxsC9ruZVvGWPJeo9cXqK/0KqIV3FRworLCZxU7t0cifPrRxAclPmfNcWifMc2PS3X80Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTExIGF0IDEwOjU5ICswMDAwLCB0aXAtYm90MiBmb3IgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IFRoZSBmb2xsb3dpbmcgY29tbWl0IGhhcyBiZWVuIG1lcmdlZCBpbnRv
IHRoZSBvYmp0b29sL2NvcmUgYnJhbmNoIG9mIHRpcDoNCj4gDQo+IENvbW1pdC1JRDogICAgIGQ1
MTczZjc1Mzc1MDUzMTU1NTdkODU4MGUzYTY0OGYwN2YxN2RlZGENCj4gR2l0d2ViOiAgICAgICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy90aXAvZDUxNzNmNzUzNzUwNTMxNTU1N2Q4NTgwZTNhNjQ4
ZjA3ZjE3ZGVkYQ0KPiBBdXRob3I6ICAgICAgICBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+DQo+IEF1dGhvckRhdGU6ICAgIEZyaSwgMDggTm92IDIwMjQgMTA6MzI6MDIgKzAx
OjAwDQo+IENvbW1pdHRlcjogICAgIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9y
Zz4NCj4gQ29tbWl0dGVyRGF0ZTogTW9uLCAxMSBOb3YgMjAyNCAxMTo0OTo0MiArMDE6MDANCj4g
DQo+IG9ianRvb2w6IEV4Y2x1ZGUgX190cmFjZXBvaW50cyBkYXRhIGZyb20gRU5EQlIgY2hlY2tz
DQo+IA0KPiBGb3Igc29tZSwgYXMgb2YgeWV0IHVuZXhwbGFpbmVkIHJlYXNvbiwgQ2xhbmctMTks
IGJ1dCBub3QgR0NDLA0KPiBnZW5lcmF0ZXMgYW5kIGVuZGxlc3Mgc3RyZWFtIG9mOg0KCSAgICBe
DQpOaXQ6ICB0aGlzIGxvb2tzIGxpa2UgYSBncmFtbWFyIG1pc3Rha2U/DQoNCg==

