Return-Path: <linux-tip-commits+bounces-6189-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271AB0FFDF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jul 2025 07:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BC61C87F3F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jul 2025 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B151D5CD4;
	Thu, 24 Jul 2025 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLta9LLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16992A1BB;
	Thu, 24 Jul 2025 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334425; cv=none; b=Va2zHcFtXm/KsVyVU2DBMlsvxgsozqdEkENYPE2MIaCjzWLnU6mbEipBQUKfbcc1NjhGjrTG9X9SJdZRC1M7QNprTclA1dE7u7GcKMFYuBYlexSVHKFdIlo397hYmbAViMnZONxld9Tl/WHKkEuwo+/H1OvL6x5C5d8YiNKv4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334425; c=relaxed/simple;
	bh=Ztq9dcJwqZkUCNGV8Ku8WElPrwe43KanHnf4TtMVqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3LA0lP6Pf2N8nXLbUnrS6KlD7eSerw3oH3lJI6F5fQ2SqfQuYu8W+gd1bvyMF6+KqBhqhh9oNwAKBje9f21VrBQ9M6PC0e8y/kQ6Hu/DGI3y5gjjzD3OBYvaTpdhUYUrFrduViiWY2l25r5HyPo5JLzcGaOiDp0bMudfVxO+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLta9LLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B42BC4CEED;
	Thu, 24 Jul 2025 05:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753334425;
	bh=Ztq9dcJwqZkUCNGV8Ku8WElPrwe43KanHnf4TtMVqX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLta9LLlLwOvwd6K2B+Pz2fZZ96zHWQRmSDXFwWF0lBBgFAtX+jNMjy/OMDXdB5ba
	 9fisf+YAP9v0qYfaEGp6h0piR7CKn/l2qxbAfHUPTaS6vLPQwTDu6DXnAt6xSXsnvi
	 8hnujOBgxmNxXBEnA1RugJx16ilGJJ2yp+oAjg7hZgnwV/zEdnEaLhCBMGkyY6TM8X
	 iL3F2a2IWrz/cGjISJmyj7adBm+LfMQgy7aB0I+oxuBVh9joL6dxi/ytXILehteOzJ
	 kWJ3F3voWuQ44oDH4b3O2X7ujHB8FEy10S7dInokNaZfAIiMMU9jnJoI1CGQgl7Tl+
	 5YkZb0SzUQW+g==
Date: Thu, 24 Jul 2025 07:20:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-tip-commits@vger.kernel.org, Donghoon Yu <hoony.yu@samsung.com>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	John Stultz <jstultz@google.com>,
	Will McVicker <willmcvicker@google.com>, x86@kernel.org
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
Message-ID: <aIHClG3ftSeP04QW@gmail.com>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIHBnFESZwjpXzjr@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> The whole SOB chain of this commit is messy and has several serious 
> problems:

Not just this commit, but most of the other commits in 
tip:timers/clocksource have various problems in their tag sections ... 
I only checked these more closely:

 5d86e479193b clocksource/drivers/exynos_mct: Add module support
 60618eec98f0 clocksource/drivers/exynos_mct: Fix uninitialized irq name warning
 10934da577f6 clocksource/drivers/exynos_mct: Set local timer interrupts as percpu
 394b981382e6 clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64

but all of them have various problems. And literally all 23 commits 
have the Link tag misplaced in the middle of the tag section.

Thanks,

	Ingo

