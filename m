Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF3405BB0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhIIREd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 13:04:33 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:57857
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234524AbhIIREd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 13:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEhZuv1uq4v6eoD2tKvFlSVS3KMhqwgFXnvszxbIfoaG12qf39QrVYBhbflyQBMSFeuKmiMurUyIBzY8VKxk1+usypYjyr7fbRxHAVZjc65M8lEWAmo9k0Dd11sQNEU7dkLoJ3VodkJwEoFgrulLB34rjjW9LUMnXbjht85DOQrRdoRwNu7sOcoAxgHF/CzGcWrYS80a3tJaX8ClYlbLurDHM8PoxkWSfBkR1FHKIJwwaz9nQdupqKS1tJo5U90d1cjd7xWJYm4m+UsynRnzUw97yFDY51OUDYrFaPjRl4oeywR6Es0z81AljHeDnF92WRmqEjfQ8d6Nkvzn9h/SRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mXOcMVkUSGD0Lz4nx0E9FpTQfSos9d8r/Y7IIZtiOPQ=;
 b=EvW5HnrjSONWtW2xQ49C8zjD22q8DfMQHfsr28rzZhtDm4KW+OZ/WHalWwDoZ93dlcFgiFxV9M7I+Mu/Zxj9sbVV23VQBNd9bVTnZMZ7wM40WX90C00h1M7D0uHM8C9bO5vvIXoViuX0kHhsGOmaqsjONshkbnvN36J3Vcq78mlfZLj657bDrN5EO7HEC7f/xOeWUtNyc5pc+BC7YO4L5Nmjl7PV34is5vAwCD9IirWUKFwX254e6dgSp5yY0ipLmRViU7EsWoGz2R3wjb21TvmUQF8W6L7QHPzv9zUgWdShOzopOMnc5ms6tdRpDR9O8/6Swr2frnkizkhgMOO6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ellerman.id.au smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXOcMVkUSGD0Lz4nx0E9FpTQfSos9d8r/Y7IIZtiOPQ=;
 b=AvKS9QpIJGuHvEmiO1tlCdGzODyv72eNv41NW9jkiY+nL2NWsjsUe4bAMMncAFxk+WcRc/erQr5x33wJOfuYowXNBZdY6J9TW9eLxeXGp2rpylvfwUIf0POKyjNOr/UJN2bKDAu1UyaPRWX7K/pIPIO4R8mkU0kcOdvL5AZ917x3mxieggygMxGcS2w0ElwPkWruBUwHMEY2ZdY6o69WbzNUCUNkQqNZ0pxw+SzLKltgLU4yxq7+aQ/X+myueNHQ1vVsdBW2gPxLF8Jwrj87A+bE4HnKAZgcuYtYmmnPYdoeDmIESad1ZzsFIkBOIuzYQeQ1FNtC895GmQDstSraZQ==
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by MWHPR1201MB0077.namprd12.prod.outlook.com (2603:10b6:301:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 17:03:21 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::76) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 17:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ellerman.id.au; dkim=none (message not signed)
 header.d=none;ellerman.id.au; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 17:03:21 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 17:03:19 +0000
Received: from [10.20.237.217] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 17:03:16 +0000
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        "Andrea Parri" <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        <linux-tip-commits@vger.kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mpe@ellerman.id.au>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
From:   Dan Lustig <dlustig@nvidia.com>
Message-ID: <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
Date:   Thu, 9 Sep 2021 13:03:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210909133535.GA9722@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5444e7-cc56-4d8d-57df-08d973b3ba5f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0077C1368C2F6B627028E557DCD59@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLNf/F4ZkPTlK9WXe75RSDJDrPaDEMWyRvTX3WymfBlBVNlGZ7UAyh4kOapB1GjTmpfFEV725aSAJ7obt1byVSAnVqc+JYBeWVVTeMWWPbd/wqX0GYZHjsMY5dHXMWB1ydGMPu+GGwJezylh3Dt5u8C03ACAdMAFi+ciJvg/UbqQSRB2mkjDZg1AFk+zSGdTPg1D2XXRDV9biQfmqTyFBP5Q/RNyMhrrubFCt5T6K0JMUA27kaPRqaQziosasbJJ6ocHqaEdXQKJLnIPfrgt5bWkmbES7amuHmEeGO9m7b2bQ9C6TNDSdewGvJyV7VDBuUHZTc/5aQlDQXNGbWgDQARDwDMKBD1im50eA4vw+x1igQgU8LQ31P4/P5/0s8PiH27v2Wf4+o7FFvwnqA19bUJkxzA+HmMrdf14ZPZwgcLx3fzMIP7wYRykMX58WhCu1m8DuaKyn5MJUrGiG5gs2Pe1l1gGvQGfdbkIMn05WxgJXFHzuoS5KUxRFYdiRKVFnG1y9f1XT3Jtv/+OLj+opl7WmDUqGOThL7Gy1gXWStUryVlCEVAg2VAJ3t1rpGzJLsxnW04QqefxF6g+mFFGPny2DkjbZjvx55ehSVN0Ck7D51cchNVCx8F8WLVgbVbhlS+p5ZdQvpMNyYRkPhKWx5+pmwmS8WjSlH9DFPgqjEpTBlPILOatnMZnBe4HdgS+yNr6Yq2L706H+2R/U4JCWyJKZHNAZlkuEEDfkS2mN4hGxmI2cWi03NmwDu2cNjWyloje4XcpgcSqQ6c+KFtxP6ZodW5JmL32Ua5Ma205e0Zdb9TIGQxLaOyajkUt539+Z5FyrBYEE5/t2CNrV9tMx2qQgP5o/dwISVgAn5z4kAk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(8676002)(16526019)(36906005)(36860700001)(316002)(82310400003)(86362001)(16576012)(36756003)(356005)(2906002)(53546011)(47076005)(4326008)(336012)(186003)(966005)(26005)(70586007)(70206006)(7636003)(7416002)(5660300002)(31686004)(54906003)(110136005)(478600001)(2616005)(82740400003)(8936002)(31696002)(83380400001)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 17:03:21.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5444e7-cc56-4d8d-57df-08d973b3ba5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 9/9/2021 9:35 AM, Will Deacon wrote:
> [+Palmer, PaulW, Daniel and Michael]
> 
> On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
>> On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
>>
>>> So if this is purely a RISC-V thing,
>>
>> Just to clarify, I think the current RISC-V thing is stonger than
>> PowerPC, but maybe not as strong as say ARM64, but RISC-V memory
>> ordering is still somewhat hazy to me.
>>
>> Specifically, the sequence:
>>
>> 	/* critical section s */
>> 	WRITE_ONCE(x, 1);
>> 	FENCE RW, W
>> 	WRITE_ONCE(s.lock, 0);		/* store S */
>> 	AMOSWAP %0, 1, r.lock		/* store R */
>> 	FENCE R, RW
>> 	WRITE_ONCE(y, 1);
>> 	/* critical section r */
>>
>> fully separates section s from section r, as in RW->RW ordering
>> (possibly not as strong as smp_mb() though), while on PowerPC it would
>> only impose TSO ordering between sections.
>>
>> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
>> similarly it marches the R from the R->RW fence, yielding an:
>>
>> 	RW->  W
>> 	    RmW
>> 	    R  ->RW
>>
>> ordering. It's the stores S and R that can be re-ordered, but not the
>> sections themselves (same on PowerPC and many others).
>>
>> Clarification from a RISC-V enabled person would be appreciated.

To first order, RISC-V's memory model is very similar to ARMv8's.  It
is "other-multi-copy-atomic", unlike Power, and respects dependencies.
It also has AMOs and LR/SC with optional RCsc acquire or release
semantics.  There's no need to worry about RISC-V somehow pushing the
boundaries of weak memory ordering in new ways.

The tricky part is that unlike ARMv8, RISC-V doesn't have load-acquire
or store-release opcodes at all.  Only AMOs and LR/SC have acquire or
release options.  That means that while certain operations like swap
can be implemented with native RCsc semantics, others like store-release
have to fall back on fences and plain writes.

That's where the complexity came up last time this was discussed, at
least as it relates to RISC-V: how to make sure the combination of RCsc
atomics and plain operations+fences gives the semantics everyone is
asking for here.  And to be clear there, I'm not asking for LKMM to
weaken anything about critical section ordering just for RISC-V's sake.
TSO/RCsc ordering between critical sections is a perfectly reasonable
model in my opinion.  I just want to make sure RISC-V gets it right
given whatever the decision is.

>>> then I think it's entirely reasonable to
>>>
>>>         spin_unlock(&r);
>>>         spin_lock(&s);
>>>
>>> cannot be reordered.
>>
>> I'm obviously completely in favour of that :-)
> 
> I don't think we should require the accesses to the actual lockwords to
> be ordered here, as it becomes pretty onerous for relaxed LL/SC
> architectures where you'd end up with an extra barrier either after the
> unlock() or before the lock() operation. However, I remain absolutely in
> favour of strengthening the ordering of the _critical sections_ guarded by
> the locks to be RCsc.

I agree with Will here.  If the AMOSWAP above is actually implemented with
a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
as Peter described.  If instead it's implemented using LR/SC, then RISC-V
gives only TSO (R->R, R->W, W->W), because the two pieces of the AMO are
split, and that breaks the chain.  Getting full RW->RW between the critical
sections would therefore require an extra fence.  Also, the accesses to the
lockwords themselves would not be ordered without an extra fence.

> Last time this came up, I think the RISC-V folks were generally happy to
> implement whatever was necessary for Linux [1]. The thing that was stopping
> us was Power (see CONFIG_ARCH_WEAK_RELEASE_ACQUIRE), wasn't it? I think
> Michael saw quite a bit of variety in the impact on benchmarks [2] across
> different machines. So the question is whether newer Power machines are less
> affected to the degree that we could consider making this change again.

Yes, as I said above, RISC-V will implement what is needed to make this work.

Dan

> Will
> 
> [1] https://lore.kernel.org/lkml/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com/
> [2] https://lore.kernel.org/lkml/87tvp3xonl.fsf@concordia.ellerman.id.au/
