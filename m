Return-Path: <linux-tip-commits+bounces-3096-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EF9F67EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3911D7A463A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68D01C1F3B;
	Wed, 18 Dec 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWGekV6O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170F1B424B;
	Wed, 18 Dec 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530663; cv=fail; b=PFdIsH9YxgNkZHtkxXnIKG75RcUNCohF3CBOSKegdo2Z1xx55E4c1XEhosYRzzKsJi637+EZw7je84obvcQy0v+U8n9vTMxUHmc2JJ03+ieFgAILZLXjJSbf5VGAXQ+nP7jPJPClip9HwIs6+8xNW6PKsCmwG5bVtR9yJH0L+DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530663; c=relaxed/simple;
	bh=AIvyYUoZL4SaPkd5V6Ve4m9WrtO/izt3bM2PNI83sUc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMHHPbalZse3i3AjsgNPqvUZucBUqRt/0/9Ub4nzvy/qt/u0ZdQsbkYGLT/oeK6dIKxMOtDdUWppK7aEeTDuWsSTpKV2CWuq9dZS9UlW3z7folb9njQByjlSxqaaKNpG4LO09AmnB8jwJISkyhGFKPUC6LW+pULiKfUpN3ULTYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWGekV6O; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734530662; x=1766066662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AIvyYUoZL4SaPkd5V6Ve4m9WrtO/izt3bM2PNI83sUc=;
  b=NWGekV6OIEucHXtzhUlfd2SnkEWYdJ8nR+zyHTTHyhVhE+tan5pSRRuW
   XwmMxmOqrwSf+UzVgfz0LwyEiQlONWxxTE54ziAcaCTlXALluX8XySLjv
   6yMZ8+PJiL9b69f5+sHVaP69TyNaKnt0mZMy1ugAj8qWNoAGaKt60MO2s
   YBMPjUrT9TSK+H8e/tlGGdxrC5TH/QJ+sfYg+aOAF6N3e4lVjtSSIHYdY
   SAUS8JB/fi/qpPUDpwslxeyoMEDCAUp5QGrRlH9hB0rmMFJ4y/lrsY5bY
   O1GFrsREhopoGAsBrwt8kfGB35RnVS9/T41bYSk4FhhfMHtRqMoTmVSPi
   w==;
X-CSE-ConnectionGUID: 7YVzhVsoQLi2Ec/VjECzSg==
X-CSE-MsgGUID: ebhcxctQRd2srMjmOy7OlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45696725"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45696725"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:04:21 -0800
X-CSE-ConnectionGUID: t5BFk2ldSQuddkBruw9dVQ==
X-CSE-MsgGUID: ZNuYTOfETgu/rKlmIGvemw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98348164"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 06:04:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 06:04:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 06:04:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 06:04:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ozi5SlJ/1VJ4+i+6nYIRWUrrceZ1RG/5piEaOcwE+76SWtP5yRo6vekAaVooLHz0/AZdLHtX6nUrJ35R170gIPuL5Omq/qQeWNnqs0IV/L+YKs+UePfL6cxbD5tFIlS1D3x18tvScSmnORl/sPfOpPN/m9dp44cqEwrLEpzPPPoUJxxQrFjJntojh8IE9yyVIcRy8f5ky7amfgP+2sYD8UZcbjcPvan8T8UxcfLsSeOJD+cF1PCRI5NOutetal0f6pgEcIPREmkMTj8N+1+nR9a460CQWLdqTqxHd9J4Lo3AZNrAXfczLU3VCxrIG+IVKLihRo9RJ4Hf0WBh222vNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MsGtrphUOy6QCuXJUUCgWNnlauL6nv68wI+i51w6k4=;
 b=GPODmCzI0isy5wTZsfLJ+T0FIVLkWCn6b8TJUkejst2tU+AHaSb/NYA38D1Xx2OsrVt5TBOX5Mc5cQeMxcTl7hz9acPSktQp/mCen8KXkRAfKgGqYZPHEdkm2mcxuBYlN+Sjb7egdRA/YtQShp92rlPNszu+eBD+Ah3krBA7EVkrTVh2k8MO/y2w0euhk9mkfHhGD3vugtkPGXZ1DuVa157IoTGuGrrmQkn3CMScF4ZNfLI+LBxSoIs7eHh5Q3BBSnBVo4iDxU63nsmrbrS7NATDEkikyu3nSWSH5KjgVsUbOzBTEPVUBU0AfnHi67D9VbpCGCJQV6LJgu9yWNwRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 14:04:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 14:04:15 +0000
Message-ID: <c8641989-fa0c-4dde-a8e6-8bcd90bd83b9@intel.com>
Date: Wed, 18 Dec 2024 22:04:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/cpu] x86/cpu: Move AMD erratum 1386 table over to
 'x86_cpu_id'
To: <linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <173448361317.7135.17921207841466608654.tip-bot2@tip-bot2>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <173448361317.7135.17921207841466608654.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CY8PR11MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 248e7ce2-2bd6-45c9-445c-08dd1f6cdb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnZjTElQdXBSZUFYd1lWbUdqbGlPdFpwazVMYU54Z21ZVFFxdW1uQnFhZTI4?=
 =?utf-8?B?RzAybGNNV1Q3cko5VnJEbm5Sb0p6bVpCTDl5SzZhZ3lUbnRuYlhMVzAwRDJK?=
 =?utf-8?B?RERUa0VqcmlESmoxcEg4SlRYUkxHdk5ZWDZXblRBZ29rVHBmN1VjUUdQQk9Y?=
 =?utf-8?B?U2gzam9VeUQ5UkNjZk45Y3UycTFjTmFYbjMvZUdwTzBjMkZvUkxlWTN6N1By?=
 =?utf-8?B?WDdDWHVJZ3BQWjdOWmdBRlRpS3JGMlBMTXpOK3I3enAxUzJLV2liYUNDUFdI?=
 =?utf-8?B?Y1hGRjJ0QU5TREpxNlNxTENuSjdYanZncWhSbWMwRXprR1FUSGNsbGdFOW9L?=
 =?utf-8?B?aGt4ekkxcUs3WXgwSmtmS3FtTWQ0ZFo5VU1DMkU4L05nc2Z4R2x1WkZ1WDll?=
 =?utf-8?B?RnBRelR5T3NKWk5PMDFvQ0VSOXBxbnJwWlRnWTBkdjJPR0dTZUM3VVFDV1B4?=
 =?utf-8?B?blROVEgyMVhjdTljOERhRXFGb3UzUEdTaVB5bGlmU3hFQmxyZnJEajYrSWoz?=
 =?utf-8?B?MTM4UEVuR0ZXdVBqNzA4L0ZvNjZYQ2laRUxxVTZmVnNraU9nWVQxZlQ1UHBF?=
 =?utf-8?B?Q09MN2FNNjRtOTFLL0ZoTCthVlRZc05UdFRYYTIvNlVlYW5PanhlVkVtOFMx?=
 =?utf-8?B?ZUtFdDZJWXF1RkUzNmhsclovQUdtSm5sdVRKMTB1bTJ5MU1pV2hEMjV4M0xY?=
 =?utf-8?B?TGJ6aGErNjVnLzVWM3FGZzZRU0hMMkZoQWoxY3RMdXRsbzFDZVpMdUs3ZUho?=
 =?utf-8?B?UkRoaklKVWlZNXpmU3RieVNKTW8wWXhjdmtLT041cStRMkNDZGs4YmJVMHBH?=
 =?utf-8?B?NHFlTDFNdDdETER6QTVTWEtQNk91RHhPUUF2a1JOQUUvc0xxK0hnckl2dUx0?=
 =?utf-8?B?SjVYZSsrMk1FelBlSkoyOEFsZUlXOU1vNG50S044aE9nQ0ZmUWNXSzdaWU5j?=
 =?utf-8?B?R01oM3BrQkswMVJsQ0NPMUllOGgrSnpNWTFvMU91bUVmenN0S05uZk1nSllp?=
 =?utf-8?B?cUxDSEU1VmY1ek85SGVVUTViZ3VpRWdQdkV4TzV2TGVjU01LcTdpMVVrc3Bs?=
 =?utf-8?B?Slg2aWlzMWtJOFBMbGtsN3pUSkpBUlZPUUZEYW5MY2tySDdEQURxcXlpY2Iz?=
 =?utf-8?B?RDhFeHVIaG04aktHNzdvQlRodmhaVTFYNzFQbU16MHFka1hXUU1OTzVmTDI3?=
 =?utf-8?B?cUl5S1o2TURYaU9SYmxKWDdLVDFZNVZYdllmWk5mNmdUelBCYTFkcDFMSWxR?=
 =?utf-8?B?KzNQbkdsTlNWQnpWMVhvR25IUE1zN2lBQUF5NzBkdFQveTZpellLNEEzS05O?=
 =?utf-8?B?VzNIUm9KMGRtRG9aUDBsZ0FxaWNURWJ5d05nSnp1dzdlK1NwU1VwVXBoUWpI?=
 =?utf-8?B?dDk0SnJ5ci95TGlLeGh4V2hEM0lHZHZaTWowS3lCQ3lZWHJlWWhrbGlQQkhq?=
 =?utf-8?B?eG5pTGNtN1VQZXVZZTFmVUhTTGxCM3cwbkFGLzhPOThrUTB4M3hpd2hFZVhN?=
 =?utf-8?B?dUVDYjEzczBlc2Y0MEs3cFhUSEgrd2JlTnJXeDVHQmN4N1RzOHpwa09USkNJ?=
 =?utf-8?B?TmtkS1VIMGR6TFdUZDB6MlJDdU5qWTB2cEhqK2ZhNjZkamNtcHBuUW1hRWNx?=
 =?utf-8?B?N0tzUEFCTWFCUUxjb0MxV2FCS3Q0cTdRL2lKaDVYZEhuMVVpcitOZUR1N3Bt?=
 =?utf-8?B?TDBPdlFka3F5YmQ2WFZwNWFrcVVpdVlucUdBQTdpY1ZlenJHUnRGRFg3c21z?=
 =?utf-8?B?bkVIMjExYitodkZCSExaTjBXRGcycCt2T0Zvbkl4UWs0Nm1sVXZvTWFHMkJL?=
 =?utf-8?B?aHk3SWFpY2VaOU5EWWUwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2x0TUk1aGt0UHBJUmsvdGxRZll2Z0R6THp3cmUvZkRYcklOaXRrdEZkcU9p?=
 =?utf-8?B?eWR5T1d3VzN2QVpQZXJES3M0ZHY1bkJxRDVTNG9Dcjl4RVoybnlzR1JsVEJC?=
 =?utf-8?B?Wjc5VFRySFAvYTlzNmZpM2NBQ1k2clVhUVg2ZHc4QnhaQWVUYUtpWTJyRnBx?=
 =?utf-8?B?Wk1jVmhlaWtEd2JRUExXVndMREF2ZnZFNmVCaCtZQysxT0FaaTkwZHVnQmkx?=
 =?utf-8?B?OFJ6MGJBd2dKaTBTTEErSkNLc05LT3JGOTYxaHlSOEhNcHBvZmtROUJqNCt0?=
 =?utf-8?B?L2w4a0YzOXRlMUZBYmE0OWl0VGNBTVpnWDN4cS9BdGNHL2ZBTnlQbnpTM2Y3?=
 =?utf-8?B?dDlSVXVQMXZIeFkwQ1A1R1krUWFnOUdXYjc5TXNTYUJsSzR2Q1VhWFF4YW8v?=
 =?utf-8?B?ZVpBZVM1NlNYby9qVXI4dlRmek81UFFNM1ZQVzJlczdCTy94MDVqaE5XeUV4?=
 =?utf-8?B?ZUk0Y2xDUXRMNGh0Ui8xbXZtMEtKN092ZFdTS0lkcDVqeVhUdFFyUHN1TGVM?=
 =?utf-8?B?ZFl3TlB0ZEJ1OElYOXBRamZxZndocXV5eTZ2c3NWRjJ2YkkrYkZNUWUvU3pz?=
 =?utf-8?B?UmJIcHFldEtXb21XTUtySnBaRXQySS9iOHdReStYbUNnSG9xRkQ0Q0lMNnlT?=
 =?utf-8?B?dzdXN3ZoVFJTOVpidUpvOTdJKzlkY3NOc004WnF3Ky9PSThjOGZneFpYWGFM?=
 =?utf-8?B?MnFkbkNJUTJoWjZNUGVGRFd0NEE4UDRlbVoyUHhhSHlicXNVSE84K3h5a1F5?=
 =?utf-8?B?ZzBzSDRPNHk5NzVwMCsxWnRKTyt5SXNzTC95ZmxuR0w3MGZUQkI2VUZuRGtt?=
 =?utf-8?B?c2c0dnIzL3BLMFBWYVIycmhtMHNIdC9RNTVoN2NtZ0U5ckdhbWlSU2ZJcXlQ?=
 =?utf-8?B?RHQrUUNPSVpDZEF2VHNUN29EaWZYY29TZFBnL1RucStIMHowZzFGcW83VXlP?=
 =?utf-8?B?aU0yc0M5MlhKcXJ5bitNK3Z6aDRlV1lGczF2ditUL20wMy9pUy9GTGR2QlNJ?=
 =?utf-8?B?ZmxLRnFjR1RVQzZIY0N1bjRMYVFMK2hhYXBZakdUdis1bjROcDQzMHpnK0VQ?=
 =?utf-8?B?Ni9ya2NKemV5NWtMWm9lbEFCNXIybUZrT3hHQU1zVVV0T25DQ3RiOVFpSllL?=
 =?utf-8?B?dkZVMC8yZGRGL21RcVhnRC9QbjdabXlxMzF3YXRTSGRseEhwVlpEZ3JLUFlG?=
 =?utf-8?B?TGFiK1lnaXJWOWF1WHg0ZDNrVnNZR2pVYWhoMkZqcTBNOVZhTG1xMnllODk5?=
 =?utf-8?B?ZmFLdkp0amZUSWdzSUVoNU1lTER5NDJPWHZ2N0FObDRXTEZRcUs3M0NzUmkv?=
 =?utf-8?B?MWtKeHhBaWlPb1lQSjBVanB3eEc2U1NTUzYzRzIxZitNTDlqUHVZSVk0TEtN?=
 =?utf-8?B?RTZLRkcxR0tZZm15MXhkdDBGSGtYNzdDYS82Vk1NT2JFUmxjc1lGZWhzSVpu?=
 =?utf-8?B?WHlYT0NVb1B3NE5EYkkzdTZxbG1scFNybW8zUzJqcU5ZWGZuekRGUVEyUHNG?=
 =?utf-8?B?bDg3TFViaHJONk8yOC9UL01PaEVyaHdDMGM3cDA4RmY3OUc2bTJVbWR0QzVi?=
 =?utf-8?B?aVYrZmxjL3NzVnFLV0JMSFRpazIxa0hmNEZGb1JlMGwzTFd3M20wOVhyeWhK?=
 =?utf-8?B?ZmFEWTVmZmJCVU1MaFozMVlhMXFBa0lxbll6dWRPN0R0TWtsak9rSFdsSlYr?=
 =?utf-8?B?SG9NaitCVFlOKzkrT1h6Y21qbmxDa0tiZVgycmowaXZVeWZTM1JDUHF1WU9C?=
 =?utf-8?B?MDNUN2JjNFl1VmxMZ0ZkUjJiYXJIck9QSloza21QQ0tPb01LV2Y1TVlyUVJJ?=
 =?utf-8?B?OVJSeDNCTlBOeDduTFdvSmxUU05FQW5SbWhlK2F4NmJibUJiMFhhUWgrK3Z3?=
 =?utf-8?B?c0VVRUJFd2tEaGg0TjdnS2hmaGFBV0oxV21RWjZUcFBPcFE5UWxlU3Bnd0dm?=
 =?utf-8?B?MHprQ2JRWVdVbi96b01sbXNmSHh3Zy9aeUI3MkpucVloWlhoR2NRQ1psWnBs?=
 =?utf-8?B?WmNyYldXN3NocmxSam5POWlORTVwdDFqMUxNTDBtTGNsdGJNMDhITnQ0OVQx?=
 =?utf-8?B?VTFIYXVEZVVrOFozQm9xa2ZDRnRRbElQQXlGL01DWmRrVHN6bjQyZzZZeDFm?=
 =?utf-8?Q?KWkTGdG9p563z6t0MrPcpWgzG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 248e7ce2-2bd6-45c9-445c-08dd1f6cdb4c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:04:15.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDzZztwMuKOx7l7Kqgj9kwrJT4HYRPylHM33tKh8m3i+WSjRUphWRSCzJ+GgPq6ezwgOyjJRpDkA1Q4N5Z8icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com



On 18/12/2024 9:00 am, tip-bot2 for Dave Hansen wrote:
> The following commit has been merged into the x86/cpu branch of tip:
> 
> Commit-ID:     064e8b122b65525115c4c2f181bd2ea33265e0c6
> Gitweb:        https://git.kernel.org/tip/064e8b122b65525115c4c2f181bd2ea33265e0c6
> Author:        Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate:    Fri, 13 Dec 2024 10:51:32 -08:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Tue, 17 Dec 2024 16:19:57 -08:00
> 
> x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'
> 
> The AMD erratum 1386 detection code uses and old style 'x86_cpu_desc'
> table. Replace it with 'x86_cpu_id' so the old style can be removed.
> 
> I did not create a new helper macro here. The new table is certainly
> more noisy than the old and it can be improved on. But I was hesitant
> to create a new macro just for a single site that is only two ugly
> lines in the end.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

Hi Dave,

Just let you know there's a duplicated SoB here.

