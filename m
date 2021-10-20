Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9495B4354CB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 22:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTUyL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 16:54:11 -0400
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:20704
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229695AbhJTUyK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 16:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4xrashCivSH/9aGcGpYxGLyicgewtnXJ5r96eBsgjs4d2l/iwq/qVAIdkbElkCeNysdfq7tbLE/se87k58IDdkQrYdghB1MWkhZ0DHbtAWiIfM0rGt/TY3VRqoFO9e6JENhkTeNPVwRisbhFJGzhKzTArW3LmCfP5yRIcA+dHCYXtGNz/GW5nPrrBK7AXnWfp6lyAnQ4mRecpHWX5qrJlL/Xv6OgmItk5NzZXiGxgQfqi2c8XrLiMklgk3+oA/qGblAQ+HQtUjAnqNEJWstpChkFSjkbkUH/Z7O9mYP4UxRTuTRh0ixYOGG+b904r3xpYgitVNdLumbeePDe7dyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+F0o5VWC5oAZLWOch/5PFDCFP+9QKQJLU2eX+X44Zg=;
 b=ge3HOlDD0njugQZuxZ5C+hzHIPPN4KQN/UaFgJlt3whd8/fA/wX7cLL06KJSeohql3xM0Q66oTG9x/8j64NmKuuOLmuVVbcSYsCBEuaziiir9FYcSRxvaMbVXBk2XtFe96sAKV7E0QciTU4OayrQy4xhdfBSnVwOJelNbpFZSV6l+QTyf7wmwqTWSPJfre+HOudPR8awxmOiG51tyQ/h5DghkZsynsyLcSQoQq6p/J88iAbDWPdV8qyeZoBvJtpQfvZwxEB/Q2iKa25QFi54r+1SQpreC1icj3MLXzc+C2srSrKpJ55oet+u9wkO3Oee0T/zTiRJOE2yDmXjNY3ZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+F0o5VWC5oAZLWOch/5PFDCFP+9QKQJLU2eX+X44Zg=;
 b=rDJKlcZ4+EfhT6PZ/3MLH1zTMbxc1yyKpdmde7lg4HtzdUYb5R0qgsJRXMeSlfEGqVYZyZJnLhMC3l9tF0O4TCuIQoixgFGyUyQLpzBHLeE2Urb+BhEr2nfKjSuS2Fkabf1m+QH+xhKGy+Uj1Yvi5vcDQp4g5U5nGio5xQUSoU0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 20:51:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 20:51:53 +0000
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
To:     Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
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
Message-ID: <5b41ee5e-e85c-3b67-85b4-698bb5925aeb@amd.com>
Date:   Wed, 20 Oct 2021 15:51:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211020204056.GD174730@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 20:51:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a0eaed-b399-4d31-ae43-08d9940b7253
X-MS-TrafficTypeDiagnostic: DM4PR12MB5197:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5197BEBCB8A3B1C62386B757ECBE9@DM4PR12MB5197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2fI5yEdba1g/ksgU1UU3yaEqgvtjSzZsL8SAXfWjSvbV1rNScOs5qgly0ZVoO4p6uxqhOLWvFLT9oJWqz4xFXXE5fEJ/dDgoQ6U+BWJAY71nROY7l0XhrbjJz3YR97bQLL6/vzSe1Z+YvCGY3RHaEGVIka/dP6U8eG/lGO5W1UjKnVPSw7brcuP6uAdh0rrvWMrp5DOCGUXAxDiBQDNOmmEv5CpZVdQyLPifALat2zKE2GgfW0EizkP9cdQPFG8Z3ofMfTKoCynrwuUhVqWhIV9AIUZsQGRPF36tADrW2mzfD7MvAUOPLY55CIDs8KcOM9SOzqj6qFiCmRrAuFsGOCmyDTpSC6NsYAWUXBRHspwtEYTv2RPmAoxmA5rDQ6HM+c1Ke8lEQQ8eZntB0pyJhFhfhqSBtIlOFTr6HJ2BYIz5L0MpbkeRmTulCj5398zq/v+0+4x37CGw1hbse47KImQvGfw71dgLYiuI29rk+CFCDeQwRiDwnMuIKg54UCdD15S+qxxj2bMG6ElnnQQ8OV4V67C4tQqI2EDsAe6fHlggGu78HTZCi0rUo3aI8uNEVdu9r/dHyja9chp/7aCf34WFFzT0THjqXLGph7vJG2BLZh83BS7RkaILZQiMHrWWRobrqY6DZwB5qdc+OAv/057+KUgBsBtv4aiu/Xfs2Q8Vx6sm3Qfsm67ugI6Rl7NhA5suTpuNxb34NenTdb/eLPmGha3WlaZ0LuXb+C4Rl1+R6w97cheHl8z33RdFCLS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(6636002)(66476007)(26005)(508600001)(6486002)(31686004)(110136005)(66556008)(54906003)(4326008)(66946007)(5660300002)(31696002)(2616005)(956004)(38100700002)(2906002)(83380400001)(8676002)(8936002)(186003)(36756003)(316002)(86362001)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTVYcG9EWFQ1MndrbHdaWkVoSVZGZnBZR0VVd01VdkxHeFZKSDQ1VUl6bXVS?=
 =?utf-8?B?RUdzQ01ScDUrcWVFenA0ZEpyMk93SlJoRDFDREQvMC9OM054UDRRK3JWWHZI?=
 =?utf-8?B?aGN3VzIyQy9udTJvZkxwcmZZamh5TGFMWWw1YTJwRmZIeDNKUnFMejRGa0Vr?=
 =?utf-8?B?OFh2VkxxaTJybkQxa1cxSGZiWUNmSWw0YXJGYXpRVTQ3SnZVcEtndnFnUytY?=
 =?utf-8?B?WGczTExGOHZPd1pVYmR6WTlCZzNNcmJDdjgrNDhJdDhBdVMyKzRaTHZweFBI?=
 =?utf-8?B?ZjcyaXJ4QUdYNEY3WmxvWDRXa016eVdSSVlkVVl5aHVJTzNBWU9GZWc2eHBu?=
 =?utf-8?B?bDI0ZHNPTnlEaGtiM0szNU9rSkcwQnBOWlVidTJ4Z2t5SDdBcFBLQmlsQnpk?=
 =?utf-8?B?MFVsUVo4MU1zQjVtZFFCT1FDYVMvU0o3S2k4YmJtdGU3Q2g5azgyZkxjbVdk?=
 =?utf-8?B?dkRHS0w0QlhWVVpiekZEcWpuUnpiSTJwN0tpbXU2K2RTaGI3OHR3VWpGQlFm?=
 =?utf-8?B?d21iZWdWeERWRm5kT0F6VkV0TzZyZ0FvNy9ocWhtSDRDWng5UXlsZ3dsSStt?=
 =?utf-8?B?NHhGK1pKTXdWa0tQZ3k2MStldEFYeVNRYTFVbWl5cDl2WkoyUXZTcTdJZTZy?=
 =?utf-8?B?a2VoRFEwaUI1U2pzYXB5L0JtUVVFZ3BWaEtBeGUvUGlVWlhYSEgzZ3JPckZk?=
 =?utf-8?B?dG1LVE1iczNkMStrelhmZDNhN0MxSW5OTlVzd0ZNSEprRkx6dFZOUUdTaFNN?=
 =?utf-8?B?VUNtdzJHV0RCZ3oyajBFb2J6TFRTYkdTcFYzUHJickM5dXROZmpGbnFrY3VC?=
 =?utf-8?B?UmRwaVJWYjhGRkJZYkNIdWtnQ0R3Vk11VmpCaFo3bldVNWdjUSs4OVZuYlFj?=
 =?utf-8?B?eGdMTS9RZTZYT0RaOFpDOU1jTEVZNzBIS1hHOTdVUzJ6Vmo2TkpQUWVkV1h6?=
 =?utf-8?B?N3N1UGFiaHQ0eSs2VW5FU0xSL0ZYcDQ2eDdDZU1HWjdxU3JhUmkvSDVRb2oy?=
 =?utf-8?B?a2FtaS9hQzY0ekN2Q1F4M3FBakxjOXhqL2oyL2cxc3F4dGdwa2pVRFBJQkN0?=
 =?utf-8?B?ZDV1clhiemp6UytJQktxNWhEeGsvMmRUR0tnVE5XdjM1MHlZY24rNTlMYXg1?=
 =?utf-8?B?ZjBZVlBOTW9lMHlPOEFXN3A1cmlNcTRiYUIrd2FzZ01ob0pKUndjVFU1MVk4?=
 =?utf-8?B?WkVLeHRhWmRmdFljS2RpWm5lUDJsTnFQcHBUdXY1SzVwSTdZQUZqcWEycDdp?=
 =?utf-8?B?OWFnbjQza3lpUW9NYk5RdWROR3ZEeC9mengrTE92eWExTm9jbml4NkdFOW5H?=
 =?utf-8?B?emFsWGhiMFd4Z1Z6WDB5d1M3UmJtTlAvTjV4WnRLYmt5YStGQmduQzNzRENQ?=
 =?utf-8?B?K3U5TWwxWGJvQXlVRXlzWjdoS3BXWno3S05HU3NNRS9qQUNpZExRdHMzQVpM?=
 =?utf-8?B?S0QwV2MzVGpBaWFNbUYwSDN4RGdKYUdlRlhuNXZ0THhKN1grekYzZmpqTVdP?=
 =?utf-8?B?cUVYRWNJVzFXeUJUUHR2QlVtRmMwWVMweVE0R0VnRW83bXlnMUNyVHdVQzhv?=
 =?utf-8?B?a1U3QndIWGRaYW5EWHloTlc1cmpTeHJQZmZZSWlsRFNkbnF3YUl6SU1rVXUz?=
 =?utf-8?B?S1JZUHVZQkIwd2NmOGJrSzlnRlc1Yy9LdXpaZkJaT2N0UTZ3SEppZVlDOGlH?=
 =?utf-8?B?cTRxUno3eFNnVG1kUjFzL1ZhNmU0SzVveFp4RzFHeU5lYVVUWm52a0UzcVJ6?=
 =?utf-8?B?TWJQcHQ0VExWbmdyNlBlczFqS0VNMUp6ajMyK0FrWGxQdUxkME9XTzhKbTRV?=
 =?utf-8?B?SWVFdEkycjNIcU54TjlWTjhJcGRjLzlFZFR5c0djYXpNYlJlbjBzQ3U2NHlE?=
 =?utf-8?B?ejNVZkgwa2NyOFNYNE4xMEk2RE9xejVoMlJpVldoemt4c0t6eTlFdEt6MUUv?=
 =?utf-8?Q?gY7YR8CFtoQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a0eaed-b399-4d31-ae43-08d9940b7253
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 20:51:53.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
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
>   
>   	/* Do not match if L2 cache id does not match: */
>   	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
> 

Adding Suravee.
