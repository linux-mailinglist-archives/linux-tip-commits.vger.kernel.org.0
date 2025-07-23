Return-Path: <linux-tip-commits+bounces-6173-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2128CB0EBA9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA647A27A8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C4274FE9;
	Wed, 23 Jul 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VatBvul1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9fG79Gc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D5274B47;
	Wed, 23 Jul 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255053; cv=none; b=NqVuaFAkkES4hOEC58HWvolhnYbLC+xu0PldVDfVDLQKfNdoYpFC6olJSq5n8bsF40Y4eXULjh6DqNfA43PCvf/dhmdMsMFaj4uaFu4TivD3Xz+5ErcSspnlLj5HoXqpdd8xvHAQUudOv/jM7fs39QxaT87K7q/GoV1mvvdSA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255053; c=relaxed/simple;
	bh=yd+JHZvbbPV50+GxXJg2SPdPIRgn4l68mUOsztc9l0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eHSpWAjFlBJQAiUvA/VveoJs9TK+ow6UIZaJP1ISVN2vt49fQggtufc5yrc7ICwYA6oK7EIfLDFW8mv6hkxZNbtLUXzlrYhNp4Hgct1eAMxp1Gry5VJ1Oq0KFWEPLES3ps/RfFodOdkuTagxsVJkA/E95H4HjoI+fqfJfsVBDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VatBvul1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9fG79Gc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfEpNv3FAbLjWw/QX/MJlyiPaIDqYVhkfDS4rtSK59w=;
	b=VatBvul1EqhC+8B2qOv+tuWB+E/sTWjCZ8z3MAMN3L4HHFOxo9N1Syiset49tzkL9kXFQN
	AskwN1iynIZK+ilEwxeTCRsAyO4ft4X3GfeJrk9gxsqbLNbIdbgJiLsFb47pkPcUvVZ9ie
	4IEw+28Qe/ciAi17RT6K10HggWC36z4xrfxwFVab6F0khTJTVLjIyootjyyyt5eiMnzthC
	fzsLqQxOCoAUjmkEDMZ2NMj5W4pteCwsmfBbSiz4bOHXTEmn+c3c3Y6MuKBw/CihzdBNex
	hbYadqaNjP/iE2Fj8cExl6JYcBeWjgLfSzRPBxArLRep4cjer9/UlGOGAO+U/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfEpNv3FAbLjWw/QX/MJlyiPaIDqYVhkfDS4rtSK59w=;
	b=M9fG79Gca7xWiaVNCP0gRNPlsYF2f5MwSyzHPpEUUPw4EQsfYWg0qtXRkhhzQ+Ko9w2tDt
	+K1HDNgr2HZLmGDQ==
From: "tip-bot2 for Hosung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Set local
 timer interrupts as percpu
Cc: Hosung Kim <hosung0.kim@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-4-willmcvicker@google.com>
References: <20250620181719.1399856-4-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504872.1420.16470158595930821063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     10934da577f627a97db18cf05dbe0c3c1b4a68d6
Gitweb:        https://git.kernel.org/tip/10934da577f627a97db18cf05dbe0c3c1b4=
a68d6
Author:        Hosung Kim <hosung0.kim@samsung.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:06 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:00:50 +02:00

clocksource/drivers/exynos_mct: Set local timer interrupts as percpu

To allow the CPU to handle it's own clock events, we need to set the
IRQF_PERCPU flag. This prevents the local timer interrupts from
migrating to other CPUs.

Signed-off-by: Hosung Kim <hosung0.kim@samsung.com>
[Original commit from https://android.googlesource.com/kernel/gs/+/03267fad19=
f093bac979ca78309483e9eb3a8d16]
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-4-willmcvicker@google.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

