Return-Path: <linux-tip-commits+bounces-6747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D6DBA194E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815E72A433F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A932A83C;
	Thu, 25 Sep 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgbGoYw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiSq20h/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0032A810;
	Thu, 25 Sep 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836012; cv=none; b=Tw9dveEfhzKFmGCqtAX+vUQPiGZUL/WdgsbFOSjyU96UKU2jmddHo9JlrC5X6GRoH0wH8+gcZYy/x9oKWzaAht0IPnEDJRukj5iyxCJWq5LqhVEnMFqYohTVqGqOx5mypEN4CKVWtHrlfm6iZvsKkxjbdhPdkWe1RYE7ZP9Md24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836012; c=relaxed/simple;
	bh=NZvjKTMBrlYAHSMqkBCC1oRr5QHgTBxWVuLtregSa5g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=D8XHVyYXObR5ZV3ysF/Kh18CAdt7ola+74gEmfWq5thfFlbuXYJX0MJOuVcbrcnYSwO5EmkgR9uTb9PvnPtxKyR3e8tepRpb5K/JVXSbb9U2gK4XeAkBzPYfR9gGC/1bXtuv5QraP69CIMQ6dPS+2EUvL+EKKhDOZMxxVQQf1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgbGoYw2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiSq20h/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HR3+SJJ7nCr7B3uhlDK89XKbNJOSU0ahp/eKAwjliGc=;
	b=wgbGoYw2S87wk6m0+WO1roUODlBBRHYo6SFjsengypd274fYlTpmqzaU5IosiUr0fmU7he
	FB31I09sTR7GegPzjZRRXxeC5qo0WZeJOleHd4uCaxo74p4wQOI8utIq8Yh4lyzfcN1jl1
	b+ae90N09OYisCyWzXEoR+QQS1S9Ez6FiNQMVA8i2UT4l436XiqjyHz7mKlogL/b9l0Dba
	/WYMAjkJXNUWsHB/uNqPsUj6wpfFkwkn3jPBsw7Z+iPBkq8VhqP7tzuV/X2zSPOuUzPTp5
	nLIP6/p+BU9RzqRv2KAkswObXX7SiOAPb+CyWkSuQw5sJuamq/lBEoWm5k3R4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HR3+SJJ7nCr7B3uhlDK89XKbNJOSU0ahp/eKAwjliGc=;
	b=YiSq20h/Td6YBn4lSe/k+BBREvHcaz8pkodFCzWC+jjhh2KDMs1ZAQql4xdSsU6QACk/dO
	3vMyQiY98AnqfyDA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Encapsulate the
 PTLCVAL macro
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600706.709179.12606982561300388866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d8629b9b2c17a458ca504b10b604b8cfe95df3ab
Gitweb:        https://git.kernel.org/tip/d8629b9b2c17a458ca504b10b604b8cfe95=
df3ab
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:29 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:29 +02:00

clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro

Pass the channel and the base address to the PITLCVAL macro so it is
possible to use multiple instances of the timer with the macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-12-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index c81c68b..4f1b85b 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -17,13 +17,14 @@
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
=20
-#define PITCVAL		0x04
-
 #define PITMCR_MDIS	BIT(1)
=20
 #define PITLDVAL(__base)	(__base)
 #define PITTCTRL(__base)	((__base) + 0x08)
=20
+#define PITCVAL_OFFSET	0x04
+#define PITCVAL(__base)	((__base) + 0x04)
+
 #define PITTCTRL_TEN			BIT(0)
 #define PITTCTRL_TIE			BIT(1)
=20
@@ -39,7 +40,7 @@ struct pit_timer {
 	struct clocksource cs;
 };
=20
-static void __iomem *clksrc_base;
+static void __iomem *sched_clock_base;
=20
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 {
@@ -68,14 +69,14 @@ static inline void pit_irq_acknowledge(struct pit_timer *=
pit)
=20
 static u64 notrace pit_read_sched_clock(void)
 {
-	return ~readl(clksrc_base + PITCVAL);
+	return ~readl(sched_clock_base);
 }
=20
 static u64 pit_timer_clocksource_read(struct clocksource *cs)
 {
 	struct pit_timer *pit =3D cs_to_pit(cs);
=20
-	return (u64)~readl(pit->clksrc_base + PITCVAL);
+	return (u64)~readl(PITCVAL(pit->clksrc_base));
 }
=20
 static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *=
base,
@@ -98,8 +99,7 @@ static int __init pit_clocksource_init(struct pit_timer *pi=
t, void __iomem *base
 	writel(~0, PITLDVAL(pit->clksrc_base));
 	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
=20
-	clksrc_base =3D pit->clksrc_base;
-
+	sched_clock_base =3D pit->clksrc_base + PITCVAL_OFFSET;
 	sched_clock_register(pit_read_sched_clock, 32, rate);
=20
 	return clocksource_register_hz(&pit->cs, rate);

