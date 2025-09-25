Return-Path: <linux-tip-commits+bounces-6748-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC7ABA1975
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B23B4A5769
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEFF32B4AE;
	Thu, 25 Sep 2025 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3Er/+Ek";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVLG1GXt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F032B486;
	Thu, 25 Sep 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836014; cv=none; b=mfcvAH52KWUsIQsi25A8GC/Uskx0KHeBE1QMVLlfSUrYnkAiykVtTbrCh6wQVyET5NfgfbvkXtDPEdWg/u+FSfh9dl4ZM09AGUWNwEUFnAQS5wv0C3XcZDXfToGgsugGnmUCb+/sEIvzqTyH75qGSww/gxWiHJQVBK9zfetQPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836014; c=relaxed/simple;
	bh=7UY8yx7LNHbOB+Ubt8AvZxiRi7K2DJASVj7Cl9aiPzc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TWJfUPXGlPSGOPAKRYjSvZ2PUPjfCbOybCWjV6RE2bcrC3jA+wqJGxUwaiKAM+GZE3SHDCefe1VM7rOv36v01U/LoDvrJS5RQOhObL0iuXylIQozCE8k019bkbbSZ9LrB2F9RSNXlfbJm3v48R/D6fv+NRth81STqBInRjUk7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3Er/+Ek; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVLG1GXt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hXlhEdussKHzTGDUW8QGDS01kYkvH/pvQUgyvvMF9YE=;
	b=k3Er/+Ekx9m4OnC85fCqcRHAJvm85po2Lf7a8V6GZ+uZU3OU/u0FmbMXadfJEpjgi/ZbXk
	DwSUfax9FYn0bgYoCvPhWHboNNanTt5lA1ZSnU8vcIOQPimDnBxARUKsaczpuJKTW0JAJs
	XKYUoh3hwF/xnt7Vdpr7AsNpgbWgjewDM/jGCXOUoWg1y39UItqGwZLugXl89bZdYsNyi0
	7byi2g30G+JDRyHTA0+ytSJjQJ6TA/6ih/EpB+S/qnbZ9JaktgRWYHXu+nBWXioYhZWo6z
	pOW5hsEHLDAGt7BvgO0tKVBC5FEZ52KYHch158Ie2ndb2X0sSV2T/BWD6LdYoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hXlhEdussKHzTGDUW8QGDS01kYkvH/pvQUgyvvMF9YE=;
	b=NVLG1GXtCTD0rSn2CUgn9z6+Jy/zbvXgaAAM+BMIy31Prid+R1CT3fR59V6BlGIQqlyhqY
	wC12pEoQLpIBBpBg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/vf-pit: Encapsulate the macros
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600826.709179.796615245730237115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     1ba63930e72356315e1a664952f52ee340edbbd3
Gitweb:        https://git.kernel.org/tip/1ba63930e72356315e1a664952f52ee340e=
dbbd3
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:28 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:22 +02:00

clocksource/drivers/vf-pit: Encapsulate the macros

Pass the base address to the macro, so we can use the macro with
multiple instances of the timer because we deal with different base
address. At the same time, change writes to the register to the
existing corresponding functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-11-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 34 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 6a40438..c81c68b 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -16,18 +16,20 @@
 #define PITMCR		0x00
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
-#define PITLDVAL	0x00
+
 #define PITCVAL		0x04
-#define PITTCTRL	0x08
-#define PITTFLG		0x0c
=20
 #define PITMCR_MDIS	BIT(1)
=20
-#define PITTCTRL_TEN	BIT(0)
-#define PITTCTRL_TIE	BIT(1)
-#define PITCTRL_CHN	BIT(2)
+#define PITLDVAL(__base)	(__base)
+#define PITTCTRL(__base)	((__base) + 0x08)
+
+#define PITTCTRL_TEN			BIT(0)
+#define PITTCTRL_TIE			BIT(1)
+
+#define PITTFLG(__base)	((__base) + 0x0c)
=20
-#define PITTFLG_TIF	0x1
+#define PITTFLG_TIF			BIT(0)
=20
 struct pit_timer {
 	void __iomem *clksrc_base;
@@ -51,17 +53,17 @@ static inline struct pit_timer *cs_to_pit(struct clocksou=
rce *cs)
=20
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
-	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
+	writel(PITTCTRL_TEN | PITTCTRL_TIE, PITTCTRL(pit->clkevt_base));
 }
=20
 static inline void pit_timer_disable(struct pit_timer *pit)
 {
-	writel(0, pit->clkevt_base + PITTCTRL);
+	writel(0, PITTCTRL(pit->clkevt_base));
 }
=20
 static inline void pit_irq_acknowledge(struct pit_timer *pit)
 {
-	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
+	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
 }
=20
 static u64 notrace pit_read_sched_clock(void)
@@ -92,9 +94,9 @@ static int __init pit_clocksource_init(struct pit_timer *pi=
t, void __iomem *base
 	pit->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	/* set the max load value and start the clock source counter */
-	writel(0, pit->clksrc_base + PITTCTRL);
-	writel(~0, pit->clksrc_base + PITLDVAL);
-	writel(PITTCTRL_TEN, pit->clksrc_base + PITTCTRL);
+	pit_timer_disable(pit);
+	writel(~0, PITLDVAL(pit->clksrc_base));
+	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
=20
 	clksrc_base =3D pit->clksrc_base;
=20
@@ -115,7 +117,7 @@ static int pit_set_next_event(unsigned long delta, struct=
 clock_event_device *ce
 	 * hardware requirement.
 	 */
 	pit_timer_disable(pit);
-	writel(delta - 1, pit->clkevt_base + PITLDVAL);
+	writel(delta - 1, PITLDVAL(pit->clkevt_base));
 	pit_timer_enable(pit);
=20
 	return 0;
@@ -171,9 +173,9 @@ static int __init pit_clockevent_init(struct pit_timer *p=
it, void __iomem *base,
 	pit->clkevt_base =3D base + PIT_CH(3);
 	pit->cycle_per_jiffy =3D rate / (HZ);
=20
-	writel(0, pit->clkevt_base + PITTCTRL);
+	pit_timer_disable(pit);
=20
-	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
+	pit_irq_acknowledge(pit);
=20
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   "VF pit timer", &pit->ced));

