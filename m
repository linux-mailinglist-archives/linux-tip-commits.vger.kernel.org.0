Return-Path: <linux-tip-commits+bounces-2040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C0950C49
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81EE1F24F2F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D41A3BDF;
	Tue, 13 Aug 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh4aeWxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE311A3BC4;
	Tue, 13 Aug 2024 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573737; cv=none; b=tuvAy5McodQeMzCzWLe9/rF0eXv4rrD0LCbOpPMhkM3ESxXfLnM83FDZ4rusx8DltOd0SwMCRAQgweJlJHRSORKuFQWMz0EJ2kZiJpdjI9Z06V6B9jjK/Z8mzIVoBlIuDKt2zOa3iXzByQn01t4AV9z4MyjWdPs4S69aV5n8Pts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573737; c=relaxed/simple;
	bh=m45hRkQxiY9mOk4MhjJuLHqi9GNnmOj4babgDsDsd88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1d9igkL/SLyGBqOrpUug/hSaxPwzYp6CMGC81lBNtaeh2LKQCyqgzTlia0TPiRIN89cuP2bvT2SEoiIZAripZpA5/EzfqOA83B/dXrnesm1j1iwvGdA+waYn61wWVGVPzAQNnf4wueaQQ80SL6FbmL4jFwNKpNdyeNGmPuAEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh4aeWxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B39C4AF0B;
	Tue, 13 Aug 2024 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723573736;
	bh=m45hRkQxiY9mOk4MhjJuLHqi9GNnmOj4babgDsDsd88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fh4aeWxFNx3V2q0AJ7yXjhNSTEzc9VCNu3bQiDRUd1qnbiWrKC5WbY5hP2QqAfGgH
	 lAZDh6Nv7QadGbMO5dRlAJ08ib41yduaHpk+ySaYUgdT+aAXTw1jz9rtxZoKkiin6/
	 gi0eWaYx3EIoWJMgiHtkMpkJzj93nOB+MAUeXMrXrkPpH8OFXiyCow6z0xwPpC3Mvw
	 hcorIwrl8ZLlv5tdGOS/cWb7qJz191AGMBjXnP95D6S75X9V+3lYVujCthwOtO/ATZ
	 HVWR9c0EuxG7Gii1T8PDhDnGrBtEF6CvyLMPTNV5Gcd/ipYYrXp3j+Se+JRTXlmh0z
	 ipEZgtU2/ohRg==
Date: Tue, 13 Aug 2024 11:28:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: pengfei.xu@intel.com, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	x86@kernel.org, lkft-triage@lists.linaro.org,
	dan.carpenter@linaro.org, anders.roxell@linaro.org, arnd@arndb.de,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [tip: perf/core] perf: Fix event_function_call() locking
Message-ID: <Zrul5kzUc-5BfWcT@google.com>
References: <Zrq4PRAVxjlnvFnb@xpf.sh.intel.com>
 <20240813151959.99058-1-naresh.kamboju@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813151959.99058-1-naresh.kamboju@linaro.org>

Hello,

On Tue, Aug 13, 2024 at 08:49:59PM +0530, Naresh Kamboju wrote:
> While running LTP test cases splice07 and perf_event_open01 found following
> kernel BUG running on arm64 device juno-r2 and qemu-arm64 on the Linux
> next-20240812 and next-20240813 tag.
> 
>   GOOD: next-20240809
>   BAD: next-20240812
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> --------
> [ 2278.760258] check_preemption_disabled: 15 callbacks suppressed
> [ 2278.760282] BUG: using smp_processor_id() in preemptible [00000000] code: perf_event_open/111076
> [ 2278.775032] caller is debug_smp_processor_id+0x20/0x30
> [ 2278.780270] CPU: 5 UID: 0 PID: 111076 Comm: perf_event_open Not tainted 6.11.0-rc3-next-20240812 #1
> [ 2278.789344] Hardware name: ARM Juno development board (r2) (DT)
> [ 2278.795276] Call trace:
> [ 2278.797724]  dump_backtrace+0x9c/0x128
> [ 2278.801487]  show_stack+0x20/0x38
> [ 2278.804812]  dump_stack_lvl+0xbc/0xd0
> [ 2278.808487]  dump_stack+0x18/0x28
> [ 2278.811811]  check_preemption_disabled+0xd8/0xf8
> [ 2278.816446]  debug_smp_processor_id+0x20/0x30
> [ 2278.820818]  event_function_call+0x54/0x168
> [ 2278.825015]  _perf_event_enable+0x78/0xa8
> [ 2278.829037]  perf_event_for_each_child+0x44/0xa0
> [ 2278.833672]  _perf_ioctl+0x1bc/0xae0
> [ 2278.837262]  perf_ioctl+0x58/0x90
> [ 2278.840590]  __arm64_sys_ioctl+0xb4/0x100
> [ 2278.844615]  invoke_syscall+0x50/0x120
> [ 2278.848381]  el0_svc_common.constprop.0+0x48/0xf0
> [ 2278.853103]  do_el0_svc+0x24/0x38
> [ 2278.856432]  el0_svc+0x3c/0x108
> [ 2278.859585]  el0t_64_sync_handler+0x120/0x130
> [ 2278.863956]  el0t_64_sync+0x190/0x198
> [ 2279.068732] BUG: using smp_processor_id() in preemptible [00000000] code: perf_event_open/111076
> [ 2279.077570] caller is debug_smp_processor_id+0x20/0x30
> [ 2279.082754] CPU: 1 UID: 0 PID: 111076 Comm: perf_event_open Not tainted 6.11.0-rc3-next-20240812 #1
> [ 2279.091823] Hardware name: ARM Juno development board (r2) (DT)
> 
> Full test log:
> ---------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240813/testrun/24833616/suite/log-parser-test/test/check-kernel-bug/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240813/testrun/24833616/suite/log-parser-test/tests/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240812/testrun/24821160/suite/log-parser-test/test/check-kernel-bug-483bde618da4ec98e33eefb5e26adeb267f80cc2461569605f3166ce12b3fe82/log
> 
> metadata:
>   artifact-location: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kXsz6nJO7pJ1nL4xGlKHYhiLx9/
>   build-url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kXsz6nJO7pJ1nL4xGlKHYhiLx9/
>   build_name: gcc-13-lkftconfig-debug
>   git_describe: next-20240812
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 9e6869691724b12e1f43655eeedc35fade38120c
>   kernel-config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kXsz6nJO7pJ1nL4xGlKHYhiLx9/config
>   kernel_version: 6.11.0-rc3
>   toolchain: gcc-13

Thanks for the report, can you please check if it solves the problem?

Thanks,
Namhyung

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9893ba5e98aa..85204c2376fa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -298,13 +298,14 @@ static int event_function(void *info)
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_cpu_context *cpuctx;
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
 	struct event_function_struct efs = {
 		.event = event,
 		.func = func,
 		.data = data,
 	};
+	unsigned long flags;
 
 	if (!event->parent) {
 		/*
@@ -327,22 +328,27 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
+	local_irq_save(flags);
+	cpuctx = this_cpu_ptr(&perf_cpu_context);
+
 	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
-	if (task == TASK_TOMBSTONE) {
-		perf_ctx_unlock(cpuctx, ctx);
-		return;
-	}
+	if (task == TASK_TOMBSTONE)
+		goto out;
+
 	if (ctx->is_active) {
 		perf_ctx_unlock(cpuctx, ctx);
+		local_irq_restore(flags);
 		goto again;
 	}
 	func(event, NULL, ctx, data);
+out:
 	perf_ctx_unlock(cpuctx, ctx);
+	local_irq_restore(flags);
 }
 
 /*

