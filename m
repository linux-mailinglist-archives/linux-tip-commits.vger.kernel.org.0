Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA563412F2D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhIUHSv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhIUHSv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:18:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FBDC061574;
        Tue, 21 Sep 2021 00:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cZ0+SAeUdSwmUy7goGl8UyjWIcPnUe9n7SlJ/+MlqLs=; b=n3uyWO0niUIIsLEi9RXHc0EBj/
        QTSfGVuHTBK9UuyCD6/k2Zg9iys9F72G/O2CHOBUBwkmSEWy4hdztDuv6UCin7v75xy08Mi2igJni
        kNFh5ANva/tbSLhCUd8hDvhiyFP51OSGM+oZGImPo25m9vjp684eOOTEpsP8VGPfZPB8zxyJcKAKF
        YZMx688tSUEuVq2Eur4JirVcNYcp3G5SwTaHMOmGnaiMih0ryHu4+b8FRiEJ1L0gY12YnUP3QbEdG
        Fm5ETIWLGIMaVYfACYejImtRb37VPXOqHMmD5Oo8jVBguiOPS6jqX7kQvxScEGUtAiveDniIcAPCX
        oM1BeDDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSa1b-004i4b-QI; Tue, 21 Sep 2021 07:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 392C0300274;
        Tue, 21 Sep 2021 09:17:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22C822C3EE3EE; Tue, 21 Sep 2021 09:17:07 +0200 (CEST)
Date:   Tue, 21 Sep 2021 09:17:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Make struct sched_statistics
 independent of fair sched class
Message-ID: <YUmG8+96zgScrfqm@hirez.programming.kicks-ass.net>
References: <20210905143547.4668-3-laoar.shao@gmail.com>
 <163179357090.25758.13267982301302997472.tip-bot2@tip-bot2>
 <20210921061727.GA24828@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921061727.GA24828@kili>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Sep 21, 2021 at 09:17:27AM +0300, Dan Carpenter wrote:
> On Thu, Sep 16, 2021 at 11:59:30AM -0000, tip-bot2 for Yafang Shao wrote:
> > @@ -11424,7 +11441,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> >  		if (!cfs_rq)
> >  			goto err;
> >  
> > -		se = kzalloc_node(sizeof(struct sched_entity),
> > +		se = kzalloc_node(sizeof(struct sched_entity_stats),
> 
> This wasn't there in the original patch and it causes a Smatch warning

What original patch? It's part of the v4 posting.

> because "se" is declared as a "sched_entity" but it's allocating a
> larger "sched_entity_stats" which contains a sched_entity.

Yep, on purpose.

> To me, ideally, we would update the type of se.

That's a lot of churn for very little gain. I can rewrite it like:

	struct sched_entity_stats *ses = kzalloc_node(sizeof(*ses),...);
	se = &ses->se;

If that makes smatch happy. It's the exact same thing tho because we
force ses->se to be at 0 offset.
