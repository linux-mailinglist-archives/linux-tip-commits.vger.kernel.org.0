Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE686198065
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Mar 2020 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgC3QDR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 30 Mar 2020 12:03:17 -0400
Received: from foss.arm.com ([217.140.110.172]:56846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgC3QDR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 30 Mar 2020 12:03:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0290B1042;
        Mon, 30 Mar 2020 09:03:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A540F3F71E;
        Mon, 30 Mar 2020 09:03:15 -0700 (PDT)
References: <20200122151617.531-2-ggherdovich@suse.cz> <158029757853.396.10568128383380430250.tip-bot2@tip-bot2> <158556634294.3228.4889951961483021094@build.alporthouse.com> <20200330125219.GM20696@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Giovanni Gherdovich <tip-bot2@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] x86, sched: Add support for frequency invariance
In-reply-to: <20200330125219.GM20696@hirez.programming.kicks-ass.net>
Date:   Mon, 30 Mar 2020 17:03:04 +0100
Message-ID: <jhjimil25l3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


On Mon, Mar 30 2020, Peter Zijlstra wrote:
> +static void init_freq_invariance(bool secondary)
>  {
>  	bool ret = false;
>  
> -	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
> +	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
>  		return;
>  
> +	if (secondary) {
> +		if (static_branch_likely(&arch_scale_freq_key)) {
> +			init_counter_refs(NULL);
> +		}
> +		return;
> +	}
> +

Oh doh, that's an "enable once and for all" thing. That makes much more
sense; sorry for the noise.
