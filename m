Return-Path: <linux-tip-commits+bounces-6188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF9B0FFD9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jul 2025 07:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AC9547D81
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jul 2025 05:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6017332C;
	Thu, 24 Jul 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDf7fPKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11C2A1BB;
	Thu, 24 Jul 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334177; cv=none; b=LsPMZ0+Ar6+wqLkwd46Xd396+nxJuu+s1LyP09SOY1mwRQCq9naDywIy/mRiUvUGJiFWhH4EulCjFtHt67JH2a7BJQV+OUK3yRUfYiZnhu1dzh4SslVTr8hnpADhzSdfo6f0g5Dev+zOI0ME/3CcX9TEB6g8H7PbOZ4YEYiTMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334177; c=relaxed/simple;
	bh=ChjVuI92grVv1Wb2zdKvfkGA/KdPS2ntIBxgSs2cy58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVWbUZAgzcT2bE+xkXEsvaFMoX8KtfVoz+GnPztHDBOas4ZhBg5fSX62mdnm3ZcRnPBO9Yck+iPw3GCgQBMSCS99g1L0fL2q42nXq0FCtOL0t5PAI96i3HF/CVVYBx3kRw6zcxY+QllT8n8rzZ1ZG4aq/mQzkV2qlByHWF2uYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDf7fPKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3550AC4CEED;
	Thu, 24 Jul 2025 05:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753334177;
	bh=ChjVuI92grVv1Wb2zdKvfkGA/KdPS2ntIBxgSs2cy58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDf7fPKvrbph1QdRpdmMP1z3QCXzHu++/Y+tNqfUMDcJkq+/L4GysacmuFXgk22jc
	 75N8KslaSQq6uIm3+in+iMrdqLIvw/VmhZtRM2ceSHB38C34EpYGPXjg4yk7yRGNEk
	 u7OaKXHzlJ3uDkLp1MyYQQCwNzrZwzGq40UZjQfWdLFBQtQeeLcdSEyPF10nmLF66Z
	 MARPPCh2EdnesPU4JwD7wjM6DDnc7WvY68KW7o/XvCKKBAqRRX6xSBdwXsQ1J5NLmq
	 q7qpZQ1VqnlxyLLFU3uQHkWuSXl3rAkwMYvTXcahJN6NBQbO9qJtN72FaJsksOviPs
	 U/1ZSxMOu5vfA==
Date: Thu, 24 Jul 2025 07:16:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-tip-commits@vger.kernel.org, Donghoon Yu <hoony.yu@samsung.com>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	John Stultz <jstultz@google.com>,
	Will McVicker <willmcvicker@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
Message-ID: <aIHBnFESZwjpXzjr@gmail.com>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>


* tip-bot2 for Will McVicker <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the timers/clocksource branch of tip:
> 
> Commit-ID:     394b981382e6198363cf513f6eb6be4c55b22e44
> Gitweb:        https://git.kernel.org/tip/394b981382e6198363cf513f6eb6be4c55b22e44
> Author:        Will McVicker <willmcvicker@google.com>
> AuthorDate:    Fri, 20 Jun 2025 11:17:05 -07:00
> Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
> CommitterDate: Tue, 15 Jul 2025 13:00:50 +02:00
> 
> clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64
> 
> The MCT register is unfortunately very slow to access, but importantly
> does not halt in the c2 idle state. So for ARM64, we can improve
> performance by not registering the MCT for sched_clock, allowing the
> system to use the faster ARM architected timer for sched_clock instead.
> 
> The MCT is still registered as a clocksource, and a clockevent in order
> to be a wakeup source for the arch_timer to exit the "c2" idle state.
> 
> Since ARM32 SoCs don't have an architected timer, the MCT must continue
> to be used for sched_clock. Detailed discussion on this topic can be
> found at [1].
> 
> [1] https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email-chirantan@chromium.org/
> 
> [Original commit from https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6eb8dd00727
> 
> Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
> Acked-by: John Stultz <jstultz@google.com>
> Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

The whole SOB chain of this commit is messy and has several serious 
problems:

1)

This commit has misattributed authorship: the first SOB is:

   Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>

but the Author field is not Donghoon Yu:

   Author:        Will McVicker <willmcvicker@google.com>

2)

The Reviewed-by tag is misapplied:

> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>

When someone passes along a patch, it's implicit that they have 
reviewed it.

3)

There's also a stray Tested-by tag by one of the SOB entries:

> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
> Tested-by: Youngmin Nam <youngmin.nam@samsung.com>

When someone passes along a patch, it's implicit that they not only 
have reviewed the patch, but have also tested it to a certain extent 
...

4)

Why is the 'Link' tag just in the middle of the SOB chain, instead at the end of it?


Presumably this is the proper SOB chain:

> Author:        Donghoon Yu <hoony.yu@samsung.com>

> Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: John Stultz <jstultz@google.com>
> Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com

Correct?

Thanks,

	Ingo

