Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC2406D18
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhIJNtI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 09:49:08 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:37728
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233602AbhIJNtH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 09:49:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmyF2o8EtiF2rHTU2hUOyl2WWutulE9c6rW1eNsks4dLayHSLx40Dk0vaXnP9cf1WG1OHA2H/vR7XSfFkvQ93WfihZWdldpDivoV/hjf+XZ6xl0FVxqgY8mzpYzBC2bMNH2kWe88Vc+tYfiVxEFe13rhj2dyvh1F0mcDT35UBNgObCpFo3V8najNLwe6DTj/+1YPzyjoQ+MdwZrktB/qp9ZWVVz4FQpIVuquyxylCuF508yPTSEAZEIK0f/xO+eqmMHmiRcpzStxELtxnCM+MjH3lztB+vTpfxooQKiLmLvd9QiBub2HzTTSsepDgnMZTMnqXM/Gz7cFi2ICwKOthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=00DvRxVkw/BNC5nxL4/kF0Mrau5ksY5J3h65qJcMZmI=;
 b=Gcmpmt7Baxa+Z/8zJGsVOzdylv2LbdzvPnsVj/Mx28WgbkAa3Xjl2rUjSZBknp5UqboIQ6riWgn3huhH0pSTkGah6hGIYAHztPdJBA2EKfhn2T22K3ppNZCkSDxYy/iZe2sToWJEjLNByz9+1NlyEKQ3Rrv97xCn0mEy+kJV4FgetrUPuX6HRaAHYtXkeNByd6tuAjOLCtRBdkA7JlocikOJAfoam1kDhPPQ7K3mlh4PIvy84yyU2hLuWgB5H9MujrL0ZarHvsEY2hF76eHaQ4WMLBSxL3sGL7kkmE4jKxjfieqvfawaWexKNSwBaaXBJTL4H2PClWI500imrpgujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=ellerman.id.au smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00DvRxVkw/BNC5nxL4/kF0Mrau5ksY5J3h65qJcMZmI=;
 b=eUu/pi6nLDqw9Z4k4aeeKNGW/n3Jw0YNNQBsbiCVVjcgnmHoKAib7jWMZW3tHDufaDKEHr9XHbYkjGX8aGLyQ4Cz/o+fMDOTlG7UrgI7ckz4LinrRyI6/nE7jV8ypOkEecN3g0tD1xUnFWkHtZF5daD+k0v+up3viUUDccIv6S+YYA+dj6O+6N7Lkbhd0XZUAl8QtoXzvitu6p/hdd0fZGucD3mUJSUOxU61lA/q2/a2vpJCCdUKQqgujSAg7FMjQb8Mt8GBVYVe8nHcKDdMXcFttKqRBOuCKl2fJn0gggAW8qwPyCoel64vQgo+T8s4nhJctPT5NqQGrDYRv2JBvQ==
Received: from CO1PR15CA0090.namprd15.prod.outlook.com (2603:10b6:101:20::34)
 by MW2PR12MB2490.namprd12.prod.outlook.com (2603:10b6:907:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 10 Sep
 2021 13:47:54 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::b6) by CO1PR15CA0090.outlook.office365.com
 (2603:10b6:101:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 13:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; ellerman.id.au; dkim=none (message not signed)
 header.d=none;ellerman.id.au; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 13:47:53 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Sep
 2021 13:47:52 +0000
Received: from [10.20.237.217] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Sep
 2021 13:47:49 +0000
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        <linux-tip-commits@vger.kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mpe@ellerman.id.au>
References: <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <YTqgSmX57l2hCMk0@boqun-archlinux>
 <YTsmZWGXOKlfgbh9@hirez.programming.kicks-ass.net>
 <YTstpCYfnL9P1sAA@boqun-archlinux>
From:   Dan Lustig <dlustig@nvidia.com>
Message-ID: <20a453f3-9b1f-20ab-880b-1018b2e11664@nvidia.com>
Date:   Fri, 10 Sep 2021 09:48:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTstpCYfnL9P1sAA@boqun-archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c3d0aa-3a73-4738-7583-08d974619679
X-MS-TrafficTypeDiagnostic: MW2PR12MB2490:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24904826B131EBDC7C35F524DCD69@MW2PR12MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WluZAeUnuTBzKJAIjEF8/RqjrpQa9wBGxdBsUxL5bUsgAfivj1TaApDR9W4VTfydrVn98KIU89FgGxaKQi74hNhfCRCSTcfM3O2goFI9fTpSFFdBSBloImsU5D1trJhrIgvNkxc3iB/ocGCbsDz3ramcaNNfG9sGMymRWSyijNY4JrPteUkhIi7pFtvFIQEaXHL/u/mNtMydoMLUJpqfO8yRSLcnPa0xfOhdq9vRJJ52Qk1T2wb621K7dRMCH6cPGP53LuYlCKcMjp5rHCeO42LG7L1eAy7wiXW7xb/x+if1cCcNPpYFwexqC/KM2WUTZipdraEd5ogooN09TdXhaX/7JanxUGRUrm5t1NL86eoP/VS1hoeTiDkBNOTPl7W9+KFU3iX3BCecyYCeEclbFwls5rowLMpZZyyyVipOPlNOBMP/42pACsYOishrtc2eQdD4oFTNe4k1FV7xy9zRakg3AnbcZrPtHYwRMcYGiiVOxungl5uxpz1rKQ4n8kT0WrN8xFWqdr9rrx8ZaT3aL36PAzKgaffZoc3IhF8imP25BTQVBX+jCzoxUcS7QAIApcFP88ZoJ+fU4tLvrVa2nXrT4EBWfITqrRqK0ZtZkAs6RUTk4Jw2DRu1ONbKUgDMuGxTakVLMxBlw/FulqT++lTQ/NPnsOPSaLBR84N1NFBoPYbMQCJoQUJBXj68RiT0eDzrbmdLclG4rV0YspiHW2iKRlUpi57KmRHroLo5Gno=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(16526019)(426003)(36860700001)(336012)(53546011)(7636003)(70206006)(7416002)(70586007)(86362001)(356005)(8936002)(26005)(36906005)(8676002)(6666004)(478600001)(31686004)(47076005)(54906003)(31696002)(5660300002)(316002)(110136005)(16576012)(186003)(82740400003)(83380400001)(82310400003)(4326008)(2616005)(36756003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 13:47:53.4178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c3d0aa-3a73-4738-7583-08d974619679
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2490
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 9/10/2021 6:04 AM, Boqun Feng wrote:
> On Fri, Sep 10, 2021 at 11:33:25AM +0200, Peter Zijlstra wrote:
>> On Fri, Sep 10, 2021 at 08:01:14AM +0800, Boqun Feng wrote:
>>> On Thu, Sep 09, 2021 at 01:03:18PM -0400, Dan Lustig wrote:
>>>> On 9/9/2021 9:35 AM, Will Deacon wrote:
>>>>> On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
>>
>>>>>> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
>>>>>> similarly it marches the R from the R->RW fence, yielding an:
>>>>>>
>>>>>> 	RW->  W
>>>>>> 	    RmW
>>>>>> 	    R  ->RW
>>>>>>
>>>>>> ordering. It's the stores S and R that can be re-ordered, but not the
>>>>>> sections themselves (same on PowerPC and many others).
>>
>>>> I agree with Will here.  If the AMOSWAP above is actually implemented with
>>>> a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
>>>> as Peter described.  If instead it's implemented using LR/SC, then RISC-V
>>>
>>> Just out of curiosity, in the following code, can the store S and load L
>>> be reordered?
>>>
>>> 	WRITE_ONCE(x, 1); // store S
>>> 	FENCE RW, W
>>>  	WRITE_ONCE(s.lock, 0); // unlock(s)
>>>  	AMOSWAP %0, 1, s.lock  // lock(s)
>>> 	FENCE R, RW
>>> 	r1 = READ_ONCE(y); // load L
>>>
>>> I think they can, because neither "FENCE RW, W" nor "FENCE R, RW" order
>>> them.
>>
>> I'm confused by your argument, per the above quoted section, those
>> fences and the AMO combine into a RW,RW ordering which is (as per the
>> later clarification) multi-copy-atomic, aka smp_mb().
>>
> 
> Right, my question is more about the reasoning about why fence rw,w +
> AMO + fence r,rw act as a fence rw,rw.

Is this a RISC-V question?  If so, it's as simple as:
1) S and anything earlier are ordered before the AMO by the first fence
2) L and anything later are ordered after the AMO by the second fence
3) 1 + 2 = S and anything earlier are ordered before L or anything later

Since RISC-V is multi-copy atomic, so 1+2 just naturally compose
transitively.

> Another related question, can
> fence rw,w + store + fence w,rw act as a fence rw,rw by the similar
> reasoning? IOW, will the two loads in the following be reordered?
> 
> 	r1 = READ_ONCE(x);
> 	FENCE RW, W
> 	WRITE_ONCE(z, 1);
> 	FENCE W, RW
> 	r2 = READ_ONCE(y);
> 
> again, this is more like a question out of curiosity, not that I find
> this pattern is useful.

Does FENCE W,RW appear in some actual use case?  But yes, if it does
appear, this sequence would also act as a FENCE RW,RW on RISC-V.

Dan

> Regards,
> Boqun
> 
>> As such, S and L are not allowed to be re-ordered in the given scenario.
>>
>>> Note that the reordering is allowed in LKMM, because unlock-lock
>>> only need to be as strong as RCtso.
>>
>> Risc-V is strictly stronger than required in this instance. Given the
>> current lock implementation. Daniel pointed out that if the atomic op
>> were LL/SC based instead of AMO it would end up being RCtso.
>>
