Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2FE719B65
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Jun 2023 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjFAMA1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Jun 2023 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjFAMAV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Jun 2023 08:00:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5BE4C;
        Thu,  1 Jun 2023 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DnUacDApiSAYSf9fnZt98RUJRFIHjjaMl8c0ihb+od0=; b=EPUoO4BmncQnw4jKUU4aYbjuM5
        NmEHIBvjh4uKw0Mk3fTsRKs5HHoPoyGFmSQKpaD9k9XFmmbBoL4w75y9aBm7wahZpJFhZcVZwWWzl
        zuG3TpUMVZHB9J5tIBQgk32NNNyrGMPcnWUYS6oRpXLNckYzYON3aqEohu8ShbwifgT3VZGSjvwGi
        8nXemVSAh0Zz2v/RPj8DLQ4k5pT4OFbWGoHLNCz1nKehIlR+v/l7I5S048nf0z1BN7paMPsxfTl5t
        kGa0+fSFDLBFuqnPxZMzWjYFXtCPInHFp//EQDHNAHD5Jf2R5e156qULvOe/bVGfJpPT22XJZPAkg
        UOWIsMRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4gyH-008LT9-NT; Thu, 01 Jun 2023 12:00:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FE0D300220;
        Thu,  1 Jun 2023 14:00:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21721202BDCB1; Thu,  1 Jun 2023 14:00:01 +0200 (CEST)
Date:   Thu, 1 Jun 2023 14:00:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115643.GX4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Jun 01, 2023 at 01:56:43PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 01:13:26PM +0200, Peter Zijlstra wrote:
> > 
> > This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
> > isn't too much of a bother; so perhaps something like so?
> > 
> > (on top of tip/sched/core from just a few hours ago, as I had to 'fix'
> > this patch and force pushed the thing)
> > 
> > And yeah, random hacks and heuristics here :/ Does there happen to be
> > additional topology that could aid us here? Does the CCD fabric itself
> > have a distance metric we can use?
> 
>   https://www.anandtech.com/show/16529/amd-epyc-milan-review/4
> 
> Specifically:
> 
>   https://images.anandtech.com/doci/16529/Bounce-7763.png
> 
> That seems to suggest there are some very minor distance effects in the
> CCD fabric. I didn't read the article too closely, but you'll note that
> the first 4 CCDs have inter-CCD latency < 100 while the rest has > 100.
> 
> Could you also test on a Zen2 Epyc, does that require nr=8 instead of 4?
> Should we perhaps write it like: 32 / llc_size ?
> 
> The Zen2 picture:
> 
>   https://images.anandtech.com/doci/16315/Bounce-7742.png
> 
> Shows a more pronounced CCD fabric topology, you can really see the 2
> CCX inside the CCD but also there's two ligher green squares around the
> CCDs themselves.

I can't seem to find pretty pictures for Zen4 Epyc; what does that want?
That's even bigger at 96/8=12 LLCs afaict.
