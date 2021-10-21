Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AAA436D64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 00:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUWZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 18:25:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13968 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJUWZ0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 18:25:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hb24v2pgTzZcJc;
        Fri, 22 Oct 2021 06:21:19 +0800 (CST)
Received: from kwepemm000014.china.huawei.com (7.193.23.6) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 06:23:07 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm000014.china.huawei.com (7.193.23.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 06:23:07 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.015;
 Fri, 22 Oct 2021 06:23:07 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Barry Song <21cnbao@gmail.com>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86 <x86@kernel.org>
Subject: RE: [tip: sched/core] sched: Add cluster scheduler level for x86
Thread-Topic: [tip: sched/core] sched: Add cluster scheduler level for x86
Thread-Index: AQHXwalo/RpU/FhCiUKur45aRWVHFKvbXu+AgABvY4CAAATMgIAABMEAgAAC94CAAAFLAIAA6F0AgAAvmgCAARqoMA==
Date:   Thu, 21 Oct 2021 22:23:07 +0000
Message-ID: <73dec318e90d45ae93f2931f0e25171b@hisilicon.com>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
 <20211020204056.GD174730@worktop.programming.kicks-ass.net>
 <CAGsJ_4xNYz8ZpLz_1Fyd-FzTWG9HuoONqCGApX+to5Zpw5P67g@mail.gmail.com>
 <YXFpsiw16OeQEtFQ@hirez.programming.kicks-ass.net>
In-Reply-To: <YXFpsiw16OeQEtFQ@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Friday, October 22, 2021 2:23 AM
> To: Barry Song <21cnbao@gmail.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>; LKML
> <linux-kernel@vger.kernel.org>; linux-tip-commits@vger.kernel.org; Tim Chen
> <tim.c.chen@linux.intel.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; x86 <x86@kernel.org>
> Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
> 
> On Thu, Oct 21, 2021 at 11:32:36PM +1300, Barry Song wrote:
> > On Thu, Oct 21, 2021 at 9:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 10:36:19PM +0200, Peter Zijlstra wrote:
> > >
> > > > OK, I think I see what's happening.
> > > >
> > > > AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
> > > > means it's set to BAD_APICID.
> > > >
> > > > This then results in match_l2c() to never match. And as a direct
> > > > consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
> > > > just the one CPU set.
> > > >
> > > > And we have the above result and things come unstuck if we assume:
> > > >   SMT <= L2 <= LLC
> > > >
> > > > Now, the big question, how to fix this... Does AMD have means of
> > > > actually setting l2c_id or should we fall back to using match_smt() for
> > > > l2c_id == BAD_APICID ?
> > >
> > > The latter looks something like the below and ought to make EPYC at
> > > least function as it did before.
> > >
> > >
> > > ---
> > >  arch/x86/kernel/smpboot.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > index 849159797101..c2671b2333d1 100644
> > > --- a/arch/x86/kernel/smpboot.c
> > > +++ b/arch/x86/kernel/smpboot.c
> > > @@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct
> cpuinfo_x86 *o)
> > >
> > >         /* Do not match if we do not have a valid APICID for cpu: */
> > >         if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
> > > -               return false;
> > > +               return match_smt(c, o); /* assume at least SMT shares L2 */
> >
> > Rather than making a fake cluster_cpus and cluster_cpus_list which
> > will expose to userspace
> > through /sys/devices/cpus/cpux/topology, could we just fix the
> > sched_domain mask by the
> > below?
> 
> I don't think it's fake; SMT fundamentally has to share all cache
> levels. And having the sched domains differ in setup from the reported
> (nonsensical) topology also isn't appealing.

Fair enough. I was actually inspired by cpu_coregroup_mask() which
is a combination of a couple of cpumask set:
drivers/base/arch_topology.c

const struct cpumask *cpu_coregroup_mask(int cpu)
{
	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));

	/* Find the smaller of NUMA, core or LLC siblings */
	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
		/* not numa in package, lets use the package siblings */
		core_mask = &cpu_topology[cpu].core_sibling;
	}
	if (cpu_topology[cpu].llc_id != -1) {
		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
			core_mask = &cpu_topology[cpu].llc_sibling;
	}

	return core_mask;
}

Thanks
Barry

