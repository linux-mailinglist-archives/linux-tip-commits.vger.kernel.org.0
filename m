Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3317A43781B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJVNkV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhJVNkU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 09:40:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B711C061764;
        Fri, 22 Oct 2021 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YgWZDC+Wt+FMuTw2rUyL55kUPg5w44la2cDM9kWoNAY=; b=nxtIQpNLTOpqefUh0SYAoMiVyg
        J2VtESrziXUqa1XdBhgbccKV3W2IW/Upd3dSn0nm2libiEvcb+2DgK32n/94jRyDViCESdyA48KW2
        SQkNtlR+Z0gHQlKDNCCmloX81KrYYDXae9oYfcRdD/YhsTfOwq9WeGReGeU6xv4q7DRI0UQRyjsDg
        SIO71BWKcp67p0j7V0GULsYWDsQTinFdjReK4shBQ8ot1sCw/CeU9uF7c7QlXX2Dz2z/8d/sPIo3z
        ZK6gHuVoTegBrUJevdVMq5Z02rS/YWCYYFs7gl6wAbhtP1g5JAZfYUdb0UsPEE3yDUN8ewd+VaDZf
        rnKN24Vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mduiQ-00DvTb-LS; Fri, 22 Oct 2021 13:36:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AD97981F9D; Fri, 22 Oct 2021 15:36:09 +0200 (CEST)
Date:   Fri, 22 Oct 2021 15:36:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
Message-ID: <20211022133609.GA174703@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
 <20211020204056.GD174730@worktop.programming.kicks-ass.net>
 <e3c4f4a4-fe73-dc5e-65ee-0519c868f699@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c4f4a4-fe73-dc5e-65ee-0519c868f699@amd.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Oct 22, 2021 at 08:31:40AM -0500, Tom Lendacky wrote:
> On 10/20/21 3:40 PM, Peter Zijlstra wrote:
> >   arch/x86/kernel/smpboot.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 849159797101..c2671b2333d1 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> >   	/* Do not match if we do not have a valid APICID for cpu: */
> >   	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
> > -		return false;
> > +		return match_smt(c, o); /* assume at least SMT shares L2 */
> 
> This does eliminate the message and seems like an appropriate thing to do,
> in general, if the l2c id is not set.
> 
> We're looking into setting the l2c id for AMD platforms, but need to test
> against some older platforms. We'll let you know the results next week.
> 
> In the mean time, it is probably best to at least apply your above patch.

OK, I'll go write up a Changelog and stick on your Reported- and
Tested-by tags.

Thanks!
