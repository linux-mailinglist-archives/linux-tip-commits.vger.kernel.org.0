Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB43625F2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhDPQqL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbhDPQqL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 12:46:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B657DC061574;
        Fri, 16 Apr 2021 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SU5YU752/kL0HaPZmbBFtkCpzORBnBap3r0L072kgFA=; b=EmquF9WRfeZAXpLdxYmAEyD/+m
        rdESI31uBHBJap7lOaAMrfjD2CroYlehdGzR/+9Ci9TFaMnlcZXsQwZI9Ld3fpYYxxvn8EoECHAkX
        CUhR0HOpTbrCTZNfo9GA3gzOphG/mwLmIyyAkvakYMerDmIDd0nHhliFC8xt1KS+yovXSbERgPBxP
        mzQ65IfBUTwrAzEZhOG+Gpif57rk2FDYQlXEdx/9Y0p9TwRXBDxrJS8X2qMbRS4Ht98Qi4a3OBv3u
        tRVaT5AM2Io0Vr570JjLw1/ZXroB/oJvzFhC/GGqm+g0Iyq/Fg30LqhCeGrmEwQTh95WAn21w7rg+
        b2eh3+3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXRbB-002qOF-2K; Fri, 16 Apr 2021 16:45:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3A6C300212;
        Fri, 16 Apr 2021 18:45:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF14320C8DE34; Fri, 16 Apr 2021 18:45:39 +0200 (CEST)
Date:   Fri, 16 Apr 2021 18:45:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/x86: Reset the dirty counter to prevent
 the leak for an RDPMC task
Message-ID: <YHm/M4za2LpRYePw@hirez.programming.kicks-ass.net>
References: <1618410990-21383-2-git-send-email-kan.liang@linux.intel.com>
 <161858530850.29796.5870405530830102241.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161858530850.29796.5870405530830102241.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Apr 16, 2021 at 03:01:48PM -0000, tip-bot2 for Kan Liang wrote:
> @@ -2331,6 +2367,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
>  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>  		return;
>  
> +	if (x86_pmu.sched_task && event->hw.target)
> +		perf_sched_cb_dec(event->ctx->pmu);
> +
>  	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>  		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>  }

'perf test' on a kernel with CONFIG_DEBUG_PREEMPT=y gives:

[  244.439538] BUG: using smp_processor_id() in preemptible [00000000] code: perf/1771
[  244.448144] caller is perf_sched_cb_dec+0xa/0x70
[  244.453314] CPU: 28 PID: 1771 Comm: perf Not tainted 5.12.0-rc3-00026-gb04c0cddff6d #595
[  244.462347] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
[  244.473804] Call Trace:
[  244.476535]  dump_stack+0x6d/0x89
[  244.480237]  check_preemption_disabled+0xc8/0xd0
[  244.485394]  perf_sched_cb_dec+0xa/0x70
[  244.489677]  x86_pmu_event_unmapped+0x35/0x60
[  244.494541]  perf_mmap_close+0x76/0x580
[  244.498833]  remove_vma+0x31/0x70
[  244.502535]  __do_munmap+0x2e8/0x4e0
[  244.506531]  __vm_munmap+0x7e/0x120
[  244.510429]  __x64_sys_munmap+0x28/0x30
[  244.514712]  do_syscall_64+0x33/0x80
[  244.518701]  entry_SYSCALL_64_after_hwframe+0x44/0xae


Obviously I tested that after I pushed it out :/

