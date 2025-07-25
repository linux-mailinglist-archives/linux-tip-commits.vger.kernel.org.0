Return-Path: <linux-tip-commits+bounces-6202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7E3B11C6D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593F41CE3600
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B622E765D;
	Fri, 25 Jul 2025 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRIBnZiJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W1ZBZx2p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3312E5419;
	Fri, 25 Jul 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439508; cv=none; b=Tj6aqO0mwDftRFyZxu8DKfZ8+q2ye0hz5/EyjqETnkYS1O6l1315nHhxll2+oeyvGvKUxsLZrhpkFJbQWuFrZSUVoyalbalLxp7Su0AxjN3wIBUk3t3uLQpb5xx8+qCXxqRzlAtPsg5cS5dOJjPgroE98VQrS1mq1PGevZ1OQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439508; c=relaxed/simple;
	bh=xX7/0kxJrXzy+5IQmy4XMvEQeenyvPtXZ4d6GrnAEBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W0jDsvYqYrt8piwuLucqBnhBeGLOUZOs078TL/ftBdca+y+3nAFLp9gEOO59B4CfrABNJ5wklr8k+JOWo441mA12TNgY+SlqWIoVZbN4xyh58OKQJwTWE1KrXMjeT9FjQO8H7LyuFByFHDFqyVvKtx0U1kZfZq/jGRcX4zMdiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRIBnZiJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W1ZBZx2p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WiWeteGv3SJkz8ejS4Q7+4ukHT2B7ji+qol5usBIp0=;
	b=MRIBnZiJ8MaVxJTLlAnXH3dfStGvOYBBAnQaUti/YGKs98Hq2pOzLVTcheHipLnGl1Y+3K
	mAps8m6NyFoqQ6l+67ijmX2HyP2qgjFCvoa+/+t4hKIwvx0x2mM744MfdRt3HnY8ZBM6kd
	z6gyyxVga+aRTltXocMrOP97kGWIjHBfXAknP66oVN9iYa9ayzraMgsQoZQmF6LjhfkTEk
	Yo24dKSgppDDwnUrzLYpXidDUze8ZUQbzlgEontzOCdihwJzC+gggltCuxK3pfaon4XcFa
	E0vPejHs/4Uj2/jH5ALhUtgJZ/S7LYv623c/xHskNwthOnhdWENco4kXyPA4qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WiWeteGv3SJkz8ejS4Q7+4ukHT2B7ji+qol5usBIp0=;
	b=W1ZBZx2pudFOJ7S5HwHlyriU2iT3+9Ak0neGE1u7EEz4G8HcVDWQ2L1YlJ/3XDcAHYHl4B
	SiArNEDXiTrHpLAQ==
From: "tip-bot2 for Hosung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Set local
 timer interrupts as percpu
Cc: Hosung Kim <hosung0.kim@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-4-willmcvicker@google.com>
References: <20250620181719.1399856-4-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950250.1420.422151303248204742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     f3cec54ee3bfd50b90b9f3b7110b9357be97babe
Gitweb:        https://git.kernel.org/tip/f3cec54ee3bfd50b90b9f3b7110b9357be9=
7babe
Author:        Hosung Kim <hosung0.kim@samsung.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:06 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:05:39 +02:00

clocksource/drivers/exynos_mct: Set local timer interrupts as percpu

To allow the CPU to handle its own clock events, we need to set the
IRQF_PERCPU flag. This prevents the local timer interrupts from
migrating to other CPUs.

Original commit from:

  https://android.googlesource.com/kernel/gs/+/03267fad19f093bac979ca78309483=
e9eb3a8d16

Signed-off-by: Hosung Kim <hosung0.kim@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-4-willmcvicker@google.=
com
---
 drivers/clocksource/exynos_mct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 96361d5..a5ef7d6 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -596,7 +596,8 @@ static int __init exynos4_timer_interrupts(struct device_=
node *np,
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
 					exynos4_mct_tick_isr,
-					IRQF_TIMER | IRQF_NOBALANCING,
+					IRQF_TIMER | IRQF_NOBALANCING |
+					IRQF_PERCPU,
 					pcpu_mevt->name, pcpu_mevt)) {
 				pr_err("exynos-mct: cannot register IRQ (cpu%d)\n",
 									cpu);

