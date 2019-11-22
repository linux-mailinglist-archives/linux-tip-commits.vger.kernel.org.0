Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4451079B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Nov 2019 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKVVDb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Nov 2019 16:03:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44502 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVVD3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Nov 2019 16:03:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id g24so2546579qtq.11
        for <linux-tip-commits@vger.kernel.org>; Fri, 22 Nov 2019 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JklxB5p9HEc9L1MiCrh3Zy+CQC2KvglM1Tp/GhFHwhc=;
        b=AcdvKXHg380Tjx2Fu2fN3Y2zrL1iyiYtInzi/r5a6kbUe+zX8D6nD462rgd0lJI4dJ
         2HizHflABj6D3tvPnFUkoZ2DyCJ0D9R4S9BD87oWJUexET+RwRRuW34QP2wR2BNEfEXh
         OF/d0Pt4TQQ908y0k02txbFqEszsjNYad7YDc1tURrdF+gorRRdthLg+b43lKtKJIhLZ
         8VFbYx+XhzcPJeVYQnkye1af9g4w5B5YJDiSzaPaANP+4zi8o1dQuR8VFHZAJ22k/w2M
         KibCwRU9x97EjhhRr3FVpO98LTF3o+pAEGc2nUC2HuqvkJ4r8as5zd6u3clgBDVs5Wfl
         vGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JklxB5p9HEc9L1MiCrh3Zy+CQC2KvglM1Tp/GhFHwhc=;
        b=UXobx8ibCeJLa3VkJmW0A/WZXegloDpxUdUDi0VsYsGgPP8QUqkBAFF0EVqQjC0M0X
         uPrx17+Mf/mq9722kAIzeoRcF6cY7R8T8x3Kz+v2T+EnnWewFGMoX1Jx5ah27mGZ71JL
         MOOajuHzQeae+9xjq3ZEk82nQ0nsaZ+91FDepy3t6tEJicC+zY0jJdGo8HJjW38oh9Rj
         9Us4soqPmlW69tP4kPeLhwVI2PqpamiEomMiZ/2uD+yOr1N4DVqzx8FQiyzh7+hRcH2x
         x5IyzkYqHH1EHnyrEqqP1u1SQQ4yngbaN8CeYo9Ay8u7wAnFA8y4pAE9HTB73Y/mmBGU
         VxPA==
X-Gm-Message-State: APjAAAW35veqaLZEw1AwgAj8k1neQlzKM6m5v7O8eURtbyGOwNi8NWZA
        I8JP6ompyh1ZsbkMIP7kSkbidw==
X-Google-Smtp-Source: APXvYqzC+V1gBOQ3MLncjF4qDQTnXiTkWeKPquIRggtfIwvLrEKNbxkexfHDiW8c9tvDdAbvPBCNwA==
X-Received: by 2002:aed:204d:: with SMTP id 71mr7550631qta.116.1574456606488;
        Fri, 22 Nov 2019 13:03:26 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c6sm3428151qka.111.2019.11.22.13.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 13:03:25 -0800 (PST)
Message-ID: <1574456603.9585.28.camel@lca.pw>
Subject: Re: [tip: sched/urgent] sched/core: Avoid spurious lock dependencies
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org,
        penberg@kernel.org, rientjes@google.com, thgarnie@google.com,
        tytso@mit.edu, will@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Date:   Fri, 22 Nov 2019 16:03:23 -0500
In-Reply-To: <20191122202059.GA2844@hirez.programming.kicks-ass.net>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
         <157363958888.29376.9190587096871610849.tip-bot2@tip-bot2>
         <20191122200122.wx7ltij2w7w37cbe@linutronix.de>
         <20191122202059.GA2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, 2019-11-22 at 21:20 +0100, Peter Zijlstra wrote:
> On Fri, Nov 22, 2019 at 09:01:22PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-11-13 10:06:28 [-0000], tip-bot2 for Peter Zijlstra wrote:
> > > sched/core: Avoid spurious lock dependencies
> > > 
> > > While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> > > when DEBUG_OBJETS, can end up doing allocations.
> > > 
> > > This then results in the following lock order:
> > > 
> > >   rq->lock
> > >     zone->lock.rlock
> > >       batched_entropy_u64.lock
> > > 
> > > Which in turn causes deadlocks when we do wakeups while holding that
> > > batched_entropy lock -- as the random code does.
> > 
> > Peter, can it _really_ cause deadlocks? My understanding was that the
> > batched_entropy_u64.lock is a per-CPU lock and can _not_ cause a
> > deadlock because it can be always acquired on multiple CPUs
> > simultaneously (and it is never acquired cross-CPU).
> > Lockdep is simply not smart enough to see that and complains about it
> > like it would complain about a regular lock in this case.
> 
> That part yes. That is, even holding a per-cpu lock you can do a wakeup
> to the local cpu and recurse back onto rq->lock.
> 
> However I don't think it can actually happen bceause this
> is init_idle, and we only ever do that on hotplug, so actually creating
> the concurrency required for the deadlock might be tricky.
> 
> Still, moving that thing out from under the lock was simple and correct.

Well, the patch alone fixed a real deadlock during boot.

https://lore.kernel.org/lkml/1566509603.5576.10.camel@lca.pw/

It needs DEBUG_OBJECTS=y to trigger though.

Suppose it does,

CPU0: zone_lock -> prink() [1]
CPUs: printk() -> zone_lock [2]

[1]
[ 1078.599835][T43784] -> #1 (console_owner){-...}:
[ 1078.606618][T43784]        __lock_acquire+0x5c8/0xbb0
[ 1078.611661][T43784]        lock_acquire+0x154/0x428
[ 1078.616530][T43784]        console_unlock+0x298/0x898
[ 1078.621573][T43784]        vprintk_emit+0x2d4/0x460
[ 1078.626442][T43784]        vprintk_default+0x48/0x58
[ 1078.631398][T43784]        vprintk_func+0x194/0x250
[ 1078.636267][T43784]        printk+0xbc/0xec
[ 1078.640443][T43784]        _warn_unseeded_randomness+0xb4/0xd0
[ 1078.646267][T43784]        get_random_u64+0x4c/0x100
[ 1078.651224][T43784]        add_to_free_area_random+0x168/0x1a0
[ 1078.657047][T43784]        free_one_page+0x3dc/0xd08


[2]
[  317.337609] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  317.337612]        __lock_acquire+0x5b3/0xb40
[  317.337613]        lock_acquire+0x126/0x280
[  317.337613]        _raw_spin_lock+0x2f/0x40
[  317.337614]        rmqueue_bulk.constprop.21+0xb6/0x1160
[  317.337615]        get_page_from_freelist+0x898/0x22c0
[  317.337616]        __alloc_pages_nodemask+0x2f3/0x1cd0
[  317.337617]        alloc_page_interleave+0x18/0x130
[  317.337618]        alloc_pages_current+0xf6/0x110
[  317.337619]        allocate_slab+0x4c6/0x19c0
[  317.337620]        new_slab+0x46/0x70
[  317.337621]        ___slab_alloc+0x58b/0x960
[  317.337621]        __slab_alloc+0x43/0x70
[  317.337622]        kmem_cache_alloc+0x354/0x460
[  317.337623]        fill_pool+0x272/0x4b0
[  317.337624]        __debug_object_init+0x86/0x790
[  317.337624]        debug_object_init+0x16/0x20
[  317.337625]        hrtimer_init+0x27/0x1e0
[  317.337626]        init_dl_task_timer+0x20/0x40
[  317.337627]        __sched_fork+0x10b/0x1f0
[  317.337627]        init_idle+0xac/0x520
[  317.337628]        idle_thread_get+0x7c/0xc0
[  317.337629]        bringup_cpu+0x1a/0x1e0
[  317.337630]        cpuhp_invoke_callback+0x197/0x1120
[  317.337630]        _cpu_up+0x171/0x280
[  317.337631]        do_cpu_up+0xb1/0x120
[  317.337632]        cpu_up+0x13/0x20

[  317.337635] -> #2 (&rq->lock){-.-.}:
[  317.337638]        __lock_acquire+0x5b3/0xb40
[  317.337639]        lock_acquire+0x126/0x280
[  317.337639]        _raw_spin_lock+0x2f/0x40
[  317.337640]        task_fork_fair+0x43/0x200
[  317.337641]        sched_fork+0x29b/0x420
[  317.337642]        copy_process+0xf3c/0x2fd0
[  317.337642]        _do_fork+0xef/0x950
[  317.337643]        kernel_thread+0xa8/0xe0

[  317.337649] -> #1 (&p->pi_lock){-.-.}:
[  317.337651]        __lock_acquire+0x5b3/0xb40
[  317.337652]        lock_acquire+0x126/0x280
[  317.337653]        _raw_spin_lock_irqsave+0x3a/0x50
[  317.337653]        try_to_wake_up+0xb4/0x1030
[  317.337654]        wake_up_process+0x15/0x20
[  317.337655]        __up+0xaa/0xc0
[  317.337655]        up+0x55/0x60
[  317.337656]        __up_console_sem+0x37/0x60
[  317.337657]        console_unlock+0x3a0/0x750
[  317.337658]        vprintk_emit+0x10d/0x340
[  317.337658]        vprintk_default+0x1f/0x30
[  317.337659]        vprintk_func+0x44/0xd4
[  317.337660]        printk+0x9f/0xc5
