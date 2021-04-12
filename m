Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7535C876
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Apr 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbhDLORP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Apr 2021 10:17:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhDLORP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Apr 2021 10:17:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618237016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nhAvEHNMMXwBbl3AWVuFy78vV6aJxv0n7jBXDQx7qCM=;
        b=WOSecj2/dGuF+I+G4E1TrDQZBCZhcUxYJHWHpD5sWreQ8w1Fkwz8QcGWehdVtcAGS4lhtB
        KvNgTZDpDWKJrzKCr3bcZ51oBPZmzetMApkovyFGExrpU6I/OIeTfoCOtQk+7q8cMCNiFB
        pE7Vu38ZzubyIJf3Wkt/MIZOeoZGyv+Vp8xMYYQ7yPfoe5Do93dRMmiXTn95rS4y1meApP
        e2ml7ynw6M32KZgNrEOvbzhB5QCMfo8t+0evy5m4zwcTJbbUFUTr05dUJpa4KySH9QoeRZ
        X19FPikCnA1iMLC0WCwooYVbogOyPgRylICB044IzROhNAv0zyPXIddLomnuEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618237016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nhAvEHNMMXwBbl3AWVuFy78vV6aJxv0n7jBXDQx7qCM=;
        b=M11xPhPUpPugUMrxBEOpRFyaA6n2k7bPPG+FoD2hZZnGs+ozu2ncwGucLn5bnXveAfLcIF
        cwNKoSbVinDpdmDA==
To:     "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it has been spawned
In-Reply-To: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
Date:   Mon, 12 Apr 2021 16:16:55 +0200
Message-ID: <87czuz1tbc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Apr 11 2021 at 13:43, tip-bot wrote:
> The following commit has been merged into the core/rcu branch of tip:
>
> Commit-ID:     1c0c4bc1ceb580851b2d76fdef9712b3bdae134b
> Gitweb:        https://git.kernel.org/tip/1c0c4bc1ceb580851b2d76fdef9712b3bdae134b
> Author:        Paul E. McKenney <paulmck@kernel.org>
> AuthorDate:    Fri, 12 Feb 2021 16:20:40 -08:00
> Committer:     Paul E. McKenney <paulmck@kernel.org>
> CommitterDate: Mon, 15 Mar 2021 13:51:48 -07:00
>
> softirq: Don't try waking ksoftirqd before it has been spawned
>
> If there is heavy softirq activity, the softirq system will attempt
> to awaken ksoftirqd and will stop the traditional back-of-interrupt
> softirq processing.  This is all well and good, but only if the
> ksoftirqd kthreads already exist, which is not the case during early
> boot, in which case the system hangs.
>
> One reproducer is as follows:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" --bootargs "threadirqs=1" --trust-make
>
> This commit therefore adds a couple of existence checks for ksoftirqd
> and forces back-of-interrupt softirq processing when ksoftirqd does not
> yet exist.  With this change, the above test passes.

Color me confused. I did not follow the discussion around this
completely, but wasn't it agreed on that this rcu torture muck can wait
until the threads are brought up?

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9908ec4..bad14ca 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -211,7 +211,7 @@ static inline void invoke_softirq(void)
>  	if (ksoftirqd_running(local_softirq_pending()))
>  		return;
>  
> -	if (!force_irqthreads) {
> +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
>  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
>  		/*
>  		 * We can safely execute softirq on the current stack if

This still breaks RT which forces force_irqthreads to a compile time
const which makes the compiler optimize out the direct invocation.

Surely RT can work around that, but how is that rcu torture muck
supposed to work then? We're back to square one then.

Thanks,

        tglx
