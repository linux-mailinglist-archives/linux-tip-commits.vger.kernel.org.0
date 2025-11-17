Return-Path: <linux-tip-commits+bounces-7381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D5C65DF0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 20:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 658AF4ECE88
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BA335541;
	Mon, 17 Nov 2025 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cm0wDcH5"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CB84039;
	Mon, 17 Nov 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406058; cv=fail; b=TzuUCXVz6DgQBH8LFsYKB+HzrKkeyeKCO7ioc3CIN1f5ErhK9mInNhKIdnFIWhg+7nNL7ok4yN/vcTenjEXTN3hTkQvsS4tkBz1+VwcGyrr4dD+lTCbrT9zVbbDA6XHByA/hcmPTn2zpO00gFXJ728F4TocQ8hhzsO2oV6/nuOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406058; c=relaxed/simple;
	bh=jUD92756NESaunRFO1fhZuepDrwc6ZsPp0U7tyDkJZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qMtAM++UZfPfTo3ud3Vk4EoOOmE6s4hL5GAvnpU9rM81NtCfmvxR8gONquKrHzNJKce7Pcs1MEDthRyGynba1EcVGUiWp8snsORxrr/+vT9zUkcx0eZyMshLEyzsxneL/QazCC2YQfbHBk0CK/OiOduMTYJEYZub0jR1UrWmgQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cm0wDcH5; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp0wCpd1EMVBYRacnPEp3WNYhPWCN+8VpI1WE3hr1EpUHMqpce7PruJ/BYJVK3jX/8mX3cM7uFKm8w+W8LXS908svpQ3vCNX01YRWcit5we+gfahOWD/Hp8vH5FDWyO2gZonHEeK/6kuWntqa9DnerUFx4cSqZTfuy7k3x97g9Oj828YEmAa50OuK4lFqJGsIqPqqlNsB2jTBe0Y23tloMtPetp/YOFnxmafLY1MUtBljGITYcGeNW4lZvT6SgM0IUn5e/CJy2iBUAO9jwUa5AA99WvImbnYUaINFEIpVCuN2Iv+hQPnaFwQkQ4Md2eh7KJU5NhRyd6Cu7g8e1hDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25mktRR/FSAF4YJ+ghEOwzwnIBEPiyc5NeUKBQn6E2A=;
 b=a3wSawCuNh24v83AizMqGDYZ9/ajK3GahQ/bvQcFxHIisc0igZmf3L/IopA0pX4cQvm79bn7ZkNWo4ZeaHCSC9hDJ2jwHgOcjWYiC7onD/JQaqwKl0puF0LFZKOfCaec3rlpk21ep50WtL8EhMJ8VUFAH2O/1yQn0vY8Tm8UsCmbFSIzHyENmdhXCehJGPqfkoqv1/cyrSciUuEyUlDwpCs0iXGNTNRhpuDyllm+DYjh9Ayftgw/BdfgoJ0fqsTHscHKSDWKmG4hAC3WQfHCTmz+ZWQmBL8kV0Ps9bx+rsQLVO4GoIST0BMimC5eWSfXaPgyUt9kINoIIozy9bC4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25mktRR/FSAF4YJ+ghEOwzwnIBEPiyc5NeUKBQn6E2A=;
 b=Cm0wDcH5o99V58wHq0AisBFVZgGVMjeTD9x3/ZgKtsvLCF9aU4qfJDfctJU8WCD7nKNeTzwrDt1lLdiEnih63msnL5AcDnbhrNo8+rWrDxiBFsLiakB+X/VzH1VUrJyx1TSqPIyeRFCUbZaR0Bqgfv/BQgt20grDxQMjK9rzIVM=
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 19:00:48 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::3a) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 19:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 19:00:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 11:00:45 -0800
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 17 Nov 2025 11:00:42 -0800
Message-ID: <7099a373-8d6c-4c67-806c-84b50315f160@amd.com>
Date: Tue, 18 Nov 2025 00:30:36 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Tim Chen <tim.c.chen@linux.intel.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>
CC: <linux-tip-commits@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Srikar Dronamraju
	<srikar@linux.ibm.com>, Mohini Narkhede <mohini.narkhede@intel.com>,
	<x86@kernel.org>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
 <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: e2089910-025f-4e25-1dd5-08de260b9e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bExLSmFZK2sybUVqdVFwbGkzUVd6VjY2WHhsU3BlMEZDS3JYZmMvTjQzRktY?=
 =?utf-8?B?V3BsamdPbmhLNElsZmZoNXVKYkN2RVBJM3NYZ3JGSnZuYUxYa242L2xiN0lt?=
 =?utf-8?B?a2U3NkNaRHFVOFBMQTJ1RHAwbUEyaGpXTTFNZTJMWG0xOVJ4SWpjWDNGbmNE?=
 =?utf-8?B?T0lvMFhiektqeklrRXFkU1AwMEp3SmxkQUJYM3NZOE14YWlkQlFLSHJFbVBE?=
 =?utf-8?B?ckVnMk91bmw0Vm9FeUNqQ1lSMUZ4Mks5aXhyNjNPVWZxVDRSb3RPZzllMVd2?=
 =?utf-8?B?cWdGOWhzdDVoRXprekZtMi9TbHBha1B2OTd2Zk9aQlh0NUIwZWdZZnNMVnV6?=
 =?utf-8?B?QTYvUzUxZnJpWXUvenNhNEFzM25JUDY5VndmazFTRGVCeGZqK2g2cnJBcnZr?=
 =?utf-8?B?SDNrMzRNa1FNSUdWdElZdFNsWVB0YVVPZFZ6RllKUmh0azlscXY3eldacm8r?=
 =?utf-8?B?YndQZkdhZml3MU5vNVh1cWozTm9xZ2lNSEZNRkdSNVNDKzJQUVl4TC9YN1J4?=
 =?utf-8?B?V0x3Szk3S0MrZ01UZVM2M01mS0ZHbm5WRmZDVnUrc3k3M1NaOXdDOFNMbjFT?=
 =?utf-8?B?UktzYkIwNVJFTWRhMSs2VzVrV2FRSjJ4ZUl2SStSV0svM05yTGJtT2NIR1lv?=
 =?utf-8?B?aFN3QU9jTEJpQkluajZNUTFRdlJPUExKUzlxMVdXLzcrZlMwT21kM0ZaTXRC?=
 =?utf-8?B?QzFXbUw2cENYc1BUU2Nuc01kZ0lnTGt5MEZRdzhXaDV1OWtmazd3WlpzNEpG?=
 =?utf-8?B?WUFMbGZTb2E1YjdRaVUwbjh6NVA5QVhZdmtsejN3cHBWMUJzdXU2NGJFK0R3?=
 =?utf-8?B?a3dHTDJnMHdrNVFqL0NvZ3pEVXlkWFpZUVhuMzdtQkNRSitoMi9iekk0eGRI?=
 =?utf-8?B?WGttcVBMZWVXR0FvYnF0YyttT0x4L08xejR6SmJDQU96Z3gyYU9Ob3VvektS?=
 =?utf-8?B?ckg2WkVyNVovK1RobEZJR2VPZEhKMHh3UUVGeFh4UmRURGdxLzBEK0c5cCti?=
 =?utf-8?B?QjhCOUVwSWZFYWNCNllFN0Frd2VqVjFOMTlvSWEzTDNCSjg1VExhd0kxVmgy?=
 =?utf-8?B?MkJXN0JIRVZiR0R0aHJZVFJZVG5KTldHQ1lZdDljZXJPVEMyL0licjJ5NlJC?=
 =?utf-8?B?WmN5dU8rMHJkd3d5ZTZmR1RzSlpJbHAybEhJc2tTQkMyNExLSzNETDRpQzZq?=
 =?utf-8?B?eE5TRHRDR1E4QkFHQm9YVEc5RlRzdmd5MXVtVHNoajBMTU1lZkxTVGVSSmpm?=
 =?utf-8?B?akJiS2lDdnZ1cUZrV3YwZjBSMUNNN202NUV6Ynp4NDlSNHF6Q0M5VGowWVAw?=
 =?utf-8?B?U2RYOUlpNVBwaVNwciswSWRHR25YcWowdncyOW1zeThaWmxOWTJJRjhuYXhL?=
 =?utf-8?B?WFE5WFZYY2pCR2tDcDdYcVJuN0hKTGFpVXZoK2NlZ255TXg1cTkxVHZGZmgv?=
 =?utf-8?B?NkNwSUd3VlQxeTkvUGJXZ0RZWG4vYzJyUHRPaVQ5ZWJKS3QyelpaY2ZYczFV?=
 =?utf-8?B?akVxZWNsUCsrUFVORmJ0bVhoMGYxdFdWNms5bTM1RW9xR0llbGxtdVFleTVY?=
 =?utf-8?B?WVNJZk5yZmtkZDRtQVRKZlFVQlJvUEhMZTByYTB0eFFWdm9PMzNDdlk0M2t2?=
 =?utf-8?B?dzdaeHZnT01vU1lLQVZMdUtRQ3pUT3MxaGVJZFljUUEzTENoMlAvdGczUnND?=
 =?utf-8?B?MTNielF1UThVMWlQRHc1T3o2L3FPM09Hbyt6NjJickNsMXJ6ZlNHdGpsZERF?=
 =?utf-8?B?Vm95SVdsdTlzVEpxVFl1M2RQWkJvY1dJcytza2I1WVVWNFJ2dTUxTVpzRzhs?=
 =?utf-8?B?ejlxNVBrL001STNqWDRuKzY0Rk1qVG9hcDdsRmRVU0VYM3N5Tk56Qmx4aEpV?=
 =?utf-8?B?czUxUEJEL2d3L0ZNWitFbXU1M0pxSk1FYkVZdG9EWmFsSTBsUnp6RlZ2YlJS?=
 =?utf-8?B?V0xla2ZFb004eCtjZFhqVzQxRDVIQ0Z0TVFXLzU3Lzg4SDRFTVg4cHRxQ0dF?=
 =?utf-8?B?NnJwSXFlNEtVNU5OSmk4ZTFlSjIwYUZVaCtNcitld0s3QnpvZGE3V1gwbDJB?=
 =?utf-8?B?RzRUcmpvRjViTFcwYktsNVR0VHZwcjg1SUVmMmUvM0ZuaVFvMEJyZHpnTVJn?=
 =?utf-8?Q?VeFk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:00:47.0211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2089910-025f-4e25-1dd5-08de260b9e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

On 11/18/2025 12:25 AM, Tim Chen wrote:
>> I wondered what is really different since the tim's v4 boots fine.
>> There is try instead in the tip, i think that is messing it since likely
>> we are dereferencing 0?
>>
>>
>> With this diff it boots fine.
>>
>> ---
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index aaa47ece6a8e..01814b10b833 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11841,7 +11841,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>          }
>>   
>>          if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
>> -               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> 
> The second argument of atomic_try_cmpxchg_acquire is "int *old" while that of atomic_cmpxchg_acquire
> is "int old". So the above check would result in NULL pointer access.  Probably have
> to do something like the following to use atomic_try_cmpxchg_acquire()
> 
> 		int zero = 0;
> 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))

Peter seems to have refreshed tip:sched/core with above but is
there any advantage of using atomic_try_cmpxchg_acquire() as
opposed to plain old atomic_cmpxchg_acquire() and then checking
the old value it returns?

That zero variable serves no other purpose and is a bit of an
eyesore IMO.

> 		
> Otherwise we should do atomic_cmpxchg_acquire() as below
> 
>> +               if (!atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> 
-- 
Thanks and Regards,
Prateek


