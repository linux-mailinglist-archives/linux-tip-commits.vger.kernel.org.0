Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017304362DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhJUN1h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhJUN1f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 09:27:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB155C0613B9;
        Thu, 21 Oct 2021 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VCSBvJopViXgomP7/W7z5lg3UYBTclWXRT5/tcZsdR4=; b=Pq+v1GrIVQ5NxxWN5sfQHE8VBy
        sbHiCtLH7wwMSYIGTUo1jv72fRSZAJsSpjzmJsaPVoSjIRhgO+SoMsmxvKhLQelVneAciXj7N0jOd
        l0gUfqcU7o0Btd8W7CfnKmDKtcwEZBYzaWG0v9noBanVAgA1gmsqn+IimbuZ7vTO5vIODQypS8THO
        lEXfc2ftA8vDPmcfNXcUqUR1/+lPTvZR7N6PJRQMcJGYV47jTeXWgrN3pM7Lj82yEnm+n3SmmHGm2
        /s1+pp2kt0EV33eOYgl+F3CSMWfktTFjKpO/zPYwQrF+UQFbci18nXj7kYrYGV6lcRRwnGixB93sK
        xziM+Wfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdY27-00DHzE-Am; Thu, 21 Oct 2021 13:23:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24F5E300221;
        Thu, 21 Oct 2021 15:22:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0974C2C0E0B95; Thu, 21 Oct 2021 15:22:58 +0200 (CEST)
Date:   Thu, 21 Oct 2021 15:22:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
Message-ID: <YXFpsiw16OeQEtFQ@hirez.programming.kicks-ass.net>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
 <20211020204056.GD174730@worktop.programming.kicks-ass.net>
 <CAGsJ_4xNYz8ZpLz_1Fyd-FzTWG9HuoONqCGApX+to5Zpw5P67g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xNYz8ZpLz_1Fyd-FzTWG9HuoONqCGApX+to5Zpw5P67g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Oct 21, 2021 at 11:32:36PM +1300, Barry Song wrote:
> On Thu, Oct 21, 2021 at 9:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 20, 2021 at 10:36:19PM +0200, Peter Zijlstra wrote:
> >
> > > OK, I think I see what's happening.
> > >
> > > AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
> > > means it's set to BAD_APICID.
> > >
> > > This then results in match_l2c() to never match. And as a direct
> > > consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
> > > just the one CPU set.
> > >
> > > And we have the above result and things come unstuck if we assume:
> > >   SMT <= L2 <= LLC
> > >
> > > Now, the big question, how to fix this... Does AMD have means of
> > > actually setting l2c_id or should we fall back to using match_smt() for
> > > l2c_id == BAD_APICID ?
> >
> > The latter looks something like the below and ought to make EPYC at
> > least function as it did before.
> >
> >
> > ---
> >  arch/x86/kernel/smpboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 849159797101..c2671b2333d1 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> >
> >         /* Do not match if we do not have a valid APICID for cpu: */
> >         if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
> > -               return false;
> > +               return match_smt(c, o); /* assume at least SMT shares L2 */
> 
> Rather than making a fake cluster_cpus and cluster_cpus_list which
> will expose to userspace
> through /sys/devices/cpus/cpux/topology, could we just fix the
> sched_domain mask by the
> below?

I don't think it's fake; SMT fundamentally has to share all cache
levels. And having the sched domains differ in setup from the reported
(nonsensical) topology also isn't appealing.
