Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C6329AC1C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899938AbgJ0MbD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 08:31:03 -0400
Received: from casper.infradead.org ([90.155.50.34]:39964 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899937AbgJ0MbD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 08:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hKwadPeezW+Gj5bpajWS9gAMt9uB/l5UUKOHvIqf53U=; b=uHLwCQkZhxkIgF5p1Q7+6tv7vi
        GCvG3x2TRAhq4rZxBxiwgYOdttETRN6Qx5UkjapEnVH4d3wG8G6tqbW/IR8rwiSnSCjWYXEPrg7lL
        2Jm7ut3Xr0yZj2wS3r3wu+Rjdx/OdDJZEZBPwNxWRjexASYMp6MT76SdOVZS5S+1B4R5A4GgVbYyJ
        gHtQLpISF1KsEU1i1Vu+Hhj9qyW3lgea1nJz5/YxauXsa6gg/+7nHmvPciZs1EuGsia6ivHG9mmC3
        cxnFdCHGHCQVzXWW+I51GXpPrgwzPA05t1o773bLlafg9EvGU2Bq96zSuA6xOHy3X0fl8r9xBEJPJ
        l6aYaq3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXO7t-0000xv-Dz; Tue, 27 Oct 2020 12:30:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDBA930411F;
        Tue, 27 Oct 2020 13:30:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3908203CF3A4; Tue, 27 Oct 2020 13:30:56 +0100 (CET)
Date:   Tue, 27 Oct 2020 13:30:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201027123056.GE2651@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
 <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027115955.GA2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 27, 2020 at 12:59:55PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2020 at 11:29:35AM +0000, Chris Wilson wrote:
> > Quoting tip-bot2 for Peter Zijlstra (2020-10-07 17:20:13)
> > > The following commit has been merged into the locking/core branch of tip:
> > > 
> > > Commit-ID:     24d5a3bffef117ed90685f285c6c9d2faa3a02b4
> > > Gitweb:        https://git.kernel.org/tip/24d5a3bffef117ed90685f285c6c9d2faa3a02b4
> > > Author:        Peter Zijlstra <peterz@infradead.org>
> > > AuthorDate:    Wed, 30 Sep 2020 11:49:37 +02:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Wed, 07 Oct 2020 18:14:17 +02:00
> > > 
> > > lockdep: Fix usage_traceoverflow
> > > 
> > > Basically print_lock_class_header()'s for loop is out of sync with the
> > > the size of of ->usage_traces[].
> > 
> > We're hitting a problem,
> > 
> > 	$ cat /proc/lockdep_stats
> > 
> > upon boot generates:
> > 
> > [   29.465702] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
> > [   29.465716] WARNING: CPU: 0 PID: 488 at kernel/locking/lockdep_proc.c:256 lockdep_stats_show+0xa33/0xac0
> > 
> > that bisected to this patch. Only just completed the bisection and
> > thought you would like a heads up.
> 
> Oh hey, that's 'curious'... it does indeed trivially reproduce, let me
> have a poke.

This seems to make it happy. Not quite sure that's the best solution.

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..81295bc760fe 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4411,7 +4405,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		break;
 
 	case LOCK_USED:
-		debug_atomic_dec(nr_unused_locks);
+	case LOCK_USED_READ:
+		if ((hlock_class(this)->usage_mask & (LOCKF_USED|LOCKF_USED_READ)) == new_mask)
+			debug_atomic_dec(nr_unused_locks);
 		break;
 
 	default:



