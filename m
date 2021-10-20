Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7451D434BD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTNPK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:15:10 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:32447
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229702AbhJTNPK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaNGtYCG4qnxpwuHQ0FrYCbqzHZNskGPJECpIXs/ALuusSS/XPM66I53RkQmgUMBLB/dJQQxEyBkSJv3817CG73czrMpA8S3ITFKLtQ19UtGy4nmsfwKb954nkj5bUq+8Lm491+GGdVbEiVGHv3nksT27/fC72NOdpRryjkBj0D5tPMHKFOyI8S/7s5l40luD/fHyJkTI2MUG6Y9w7W34Q7V1kfm2wx8t0AOoCjlfkNA/PqZScBShjzHlCreQhTdlb8AMJBY4iPHi179/HMCU5AhcpHtCZ+5sVlORo16TMeCJagHdsJqeObpCSMFnnjECOTAMKDF6T+MW6uOMzvX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lukg33dr/BYEv3VPL/MpReN2eE5Z4bcDOwdkeQ+DPuc=;
 b=WzkWaMWnitVppv0hMjD3QYMfZ8b6H04FB5AqzNlpV5Q6TkG1fzTclJjJCmIlRcfTXWHbGr0g+vBBlVkyFiy8GDXXQy879eNrt+0DfWatWfrjf0RnVh/s1+veNNlvI+spc/NSxFvh/YblOJjIehBg1kq/9FRDrv7K3raZ3Z61MA4vpX4HbrfxbxY8A6b+Al1yjWwpTysOHco7arMhZB8vZ6VZlGWFr515FTS9yxTa68utRzg+rCsPph96UQBKiiCjtC6QD8MxO3Pfmd+UVCCvjLVAh0WzQNP2Rbmkeg24SY+pGIfRm0kywjBYCC6wPP4tXxazaad5cfgh7eVPQTH6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lukg33dr/BYEv3VPL/MpReN2eE5Z4bcDOwdkeQ+DPuc=;
 b=1sIKyf18J375hm+Ox9PmsMZnoAyBOLa0/6sDy+tRwtBPXSMr+W5uSUQu97uPxNaq7EGKk/f7jsfjCkpiXuFEV9illBSXcq6AtoliXt1ucQ95TRs5tq7zeGcFJgVx6BWMIoNxNVYCujHIV5eLwoctxQekTgJBfUcY0g3q7RXSs1Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Wed, 20 Oct 2021 13:12:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 13:12:53 +0000
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
Date:   Wed, 20 Oct 2021 08:12:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by CH2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:610:5b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 13:12:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd17d29-43cd-495e-fea5-08d993cb5355
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-Microsoft-Antispam-PRVS: <DM8PR12MB543198A2E6BC5261FDFE65E9ECBE9@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0sRNqsiRkaYXOfyXyEV056Ww9R3svrCnoM65TDVLZbwjpbvtJThrtFUNWpUoaVkoSUY6Tk8LZXPac25dKRAnUtzvFUPdYUqJkwAQzp27zqhAqx+uNurTnzCSdz91XgaswTfNMoUkA4rZnvbWQ/AcVjFx+ozajZAojY6awwS3gbznPlcWry9mueyGjqxKPep0RtMNSuMIxxsBfXsGrBiW/uLTZhq8b4tWnRJXscMPwt3A9fLsh7hGAH7vVHYPJkA78Opf2S9YYjlayukbZfPsmy39iOZdQQXOu6kPy6Ts94AQMeFY4d3lFACful43dZAEdY0+ZkBzNhVh9ZVxBLqHfwXN24IlSSY7Kk1PlkOpuMtSFofaBMdyDvho2esv+OYQ65ax6UlKRCYqYXxcbJtacZs7qtZuC1dmwzdZuqSRTH7vTN473NEUHxT8JDomnd89bBniIE5YDcfx3VQ0yIb0j0ENhT66jIiemMFGBA9rf/RjurH2v8Yt+8CMGnzJSuJolvU3BsYh8qNyLU4lA4aBOpdBEmhnUw5mSdG92vLnnqoaM5XQ4C5QzVGzyFrjbOpVG2AYzK294sdZ9LrFoO+9LRDbJ7ZEVZFadxnhWjDcqMr21vOpMROtiKG3i0MU7LnSB1o60sFyR+TWzJKLAvswp466AUjHvCX3tLpxOWX/TI7uNMsUPUTuLVyQVKS3HSUag0Yx3TFqMF44NTn9vqpXbeN7Q37HcJ4EHX9NlGLgziFbz96KM6CZ051ERAMCfr6o/LFBb5eQfHQGQRVc5ogpsj6G+dvixTtvgQ3Z4M5lAh9TyGakOE4ljy1UTVXtedfisAHsgJNxaLUWPfWYUkbqMLyKnPaDb6T1q4WXRmLL8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(956004)(66476007)(2906002)(8936002)(36756003)(6486002)(5660300002)(83380400001)(2616005)(4326008)(31686004)(54906003)(186003)(16576012)(31696002)(8676002)(26005)(966005)(38100700002)(508600001)(53546011)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3l5NjB4Q29jbXZIVlE0UjVkYkhnaDdDWWxnNnhlcHpoUjIxTFpzemowRGNo?=
 =?utf-8?B?UTFueW13cGoxci80anpRV0MzRG5oZW9OWDJJa1Q0NjRNbkZOZ0lSaCszYnAz?=
 =?utf-8?B?UzY5amRMclZNN20yOTVGaWtudE8zbXdNZWphalpwNjJ0ODZBblZRSGdDZDAv?=
 =?utf-8?B?NEFON3FqRVpuWWJnS0hqaVdLdXN4SFI3QXZKZ3JRcW94R1ZicUZjNVBubDBN?=
 =?utf-8?B?bVZ5ZTVzN0NmcFViMHRKdlZBdmNnQ2dWMWNUcDdPY2FPdmk4Y1FHNkhjVHAw?=
 =?utf-8?B?NFczY2VKOEMrTnhQWUlqWUdXMGt4emhrbkZEQkVFa2FxcDlqUFpCMnQyaWhw?=
 =?utf-8?B?aTZrSzB0bWZqb3pveFdPSElWeHBybEhtcWZvVU40RkhhVGx1dmJlUUdUbEFF?=
 =?utf-8?B?SkhGSTliR0hjS2huYTN2a24rOE05aDZaL1ZZTkRPQkNrdkFWWGVRcFhKakZi?=
 =?utf-8?B?WFVvMDV5M3ROL3hEZDJZcTFBS2tlYVBRcW1peVlqMGRybURUZkZCVGZBWFBu?=
 =?utf-8?B?SWtsb2xJVDNWWU9rL0s3RHNySC9iK2dtVTF6czl2cVdOdzhWUDZsUlZUMkVt?=
 =?utf-8?B?Smk2cXY0KzBsZVdMalZGSXhhU3U2TTRXUTd4c0J2UytQN2U1MzdhdjFDNDFj?=
 =?utf-8?B?QW1zaUpYWmdxbkRtcUUvaFVndmdFaGs0Z0NwTUlUUDEySy94VXljWll2ZmQv?=
 =?utf-8?B?ajNnYUtyRUVaK0d5VkdRYXFiMEIvL25VcnoxRzNKZUFtOThZSHhpQnhBZXI3?=
 =?utf-8?B?RFAyWWRjaVo3NW1jNkFvL3JBYlVxU2V4TUhHQWQzNGJLYkZJcFRVYlp4bFdk?=
 =?utf-8?B?NTNUVkJjZG5oeENud1BTVmJWblEyRmJXQzQydVRRcXROazJHNUFFL3ZGZEJD?=
 =?utf-8?B?Y0tWM0FMLzNJei9aa1lacFYzWExLUjFUVkd3QzVKWWIrQStLeHdDVjRUbDh1?=
 =?utf-8?B?UWZtenVDR3N5WFRvcWlhT0xESUdGQlBXSHcvZlhRc3JQK25sN3RtaUlGMzhM?=
 =?utf-8?B?MWt5a2VSRkNBb2tiVk1sZ3A5S2xVd0ZxQWtJYTNLYU45eS85QmRtMUx4VER3?=
 =?utf-8?B?bTgzMUdkTmF5ekxZaFFWekpmY3paalVnOGY2a1RvNWw3dzQ2VkJEa1J5VWNw?=
 =?utf-8?B?cWNhRWlmSmJlVldOMXVxL3I4bnUwK3FBYkNTZXhLZmY2cWVIUmVwWTg3SEE1?=
 =?utf-8?B?NUxNMjAzVWppWWpCeWF0U0RmRjlhY1hIc3NFV2tKYTY5SjQwZldneXpoZmVs?=
 =?utf-8?B?bzlRSk1YK3RQb2dVeGY0U3I4N1hENzE0elJzV1NDZEpIWDBJRjVTUlJOK0t0?=
 =?utf-8?B?V2JkaVBWUTJQK0VwaTVDQnB0VmxhQjlNbWZnbHYwdGNETkRJWURtZEtTSk05?=
 =?utf-8?B?UUFqMk5IaGhSc2p0UytuUTNrZmJDUWhFaVhUcVJHanplMlgrV2VXTWltYUFu?=
 =?utf-8?B?VHZEODZ5U2d2SUhrL3M1TVFWZVNQbFo5Vy8ycGplR2Nzamp5NGJxTEVNMy84?=
 =?utf-8?B?U0JTb1YycTRYOFF5aStZTE45TWtSNzltSVNEZGhPRDlmU0J1ak9CWENueDcy?=
 =?utf-8?B?OHNJbnhTNzFkU05KL21UVXFNY2lqWW95b3o4U3NlREZQMjN4bWc2aFJINVBs?=
 =?utf-8?B?ZG1oei8zQzJqeWFTdmJOT0wxL216bW5YTUtMVnVobVUzWUNtVWlxQWxwZEk0?=
 =?utf-8?B?Y3NGeHZDRisxNVZ0azZXZ0ZmYXlhZUxoWlFYVW9Sb094dVJzQm5zSEJlT2Fs?=
 =?utf-8?B?aitySmZsY2kvVmcxUHVtUHNsQ1IwRzR5SHhsY1VVZ0wrM0dRb1p5ckxkb24y?=
 =?utf-8?B?NnhtU2xCdXA3UkRqTFNPVGludDdYcFhvdWp4S2luUlBOYmF1V1hadUwwOUhB?=
 =?utf-8?B?WUVnNTk0eUZrc3k0YU5jaWlIY0o1MVlvOEFJbTNLQTRIN3Y5NDA1MjhXTVNE?=
 =?utf-8?B?SExNNndQOG0yMS8xSnh4czg0WUpYTm95cE5uUmdGaEJ2elRoTTBpdFF2VmFq?=
 =?utf-8?B?SVdZejZ4TzE2eElKV2lsVmpibmhHb0ZiNkpMV3NEQVR0a1BIZXhoMDgwTUhC?=
 =?utf-8?B?Uk1SaDhrV0p4VCtRV1FmZEJpT1NyN1RxQVg5N1VrNzJiWTlVOElCejVjeitO?=
 =?utf-8?B?K1oycDU2YkVGRmprYWV6QjhyM1dQbUY5Z05GWThMS2ZnRVZmYWw5YUlKRHdV?=
 =?utf-8?Q?NJdDQ2CJNUV/jGg/6Tl6aSs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd17d29-43cd-495e-fea5-08d993cb5355
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:12:53.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Th7q4xTV1if94NmBjeXWdI/jck+zQSiPGakiGB802w7aWOTJrowUuXGIZbWbWbM8vrtanbRXMEkVOdPT9hVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 10/15/21 4:44 AM, tip-bot2 for Tim Chen wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     66558b730f2533cc2bf2b74d51f5f80b81e2bad0
> Gitweb:        https://git.kernel.org/tip/66558b730f2533cc2bf2b74d51f5f80b81e2bad0
> Author:        Tim Chen <tim.c.chen@linux.intel.com>
> AuthorDate:    Fri, 24 Sep 2021 20:51:04 +12:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 15 Oct 2021 11:25:16 +02:00
> 
> sched: Add cluster scheduler level for x86
> 
> There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce is
> shared among a cluster of cores instead of being exclusive to one
> single core.
> 
> To prevent oversubscription of L2 cache, load should be balanced
> between such L2 clusters, especially for tasks with no shared data.
> On benchmark such as SPECrate mcf test, this change provides a boost
> to performance especially on medium load system on Jacobsville.  on a
> Jacobsville that has 24 Atom cores, arranged into 6 clusters of 4
> cores each, the benchmark number is as follow:
> 
>   Improvement over baseline kernel for mcf_r
>   copies		run time	base rate
>   1		-0.1%		-0.2%
>   6		25.1%		25.1%
>   12		18.8%		19.0%
>   24		0.3%		0.3%
> 
> So this looks pretty good. In terms of the system's task distribution,
> some pretty bad clumping can be seen for the vanilla kernel without
> the L2 cluster domain for the 6 and 12 copies case. With the extra
> domain for cluster, the load does get evened out between the clusters.
> 
> Note this patch isn't an universal win as spreading isn't necessarily
> a win, particually for those workload who can benefit from packing.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20210924085104.44806-4-21cnbao@gmail.com

I've bisected to this patch which now results in my EPYC systems issuing a 
lot of:

[    4.788480] BUG: arch topology borken
[    4.789578]      the SMT domain not a subset of the CLS domain

messages (one for each CPU in the system).

I haven't had a chance to dig deeper and understand everything, does 
anyone have some quick insights/ideas?

Thanks,
Tom

