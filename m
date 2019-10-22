Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC5E04A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2019 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfJVNOc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Oct 2019 09:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbfJVNOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Oct 2019 09:14:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CF72184C;
        Tue, 22 Oct 2019 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571750071;
        bh=CL/xFvn31VTj0bWYIaumiEDX4FAE4FmWveGE7TbKL9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RViUNS18ImkiWCTnB2mPBcKZ3iLu60VuBhL9A/Tf6vUWIydt3+8HSBWu/kw05m9sW
         ASHvuTfm2rRRAOlD312WjI1lNk+IPQ+uh+UtsltUD09tRHoBFs7ABRlxwayL3BsHj7
         F951rSf39+qtAHQa5xBadQSSoGGPPqz7oZLg1F7c=
Date:   Tue, 22 Oct 2019 14:14:25 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: perf/core] perf tests: Disable bp_signal testing for arm64
Message-ID: <20191022131423.GA17920@willie-the-truck>
References: <20191018085531.6348-3-leo.yan@linaro.org>
 <157169993406.29376.12473771029179755767.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157169993406.29376.12473771029179755767.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Oct 21, 2019 at 11:18:54PM -0000, tip-bot2 for Leo Yan wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     6a5f3d94cb69a185b921cb92c39888dc31009acb
> Gitweb:        https://git.kernel.org/tip/6a5f3d94cb69a185b921cb92c39888dc31009acb
> Author:        Leo Yan <leo.yan@linaro.org>
> AuthorDate:    Fri, 18 Oct 2019 16:55:31 +08:00
> Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
> CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00
> 
> perf tests: Disable bp_signal testing for arm64
> 
> As there are several discussions for enabling perf breakpoint signal
> testing on arm64 platform: arm64 needs to rely on single-step to execute
> the breakpointed instruction and then reinstall the breakpoint exception
> handler.  But if we hook the breakpoint with a signal, the signal
> handler will do the stepping rather than the breakpointed instruction,
> this causes infinite loops as below:
> 
>          Kernel space              |            Userspace
>   ---------------------------------|--------------------------------
>                                    |  __test_function() -> hit
> 				   |                       breakpoint
>   breakpoint_handler()             |
>     `-> user_enable_single_step()  |
>   do_signal()                      |
>                                    |  sig_handler() -> Step one
> 				   |                instruction and
> 				   |                trap to kernel
>   single_step_handler()            |
>     `-> reinstall_suspended_bps()  |
>                                    |  __test_function() -> hit
> 				   |     breakpoint again and
> 				   |     repeat up flow infinitely
> 
> As Will Deacon mentioned [1]: "that we require the overflow handler to
> do the stepping on arm/arm64, which is relied upon by GDB/ptrace. The
> hw_breakpoint code is a complete disaster so my preference would be to
> rip out the perf part and just implement something directly in ptrace,
> but it's a pretty horrible job".  Though Will commented this on arm
> architecture, but the comment also can apply on arm64 architecture.
> 
> For complete information, I searched online and found a few years back,
> Wang Nan sent one patch 'arm64: Store breakpoint single step state into
> pstate' [2]; the patch tried to resolve this issue by avoiding single
> stepping in signal handler and defer to enable the signal stepping when
> return to __test_function().  The fixing was not merged due to the
> concern for missing to handle different usage cases.
> 
> Based on the info, the most feasible way is to skip Perf breakpoint
> signal testing for arm64 and this could avoid the duplicate
> investigation efforts when people see the failure.  This patch skips
> this case on arm64 platform, which is same with arm architecture.
> 
> [1] https://lkml.org/lkml/2018/11/15/205
> [2] https://lkml.org/lkml/2015/12/23/477
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Link: http://lore.kernel.org/lkml/20191018085531.6348-3-leo.yan@linaro.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/bp_signal.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index c1c2c13..166f411 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -49,14 +49,6 @@ asm (
>  	"__test_function:\n"
>  	"incq (%rdi)\n"
>  	"ret\n");
> -#elif defined (__aarch64__)
> -extern void __test_function(volatile long *ptr);
> -asm (
> -	".globl __test_function\n"
> -	"__test_function:\n"
> -	"str x30, [x0]\n"
> -	"ret\n");
> -
>  #else
>  static void __test_function(volatile long *ptr)
>  {
> @@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
>  	 * stepping into the SIGIO handler and getting stuck on the
>  	 * breakpointed instruction.
>  	 *
> +	 * Since arm64 has the same issue with arm for the single-step
> +	 * handling, this case also gets suck on the breakpointed
> +	 * instruction.

Freudian slip?

Will
