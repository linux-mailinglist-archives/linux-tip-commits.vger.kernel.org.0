Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD929AB14
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 12:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899539AbgJ0LqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 07:46:24 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:64062 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899537AbgJ0LqY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 07:46:24 -0400
X-Greylist: delayed 995 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 07:46:23 EDT
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22816111-1500050 
        for multiple; Tue, 27 Oct 2020 11:29:38 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net> <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Qian Cai <cai@redhat.com>,
        Peter Zijlstra (Intel) <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>
Date:   Tue, 27 Oct 2020 11:29:35 +0000
Message-ID: <160379817513.29534.880306651053124370@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Quoting tip-bot2 for Peter Zijlstra (2020-10-07 17:20:13)
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     24d5a3bffef117ed90685f285c6c9d2faa3a02b4
> Gitweb:        https://git.kernel.org/tip/24d5a3bffef117ed90685f285c6c9d2faa3a02b4
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Wed, 30 Sep 2020 11:49:37 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 07 Oct 2020 18:14:17 +02:00
> 
> lockdep: Fix usage_traceoverflow
> 
> Basically print_lock_class_header()'s for loop is out of sync with the
> the size of of ->usage_traces[].

We're hitting a problem,

	$ cat /proc/lockdep_stats

upon boot generates:

[   29.465702] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
[   29.465716] WARNING: CPU: 0 PID: 488 at kernel/locking/lockdep_proc.c:256 lockdep_stats_show+0xa33/0xac0

that bisected to this patch. Only just completed the bisection and
thought you would like a heads up.
-Chris
