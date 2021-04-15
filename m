Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3498360BE0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhDOOez (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 10:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOOez (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 10:34:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A5C061574;
        Thu, 15 Apr 2021 07:34:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n8so39654200lfh.1;
        Thu, 15 Apr 2021 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAiGdDMjV3w/bmHPCKTZ38AvctziY46kn5qhLkuysBM=;
        b=Mxiueoq5hgyhrUVfdJUkpWm/fK667IjKkfYcb7A9BOaEOzF7f828TbdiUl/zOPznN9
         ghz1V8GXeKZbRy4rWFGd3gxyaGrDxHqmIW0LSePFV1+DTRtddc64AyZJt/8o0sYN1DqU
         bGrCLY1t4rwqx0SFpgV/bBIFXsA7GNkxvUCPH2CFSux/u8l0nqzY+ocTc/CWAY6k0FPM
         L5iwLpdHWBA+avgr87rrOzc6NaBMlEKbvGEtzwx7BvDDOBSAv0yf54unUlVWS1j57mih
         1STVDZ6KhzoINVD1HdFO9WR9fHKB+3gZFL90ys6h39X8ccbKWReqeL3kk93VjmQhPXN1
         COlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAiGdDMjV3w/bmHPCKTZ38AvctziY46kn5qhLkuysBM=;
        b=PIggoSeRLTxxR+4jGmli4h4S7Iz5k/VIyS7VPOC/9soK49bDTHhVIkgRZ9U1MQgjrv
         hkLFISjxsenAsQDgJjrswXwve/D5WJl3nrRRj+/2csnIFt9GfhV5l9NQUuW75tltYO7j
         VMnGZcpz73icmzw/lhqcyFNsoThrjguWm9CbdzyirsS7hPIY2rPBpiM6rr11Wzcje58p
         jpEHs4kCdVQA96kOeBNHQF2t4tYOduYtZ09KuOOdml/heOMzIdnn3BIR4pS99oSyipkO
         0QHrrInvOEvY2Pc16ogu5jZNmOps5G2D1JaQ37ph5TPtYmLr90xO+tRcw8VkAdoVfGJJ
         Wgjg==
X-Gm-Message-State: AOAM532/083Vk99/CP0AdQw6OwcNS1bIkMo28wAO2fNi3rffWdaEaouA
        oyMFdnNdPbbNYm5Ak/Ol965zCk6vtgk=
X-Google-Smtp-Source: ABdhPJxhRfPDkCWUFQmDxB5/TxlpxDOlg3JamFgDT6Lzzbkwek2dF2pefDSS3TkLFWSPFQCCX6qSug==
X-Received: by 2002:ac2:491d:: with SMTP id n29mr2814040lfi.541.1618497269163;
        Thu, 15 Apr 2021 07:34:29 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j17sm670034lfe.222.2021.04.15.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:34:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 15 Apr 2021 16:34:26 +0200
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it
 has been spawned
Message-ID: <20210415143426.GA14967@pc638.lan>
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
 <87czuz1tbc.ffs@nanos.tec.linutronix.de>
 <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <20210414071322.nz64kow4sp4nwzmy@linutronix.de>
 <20210414085757.GA1917@pc638.lan>
 <20210414181158.GU4510@paulmck-ThinkPad-P17-Gen-1>
 <87tuo8v2vp.ffs@nanos.tec.linutronix.de>
 <20210415050225.GC4510@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415050225.GC4510@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

> 
> Another approach is to move the spawning of ksoftirqd earlier.  This
> still leaves a window of vulnerability, but the window is smaller, and
> thus the probablity of something needing to happen there is smaller.
> Uladzislau sent out a patch that did this some weeks back.
> 
See below the patch that is in question, just in case:

<snip>
commit f4cd768e341486655c8c196e1f2b48a4463541f3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Feb 12 16:41:05 2021 -0800

    softirq: Don't try waking ksoftirqd before it has been spawned

    If there is heavy softirq activity, the softirq system will attempt
    to awaken ksoftirqd and will stop the traditional back-of-interrupt
    softirq processing.  This is all well and good, but only if the
    ksoftirqd kthreads already exist, which is not the case during early
    boot, in which case the system hangs.

    One reproducer is as follows:

    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make

    This commit therefore moves the spawning of the ksoftirqd kthreads
    earlier in boot.  With this change, the above test passes.

    Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Reported-by: Uladzislau Rezki <urezki@gmail.com>
    Inspired-by: Uladzislau Rezki <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index bb8ff90..283a02d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -592,6 +592,8 @@ static inline struct task_struct *this_cpu_ksoftirqd(void)
        return this_cpu_read(ksoftirqd);
 }

+int spawn_ksoftirqd(void);
+
 /* Tasklets --- multithreaded analogue of BHs.

    This API is deprecated. Please consider using threaded IRQs instead:
diff --git a/init/main.c b/init/main.c
index c68d784..99835bb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1512,6 +1512,7 @@ static noinline void __init kernel_init_freeable(void)

        init_mm_internals();

+       spawn_ksoftirqd();
        rcu_init_tasks_generic();
        do_pre_smp_initcalls();
        lockup_detector_init();
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9d71046..45d50d4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -724,7 +724,7 @@ static struct smp_hotplug_thread softirq_threads = {
        .thread_comm            = "ksoftirqd/%u",
 };

-static __init int spawn_ksoftirqd(void)
+__init int spawn_ksoftirqd(void)
 {
        cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
                                  takeover_tasklets);
@@ -732,7 +732,6 @@ static __init int spawn_ksoftirqd(void)



        return 0;
 }
-early_initcall(spawn_ksoftirqd);

 /*
  * [ These __weak aliases are kept in a separate compilation unit, so that
<snip>

Thanks.

--
Vlad Rezki
