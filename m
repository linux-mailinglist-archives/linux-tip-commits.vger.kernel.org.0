Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193AA33F12C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCQNbd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 09:31:33 -0400
Received: from casper.infradead.org ([90.155.50.34]:35820 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhCQNba (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uImN96cD96HNFO+cpTeC0zwwZGQg9N3yINjimoektS8=; b=dt5HAHqKbsNe5ezsxTkGbNVzVE
        tJYD3r9S/8N7WllV23lN85u8Qc+x8fJQ2a14c1XNUBxZRNAMlLFv2SC8qRO2x37cgZSBav9mE8pUT
        uKkz80agVQ6Cq9B6S6//OnqgYXEEZn2y/zcTLUKhYX94y/Iin65/DcgqMOOD6Tp0k4P5N6nq7bV+n
        yux9PJdAOvQ7ME4GCjK/h/bjDtiVU/0wCZ9uQ+LaQpezeP7/bfib4CgCtlZjht1GSR+c2l1iehkcs
        mdeNnLPYAQFLE3HkoWxOCNWQp5AQSWh992l2bakdo52dqJolZtyxoP906vN/jd9Lkiir5lkUmj1/0
        e5cgBoGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMWGa-001VuP-7X; Wed, 17 Mar 2021 13:31:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC336301324;
        Wed, 17 Mar 2021 14:31:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AADCB20781083; Wed, 17 Mar 2021 14:31:15 +0100 (CET)
Date:   Wed, 17 Mar 2021 14:31:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
Message-ID: <YFIEo8IVQ/Mm9jUE@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
 <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 02:12:41PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 12:38:21PM -0000, tip-bot2 for Waiman Long wrote:
> > +	/*
> > +	 * Treat as trylock for ww_mutex.
> > +	 */
> > +	mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, nest_lock, ip);
> 
> I'm confused... why isn't nest_lock working here?
> 
> For ww_mutex, we're supposed to have ctx->dep_map as a nest_lock, and
> all lock acquisitions under a nest lock should be fine. Afaict the above
> is just plain wrong.

To clarify:

	mutex_lock(&A);			ww_mutex_lock(&B, ctx);
	ww_mutex_lock(&B, ctx);		mutex_lock(&A);

should still very much be a deadlock, but your 'fix' makes it not report
that.

Only order within the ww_ctx can be ignored, and that's exactly what
nest_lock should be doing.
