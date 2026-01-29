Return-Path: <linux-tip-commits+bounces-8139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LVkKePRe2nrIgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:32:19 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2003CB4C35
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 173AB30143E7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951035CBB6;
	Thu, 29 Jan 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyPyPjpf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJ0V72q3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633017BCA;
	Thu, 29 Jan 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722331; cv=none; b=M8km4PIYT48kz+sNL4sfluPYsI3SYpGy3oDl4e+PXOD4Tcn3ZWZ6EeBaEFHMB8GuE7EI68ZaaXsHKxQZC1NLPuBhnMLXbSInJNJbeVxj3kLV4kVvAtoNfiv/UQuhJYLSMbzWZULATEPy5xZwWz0itZgfigZ0uMXA3jVl25VxWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722331; c=relaxed/simple;
	bh=9ijYxLmeoiTSQis7Gn2lwx26xHvpvRAq7wK315SS+z0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fhx3qvAH6qj6QtHHNQZyCfIhZOWSku0lubNdX8abgWTHJwB15NQR9HzoV4IVo8xtO9TSHIpirbqU+y9NX/JPkK8DoIYi0tnvEhf9XlCqa9uDp9VHbhTAPJohuReXPSkIr97VqWsIuBe6WEkBSOhH2nEDCqeqlorCf9/Bh3QBl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyPyPjpf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJ0V72q3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 21:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769722329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+0sV8Hr0Et7BGm5D75fToq2y+APE2Krnyyj5QfZPqU=;
	b=kyPyPjpfXvZT3OPE+KmwjMGbdWsRWrZe4QQnpTbQVQ05NXFo1u6exoRzosV5xvMe5GVR/F
	h5q9+x9RbIwrrWu0AChrOV4nd7gNPIhLD/Ntq5a1Zoo6gqVLsZby1tvAw2bX6pkI/Zxl75
	UwUDWbJOJJbzYm6ulr7kuf0xgB7tR278UGFDu4XDtaJUGGak4T+DEOqBi45fIWcJsSfGBE
	xw7d+R/oxtMQo+aFyG2HXblbyy1jwbSGY4JHfY8JRjNhS9fLKc4ChaVFV17/T+YJSyfuT9
	Adzwke3aLErzwCHPm0s/0aFengJMxvKaKwYr0C9w8MffxtweiIpIqdYjTJR+Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769722329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+0sV8Hr0Et7BGm5D75fToq2y+APE2Krnyyj5QfZPqU=;
	b=qJ0V72q3/zUn3Ra1CNR60ulVyFYdqXi80BRoEFdydpG6fLudvdprfPebLgFOP+3LDfBxJ0
	QlmX2ibyLvzKxhBA==
From: "tip-bot2 for Stephen Eta Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-sp804: Fix an
 Oops when read_current_timer is called on ARM32 platforms where the SP804 is
 not registered as the sched_clock.
Cc: kernel test robot <lkp@intel.com>,
 Stephen Eta Zhou <stephen.eta.zhou@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251225-fix_timersp804-v2-1-a366d7157f58@gmail.com>
References: <20251225-fix_timersp804-v2-1-a366d7157f58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972232776.2495410.5417786508106401348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8139-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linaro.org:email,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,linaro.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 2003CB4C35
X-Rspamd-Action: no action

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     694921a93f3e3621e067afc545cedf6fe3b234a9
Gitweb:        https://git.kernel.org/tip/694921a93f3e3621e067afc545cedf6fe3b=
234a9
Author:        Stephen Eta Zhou <stephen.eta.zhou@gmail.com>
AuthorDate:    Thu, 25 Dec 2025 16:16:31 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Jan 2026 18:06:54 +01:00

clocksource/drivers/timer-sp804: Fix an Oops when read_current_timer is calle=
d on ARM32 platforms where the SP804 is not registered as the sched_clock.

On SP804, the delay timer shares the same clkevt instance with
sched_clock. On some platforms, when
sp804_clocksource_and_sched_clock_init is called with use_sched_clock
not set to 1, sched_clkevt is not properly initialized. However,
sp804_register_delay_timer is invoked unconditionally, and
read_current_timer() subsequently calls sp804_read on an uninitialized
sched_clkevt, leading to a kernel Oops when accessing
sched_clkevt->value.

Declare a dedicated clkevt instance exclusively for delay timer,
instead of sharing the same clkevt with sched_clock.  This ensures
that read_current_timer continues to work correctly regardless of
whether SP804 is selected as the sched_clock.

Fixes: 640594a04f11 ("clocksource/drivers/timer-sp804: Fix read_current_timer=
() issue when clock source is not registered")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512250520.APOMkYRQ-lkp@intel=
.com/
Signed-off-by: Stephen Eta Zhou <stephen.eta.zhou@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251225-fix_timersp804-v2-1-a366d7157f58@gmai=
l.com
---
 drivers/clocksource/timer-sp804.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp=
804.c
index e82a95e..d698584 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -106,21 +106,25 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clkevt->value);
 }
=20
+/* Register delay timer backed by the hardware counter */
 #ifdef CONFIG_ARM
 static struct delay_timer delay;
+static struct sp804_clkevt *delay_clkevt;
+
 static unsigned long sp804_read_delay_timer_read(void)
 {
-	return sp804_read();
+	return ~readl_relaxed(delay_clkevt->value);
 }
=20
-static void sp804_register_delay_timer(int freq)
+static void sp804_register_delay_timer(struct sp804_clkevt *clk, int freq)
 {
+	delay_clkevt =3D clk;
 	delay.freq =3D freq;
 	delay.read_current_timer =3D sp804_read_delay_timer_read;
 	register_current_timer_delay(&delay);
 }
 #else
-static inline void sp804_register_delay_timer(int freq) {}
+static inline void sp804_register_delay_timer(struct sp804_clkevt *clk, int =
freq) {}
 #endif
=20
 static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
@@ -135,8 +139,6 @@ static int __init sp804_clocksource_and_sched_clock_init(=
void __iomem *base,
 	if (rate < 0)
 		return -EINVAL;
=20
-	sp804_register_delay_timer(rate);
-
 	clkevt =3D sp804_clkevt_get(base);
=20
 	writel(0, clkevt->ctrl);
@@ -152,6 +154,8 @@ static int __init sp804_clocksource_and_sched_clock_init(=
void __iomem *base,
 	clocksource_mmio_init(clkevt->value, name,
 		rate, 200, 32, clocksource_mmio_readl_down);
=20
+	sp804_register_delay_timer(clkevt, rate);
+
 	if (use_sched_clock) {
 		sched_clkevt =3D clkevt;
 		sched_clock_register(sp804_read, 32, rate);

