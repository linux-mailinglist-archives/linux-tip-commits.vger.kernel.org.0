Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506AC3BDE25
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jul 2021 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGFTrj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 6 Jul 2021 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGFTrj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 6 Jul 2021 15:47:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D37FC061574;
        Tue,  6 Jul 2021 12:45:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s24so595496oiw.2;
        Tue, 06 Jul 2021 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VDT2EKZr0mFzA5pyWa2j4CBNO8C6UHwZ7iEcd8ZzoX8=;
        b=G7gJMG/GvB3BwBxp1ktAJNUd2aFFJbaQJ3ypv6kNS3b8h0uX6tJ6uUGZtQpZhyzNOW
         KV5PkbeHvwkQN/9RKSZERFup1S7ZYWVmcqGR8GMTIGo0T5rBKsU5rzO3ffwYbbWwX+P6
         CxO7a88lqaXbOQ3Q5I9QEmFRUoEJj0aOKNq+JsoXTW9rFtZujAgibY0Pc1xwrNEFf4XG
         eMIwOuuET2WDRSXfU2QOvpcPH62UDSmtQAHHQ55ztQcz5MLIUwy6wZgybiXZY4AHZCqn
         FneyVDAvCnDrgeDpDTcBUHZ46/1+QhvRSmLrKw0fLmcr3YkMPChCCMGyApi0HynnsieZ
         dQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VDT2EKZr0mFzA5pyWa2j4CBNO8C6UHwZ7iEcd8ZzoX8=;
        b=N1xJEXD7r9qZp4Gd+k7DvhXa8zE+cCFXOnVZv65yWgaKLy33LT4BbXMhCBHsEmUtRu
         LlxvzYcqLr9u1vPO6eGuYrWezvO/kv4jRbSEu85PwZxjK4MsIgKg8xd80JOsDcVy6Mmz
         VRcEwwM/zJ7xI1WaZ2apfWN+ozvfIRtq0xuSHRabF8c7rccskclMNSKzC7+LNq94QoUH
         n9Slzal1k4LqEMVFzbwzzpVy2eQEAzjUek1khvQe5vHCf8XOvzEuAwJA4tOAVkKW5a2c
         gdPR7r/Xb/xX7ZJWn18RaLdzoNfkJS0ez+h9lAreKRvl4CjX5okGi/7e1aAOr/lqwfN6
         I6GA==
X-Gm-Message-State: AOAM533A3pmC2cV8GhTwEw/5cO1f45Mz5n4xoQslXS0sGVO7876GVBPo
        QDQz0Sz3ZQfO38/UDwrdrmlKGfit46U=
X-Google-Smtp-Source: ABdhPJyE2ChEsutojy4zEIhnuyGFQj+//h56zhKnxKP8nQCrcdt0pS46YuDlRUKvxH6I3z2ld+3zBQ==
X-Received: by 2002:aca:b609:: with SMTP id g9mr1691984oif.141.1625600699290;
        Tue, 06 Jul 2021 12:44:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3sm3503862oti.34.2021.07.06.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:44:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Jul 2021 12:44:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Message-ID: <20210706194456.GA1823793@roeck-us.net>
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi,

On Wed, May 12, 2021 at 11:15:54AM -0000, tip-bot2 for Valentin Schneider wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
> Gitweb:        https://git.kernel.org/tip/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
> Author:        Valentin Schneider <valentin.schneider@arm.com>
> AuthorDate:    Wed, 12 May 2021 10:46:36 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 12 May 2021 13:01:45 +02:00
> 
> sched/core: Initialize the idle task with preemption disabled
> 
> As pointed out by commit
> 
>   de9b8f5dcbd9 ("sched: Fix crash trying to dequeue/enqueue the idle thread")
> 
> init_idle() can and will be invoked more than once on the same idle
> task. At boot time, it is invoked for the boot CPU thread by
> sched_init(). Then smp_init() creates the threads for all the secondary
> CPUs and invokes init_idle() on them.
> 
> As the hotplug machinery brings the secondaries to life, it will issue
> calls to idle_thread_get(), which itself invokes init_idle() yet again.
> In this case it's invoked twice more per secondary: at _cpu_up(), and at
> bringup_cpu().
> 
> Given smp_init() already initializes the idle tasks for all *possible*
> CPUs, no further initialization should be required. Now, removing
> init_idle() from idle_thread_get() exposes some interesting expectations
> with regards to the idle task's preempt_count: the secondary startup always
> issues a preempt_disable(), requiring some reset of the preempt count to 0
> between hot-unplug and hotplug, which is currently served by
> idle_thread_get() -> idle_init().
> 
> Given the idle task is supposed to have preemption disabled once and never
> see it re-enabled, it seems that what we actually want is to initialize its
> preempt_count to PREEMPT_DISABLED and leave it there. Do that, and remove
> init_idle() from idle_thread_get().
> 
> Secondary startups were patched via coccinelle:
> 
>   @begone@
>   @@
> 
>   -preempt_disable();
>   ...
>   cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20210512094636.2958515-1-valentin.schneider@arm.com

This patch results in several messages similar to the following
when booting s390 images in qemu.

[    1.690807] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[    1.690925] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    1.691053] no locks held by swapper/0/1.
[    1.691310] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-11788-g79160a603bdb #1
[    1.691469] Hardware name: QEMU 2964 QEMU (KVM/Linux)
[    1.691612] Call Trace:
[    1.691718]  [<0000000000d98bb0>] show_stack+0x90/0xf8
[    1.692040]  [<0000000000da894c>] dump_stack_lvl+0x74/0xa8
[    1.692134]  [<0000000000187e52>] ___might_sleep+0x15a/0x170
[    1.692228]  [<000000000014f588>] cpus_read_lock+0x38/0xc0
[    1.692320]  [<0000000000182e8a>] smpboot_register_percpu_thread+0x2a/0x160
[    1.692412]  [<00000000014814b8>] cpuhp_threads_init+0x28/0x60
[    1.692505]  [<0000000001487a30>] smp_init+0x28/0x90
[    1.692597]  [<00000000014779a6>] kernel_init_freeable+0x1f6/0x270
[    1.692689]  [<0000000000db7466>] kernel_init+0x2e/0x160
[    1.692779]  [<0000000000103618>] __ret_from_fork+0x40/0x58
[    1.692870]  [<0000000000dc6e12>] ret_from_fork+0xa/0x30

Reverting this patch fixes the problem.
Bisect log is attached.

Guenter

---
# bad: [007b350a58754a93ca9fe50c498cc27780171153] Merge tag 'dlm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start '007b350a5875' '62fb9874f5da'
# bad: [36824f198c621cebeb22966b5e244378fa341295] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 36824f198c621cebeb22966b5e244378fa341295
# bad: [9269d27e519ae9a89be8d288f59d1ec573b0c686] Merge tag 'timers-nohz-2021-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 9269d27e519ae9a89be8d288f59d1ec573b0c686
# good: [69609a91ac1d82f9c958a762614edfe0ac8498e3] Merge tag 'spi-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect good 69609a91ac1d82f9c958a762614edfe0ac8498e3
# good: [a15286c63d113d4296c58867994cd266a28f5d6d] Merge tag 'locking-core-2021-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good a15286c63d113d4296c58867994cd266a28f5d6d
# bad: [0159bb020ca9a43b17aa9149f1199643c1d49426] Documentation: Add usecases, design and interface for core scheduling
git bisect bad 0159bb020ca9a43b17aa9149f1199643c1d49426
# good: [97886d9dcd86820bdbc1fa73b455982809cbc8c2] sched: Migration changes for core scheduling
git bisect good 97886d9dcd86820bdbc1fa73b455982809cbc8c2
# bad: [fcb501704554eebfd27e3220b0540997fd2b24a8] delayacct: Document task_delayacct sysctl
git bisect bad fcb501704554eebfd27e3220b0540997fd2b24a8
# bad: [cc00c1988801dc71f63bb7bad019e85046865095] sched: Fix leftover comment typos
git bisect bad cc00c1988801dc71f63bb7bad019e85046865095
# good: [7ac592aa35a684ff1858fb9ec282886b9e3575ac] sched: prctl() core-scheduling interface
git bisect good 7ac592aa35a684ff1858fb9ec282886b9e3575ac
# bad: [f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674] sched/core: Initialize the idle task with preemption disabled
git bisect bad f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
# good: [9f26990074931bbf797373e53104216059b300b1] kselftest: Add test for core sched prctl interface
git bisect good 9f26990074931bbf797373e53104216059b300b1
# first bad commit: [f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674] sched/core: Initialize the idle task with preemption disabled
