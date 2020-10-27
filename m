Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF729ADC7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 14:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbgJ0NtN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 09:49:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35224 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbgJ0NtN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 09:49:13 -0400
X-Greylist: delayed 3626 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 09:49:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjjbZadqypxxhM9wzukWN2qeOvcJJziD3fYWXYXTJHM=; b=CslyLURwfU7tNotkiZqpo8m9mJ
        lzUB2dk42CCIjjVstpL9M6OJH1bGDwygjUkGS5aeJ8vUej1Ej8/SEsG7xUBobk+LDl2ffUrwaI565
        UhBhdl1cQt7q/7XUrLh/TP5AT7J0qmp9St0lFUkwd9MNaumqeg6AaeWktLv68lsCocXfAnM/50Myz
        C3TWk7kePqQ7EyU+go/JVicyXgGOi+RadZiM6oxwqd5/xx59urBzckcOiuhZGHk5VQDID1vVy0dM3
        ttXeI0P11gvNfYQ28802drLCHplVgCVF2mKWrE4ToiE1SNglFa/Yt150BYr1uWocmsIIDkUgepbwE
        cwMnSJLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXOP2-0007zu-8Y; Tue, 27 Oct 2020 12:48:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC876300455;
        Tue, 27 Oct 2020 13:48:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAE7B203CF3A3; Tue, 27 Oct 2020 13:48:34 +0100 (CET)
Date:   Tue, 27 Oct 2020 13:48:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201027124834.GL2628@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
 <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027123056.GE2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 27, 2020 at 01:30:56PM +0100, Peter Zijlstra wrote:
> This seems to make it happy. Not quite sure that's the best solution.
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3e99dfef8408..81295bc760fe 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4411,7 +4405,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  		break;
>  
>  	case LOCK_USED:
> -		debug_atomic_dec(nr_unused_locks);
> +	case LOCK_USED_READ:
> +		if ((hlock_class(this)->usage_mask & (LOCKF_USED|LOCKF_USED_READ)) == new_mask)
> +			debug_atomic_dec(nr_unused_locks);
>  		break;
>  
>  	default:

This also works, and I think I likes it better.. anyone?

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..e603e86c0227 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4396,6 +4390,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	if (unlikely(hlock_class(this)->usage_mask & new_mask))
 		goto unlock;
 
+	if (!hlock_class(this)->usage_mask)
+		debug_atomic_dec(nr_unused_locks);
+
 	hlock_class(this)->usage_mask |= new_mask;
 
 	if (new_bit < LOCK_TRACE_STATES) {
@@ -4403,19 +4400,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			return 0;
 	}
 
-	switch (new_bit) {
-	case 0 ... LOCK_USED-1:
+	if (new_bit < LOCK_USED) {
 		ret = mark_lock_irq(curr, this, new_bit);
 		if (!ret)
 			return 0;
-		break;
-
-	case LOCK_USED:
-		debug_atomic_dec(nr_unused_locks);
-		break;
-
-	default:
-		break;
 	}
 
 unlock:


