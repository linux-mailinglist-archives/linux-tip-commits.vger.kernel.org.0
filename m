Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3322AF9ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKUpI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 15:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKUpI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 15:45:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FA5C0613D1;
        Wed, 11 Nov 2020 12:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CsuP2ZbFV021yD83Asf/WJrsarPfzdmIq9MXLED49SE=; b=QF9Lp+Dv+5PrX67MKMP/B8Ri5v
        WnPV6mS+OhKhV1U72wkx3T64VjCFcm7V2HI4G7FzyyHU9uInlAIqTjutPsdBYLM3OdRRlLOsXV5/s
        hfnzgSqwDYUgqnnqY6OiG2pc6eugSLTBBj89ba1fqWiIpkPafPZ5pcwlN1JpwFCFCgsc1hgWNatpd
        08yPCU5Lh9qGFj+2DZ1HzeEFzJhC+59QerfgRx2tzvZUvhjF78gAonDyzKShdXP0x7SXlNSnAMxOM
        istBiplwdwTvAISnRyQr5JA3d8mrkWQfbxNDDxbAdPhzO3k/k8eap/2fPZwCeZSEuZ1O1RZ+aIlvu
        kJw7TsWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwzF-000766-PU; Wed, 11 Nov 2020 20:45:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EED9301E02;
        Wed, 11 Nov 2020 21:45:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A0352BCE962B; Wed, 11 Nov 2020 21:45:00 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:45:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org
Subject: Re: [tip: sched/core] sched: Fix balance_callback()
Message-ID: <20201111204500.GR2628@hirez.programming.kicks-ass.net>
References: <20201023102346.203901269@infradead.org>
 <160508300397.11244.13967684821070428528.tip-bot2@tip-bot2>
 <6356963f376a0798e8c939f813c2efe05d32c6d7.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6356963f376a0798e8c939f813c2efe05d32c6d7.camel@tiscali.nl>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Nov 11, 2020 at 09:30:42PM +0100, Paul Bolle wrote:
> tip-bot2 for Peter Zijlstra schreef op wo 11-11-2020 om 08:23 [+0000]:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > [...]
> > +static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
> > +{
> > +	void (*func)(struct rq *rq);
> > +	struct callback_head *next;
> > +
> > +	lockdep_assert_held(&rq->lock);
> > +
> > +	while (head) {
> > +		func = (void (*)(struct rq *))head->func;
> > +		next = head->next;
> > +		head->next = NULL;
> > +		head = next;
> 
> Naive question: is there some subtle C-issue that is evaded here by setting
> head->next to NULL prior to copying over it?
> 
> (I know this piece of code only got copied around in this patch and this is
> therefor not something that this patch actually introduced.)

It's like list_del_init(), it zeros the entry before unlinking it.
queue_balance_callback() relies on this.
