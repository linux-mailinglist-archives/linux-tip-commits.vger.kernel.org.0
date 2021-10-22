Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C39437801
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVNeB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 09:34:01 -0400
Received: from mail-dm3nam07on2047.outbound.protection.outlook.com ([40.107.95.47]:6176
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230264AbhJVNeB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 09:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFDokCtyaR/PVgOlZPNVA6MOOdDGGVhRNiitB3qGXfEvDNT+Vw+aVlEqhcPbk1SKZfE6R9ekNJpYOWEXAOF/9cD0KmWRKvFAO4WSWINjH+oC20CiQEA28bjhP18BD7QUOl61o9/758wxYxZ1iTs65F4kZOptfYCgeGdNQNcU3eVvjhG2AZtKlHNkjxL94cJePOSZxxVRfbbsLuki7D2jPjaVM4cJ74VUYBQGpZEos2B4tYBO3oDgIyE8G6vUPNKwziFMhka8Er4TArodYrh+Iaom0IwAmmTh31LabLCaHWNY6DCMsZKghnqA8S6u0DmAANoAIbXhDnTZPdriw9rGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F7tjNPAXcGT8Fnvm5w8SJFUBDeHZKJ5TQi6+4JRDvk=;
 b=hEIGs83I++X5IJYv83HoaZmLRYRyEuFEnW1tt61iveMVmPWmr0iSUVpDf9MESaT/i+YBN3oWnL038eP+ux7e9alELPcCGzB+9T7tFw4MTNVkst2jWjfjAX7cRCX3ozN8GeVTikexSe6F05nNoOBNuqEnGDui9fnsNcjyrMlCLHnSOnyKlDud2nHkc6Ha3sNdXu1ggU/+HyBZllAQV0PUa/FPy6DPjdVUg1CUPOlRyqX1cr8Q/1V//qZKBsbAmw+UTVk2Ug2Vvn09FJ7Anf6TBgPuqvUhDsouJf+W132mTC6rarz6OP0b22RgAvOWUvAhss5VvPGWZD8lHydfYcYwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F7tjNPAXcGT8Fnvm5w8SJFUBDeHZKJ5TQi6+4JRDvk=;
 b=30IHS9eja/zM9nU86b43bFP0IM5kqrwmeDXc1ZCVd5FIeEb84ABuICAkELteWvSoEAvqAkBDySmhLKj5IZudI0oqLabbojohV8MjmfEzWASNeQFF6BfolcuMqLH7LWDNT+nQf6ywENY4CmkspMR4qiLxV7nMVzJtO9YrQMczlGo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 13:31:42 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Fri, 22 Oct 2021
 13:31:42 +0000
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
To:     Peter Zijlstra <peterz@infradead.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
 <20211020204056.GD174730@worktop.programming.kicks-ass.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e3c4f4a4-fe73-dc5e-65ee-0519c868f699@amd.com>
Date:   Fri, 22 Oct 2021 08:31:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211020204056.GD174730@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7PR04CA0083.namprd04.prod.outlook.com (2603:10b6:806:121::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 13:31:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cac54c1-acda-4f55-07ae-08d9956048f9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:
X-Microsoft-Antispam-PRVS: <DM4PR12MB507022E3113F9E4B479B3D4BEC809@DM4PR12MB5070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZFTYHdHLX0uLI7gcGa1FWmCML+n95T3l3vv6Y8I762o+PnSR8DYZoJiOY0J2f0eKKW3HHI7GvbqcgeMu13up4PqJAI/sfrqAFicOXhhj5lCkAW+dsgG/eiNKOzfpPpUEodwwQc7JscZ+HteNRHd+nIZgFVph+CAHSepuchqXnrSqwa5CsiKwLX0nxdC5W+mSGM++zF4LlyS8hw30bMHs8I7YgFmfWfAEkAeGPTZU6xQxMhQt1FWxI1HSPH28qdRcyuZ29UnG+H9t9AFPVUN2XZAa/tGt1CQ68vFC+waImyEir+0uWn4AwYi5noH6QGSNfr/pfI44f2DNJgbFDSBmpydhZefYqH7fHUhLaUwF4u4Ox2qBJcczKzb+DZhThFh8cmETsJgHumcJcvUQdi/NVjJDjeZI31S/ZiYHSFv4koCUeXSbOVZ0LAh0L/cn/7Y1eaya4sXViOVZF3XgtzEE9mkXTAN0jJvwiPLABSXBxbgve4SotOJ/oSFUDIxYnoBhPd76AcXKxy8WOLue6+ZK6GQ7uuqeT5Ysb9gKDfgZHNZ5mhcgpgsbjzNAoiMrhzechyYdKWvS6jMzk2UDRK6/kRkl4fwQIFSmk08gnRxJ8g2s1VcW/FciFDiKouPSuNGwsP6ZJvgkey5fMk3GILN1r8CKl+ci0poWPBAydF321aZNs34Z80BhoLcbNfHR0t+wbQwjVHhXnC56HSeEw0eUd8gpGo2Q4haiVoFg2HJxvDG3IFfG5ckybDJW7mPe0vI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(8936002)(5660300002)(26005)(83380400001)(54906003)(86362001)(31686004)(2906002)(4326008)(186003)(31696002)(6506007)(6512007)(66556008)(53546011)(2616005)(66946007)(316002)(508600001)(36756003)(8676002)(6486002)(38100700002)(956004)(6636002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a091TUNIelZIakN3c1p0WXBHcXcrMnNDT1FxTnJxSGdKb09tWFVtNUUySVgr?=
 =?utf-8?B?VVhGSTd0YzE0d1VlSXpJd3UwNGc2S2Q1MWV6RW9iQkg4eTJ1b0ZHODNqTGVT?=
 =?utf-8?B?VlJkR2pxNC9ubVpWRW1Pams5U1VUL1VKYWhkRkU2ZEdUZWE3cWZOKzArNUpN?=
 =?utf-8?B?blFrNSsvTXF5eGxjSW5ma0lyeFpieUxDVUJqaWRwTEE2SXhxbzJncnVPUWpS?=
 =?utf-8?B?SVA4ZXdLM1ZDWnNCUFgxdUUvUXRjV3lqRDZaYVJEdXNlMldWV3c2SkI0RFkr?=
 =?utf-8?B?RVJrVHdiTmlGTUZodHVZa2dlaGdoaXl5c05Ka0I4RTlZU3VETTlhbzRLSk9I?=
 =?utf-8?B?Z3VLRDlBZER5ODFTQWo2K1BUaFdrU1NSbXJzTy94dDY5b1FTZXlDZmUreTR0?=
 =?utf-8?B?ZUh4T21BaThNbHpyRG1jV2ZrZlBjdEN2bzFFTlVQVlR5azNHeUVYMTR4OFpR?=
 =?utf-8?B?b0U2NFRIRXlIYmhYR1lxbWIwdEZCR3lpeFB2ZGZ2NTE2TlRvVHQ0N1RFVFIr?=
 =?utf-8?B?MUtwa1dmS0hrYTFHazBVUlVWVTcwZitrNkJ4cUlqMzBLSTBESkpkdDVKVktq?=
 =?utf-8?B?ak9udVh5a09XWXpuV2RhMEl5NU1YdVdqazgyYUVZVkluVk14MnhBbXRnb3BN?=
 =?utf-8?B?NFdxM3JFVVNuNUdEaDRPZjlydHlJMm81RXdTYzBPU2FIeHBSK0JyVW1aMWFB?=
 =?utf-8?B?ZTdTTFhPdWd0Q3I5SUdzeEpPL3RHeUlPS2FNN0VFek9CVmVkV2oxT0dyMUxy?=
 =?utf-8?B?aE1GcjljUlJIMjRFMWkvS3hMdGdvWHpuSE1JWmdJRkg2Sm9GSGZ4Y01yR1BW?=
 =?utf-8?B?RUsreGdpcXNBUTRaS2cvVkM0Qll3aE9WOGM4cDNtdWtaci9TL1BqeWJ3Zy85?=
 =?utf-8?B?SjkxT1NOaUd3N2x3VG92OHVycXAyY1Y5ZmNhNWMxRzhPVmZhdHNOdDkyUXQw?=
 =?utf-8?B?c05zeVo4eUNpUnhidXhiU1FXWHhnMkVyMHA0b0R1UHpQbDgyMXNyZ3Jwb2xV?=
 =?utf-8?B?Ymord2R3OXRJdDR3OE1JaHZodFJRS3dNRnA0ZE1WcjQ2VURhNE5JcEgzeFU1?=
 =?utf-8?B?ZnZnMm5PRlRZQWo1dTRRcmpNYjZycUdTRDFUdG1paHVURmU4aHZCeWJib3V0?=
 =?utf-8?B?U3dOUnI3QTUyZlFEdVBSRWhPV0dSdUdtUkxKV3hyUUdvOWdSTkVxaDVUVmIz?=
 =?utf-8?B?cmxzNHp4cG9GUS96dUVqRTBYM05JUm1rbldUT04zcVA1UXNnUUNrR1FkL2tW?=
 =?utf-8?B?QTFjQ0srOXJkOWRTajV6SVBPcmZYMUEvS0RMMUxiOXMwdzFETHpxR3pGaUNB?=
 =?utf-8?B?bmcwWW9SZnpMYlZLRVhJcTVRVUtQa3RSd1hyTlZZOENsdFlmaGVuNDRzRUIw?=
 =?utf-8?B?b0ZQTkRxaS9qK2pSQWcrUFp5K1VwTjgwb1VhVHYvL3hIc0VGNjBYdWU2UXpQ?=
 =?utf-8?B?MEFNN0h0WlJYRjgzSWZocHQxa0FhOXRQS2dlMGVxQzVBYkxzYUlzRERrWVQ1?=
 =?utf-8?B?M0pqU0U5UjJIY3JwSURVZ1p2ZmFZZ3RFa0NiN29vdzJzd3lPZE5MVnI2MlVk?=
 =?utf-8?B?eFdMcmlWYWZDYlJ0TFFkcDZpWisvNGlPK2VzZEFzTVNTcjlQajBFdlI1SDhk?=
 =?utf-8?B?TVk0NGg4YVM5YVhvNGUrMXl2bmcyZmNjQkNlZXpjNlpNS3pBdmRwMkU3REI4?=
 =?utf-8?B?YnkyU2tGS0h3U2dVb0FJdGJWYWU2Zk15KzlvRVpnTTN0L2I2OVBjWE9MN0ZW?=
 =?utf-8?B?UGdTeVBkWGk5YkhBNU1mY1dxZFRoVkVXcTNPWURmb1lxVFZPVDVhMm5jdjB2?=
 =?utf-8?B?RVIrQjZVS3dLYlVkWUUwaUZoK1RMV3lLOXRDc2N1RG4vKzEvblMyN1pTaVNk?=
 =?utf-8?B?Q01WaWduTGNVZHNycWVnL3ZMaHpBWmgyS1dQdXNzdjF0eVpZRkRaT1RablB4?=
 =?utf-8?Q?rF8LCnrMXtI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cac54c1-acda-4f55-07ae-08d9956048f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 13:31:42.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 10/20/21 3:40 PM, Peter Zijlstra wrote:
> On Wed, Oct 20, 2021 at 10:36:19PM +0200, Peter Zijlstra wrote:
> 
>> OK, I think I see what's happening.
>>
>> AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
>> means it's set to BAD_APICID.
>>
>> This then results in match_l2c() to never match. And as a direct
>> consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
>> just the one CPU set.
>>
>> And we have the above result and things come unstuck if we assume:
>>    SMT <= L2 <= LLC
>>
>> Now, the big question, how to fix this... Does AMD have means of
>> actually setting l2c_id or should we fall back to using match_smt() for
>> l2c_id == BAD_APICID ?
> 
> The latter looks something like the below and ought to make EPYC at
> least function as it did before.
> 
> 
> ---
>   arch/x86/kernel/smpboot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 849159797101..c2671b2333d1 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>   
>   	/* Do not match if we do not have a valid APICID for cpu: */
>   	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
> -		return false;
> +		return match_smt(c, o); /* assume at least SMT shares L2 */

This does eliminate the message and seems like an appropriate thing to do, 
in general, if the l2c id is not set.

We're looking into setting the l2c id for AMD platforms, but need to test 
against some older platforms. We'll let you know the results next week.

In the mean time, it is probably best to at least apply your above patch.

Thanks,
Tom

>   
>   	/* Do not match if L2 cache id does not match: */
>   	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
> 
