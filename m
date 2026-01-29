Return-Path: <linux-tip-commits+bounces-8142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIIfDhDTe2nrIgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:37:20 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB998B4DE2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02C43046040
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106017BCA;
	Thu, 29 Jan 2026 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZL3H6nc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6YK/pxj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FD35CBA5;
	Thu, 29 Jan 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722335; cv=none; b=s1QOmMXHd+unso4TeQP5h0RkEtAsOVLevH6OmArLCtuZkbWb5SwAqA7YGAgmmf/62+gA/FF5/C7XRiZBy0/40fiDxQ1d4IAkZbdyDzEVhD2UAVBHc1AMh8GJ69hBGWiUIqE1FPsWmtZyvYwV6fBJlL0V0Xg6WB8h0vkjOXfSiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722335; c=relaxed/simple;
	bh=GifjuGnjfLuPwFpkyXZvZgRXHlLUPK0b87qmYKm2tGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LN+hc5s+CQ3y4WP2oqNlfiuaS/I8n+W8rtQYrcSKq4ckiemFI/1R+fWkalQwmbmArDKvVe426YHDwGRHmbNITQkrp07VmO7UYd5QTP3mNfsQsK5b2YAR9ccCo8QxH+gqkOh6KOVximJxda5+KF01tAA8JxgAGUW++fmbtfhHoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZL3H6nc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6YK/pxj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 21:32:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769722332;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFk0u0pz6lwk1olm64kgllS8Ky/2a3u5mNIDhg61Wlw=;
	b=OZL3H6ncQN/llwCaC3O8dzrGg6TmMcRyD+R9irVOVxWc2xpK7BYUvGTAolVszeXHtUMwUR
	qynL7VMqM6KqJMEzXMy8P/ej8LyVX+0zh7GdypM1IyPeI6qOO/aR2MJviSclCONrXrc9At
	EEpc1KNoxVm4TEiOL5aEHvuUkH25yIYIntKtV7znLBAaM/7HfpjmI44vu7Eiw4U2r0aPC8
	mDfFmfOdN/iyMt6zO6hJuijfEQrE3RdTkvMFtlxeR91lMqmIIuYSh7UCd3jviSCLWy8W8Q
	k/i0lm7Yrpw4nQHRMJA4hxjSm2MuhmNBjaUzM+l3mv4fGOaRbptQZjxBmQSSKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769722332;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFk0u0pz6lwk1olm64kgllS8Ky/2a3u5mNIDhg61Wlw=;
	b=C6YK/pxj3l4S0priJ+2SpVDyJXQVsRfmPwPBRrxE36VzHsGTcbdI33SHJS3UQHjFd34Ot8
	GHB73TqpI7hRmABQ==
From: tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sh_tmu: Always leave
 device running after probe
Cc: niklas.soderlund+renesas@ragnatech.se,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251202221341.1856773-1-niklas.soderlund+renesas@ragnatech.se>
References: <20251202221341.1856773-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972233116.2495410.2754825659328137464.tip-bot2@tip-bot2>
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
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8142-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,msgid.link:url,ragnatech.se:email,vger.kernel.org:replyto,linutronix.de:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: AB998B4DE2
X-Rspamd-Action: no action

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     b1278972b08e480990e2789bdc6a7c918bc349be
Gitweb:        https://git.kernel.org/tip/b1278972b08e480990e2789bdc6a7c918bc=
349be
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Tue, 02 Dec 2025 23:13:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Jan 2026 18:03:42 +01:00

clocksource/drivers/sh_tmu: Always leave device running after probe

The TMU device can be used as both a clocksource and a clockevent
provider. The driver tries to be smart and power itself on and off, as
well as enabling and disabling its clock when it's not in operation.
This behavior is slightly altered if the TMU is used as an early
platform device in which case the device is left powered on after probe,
but the clock is still enabled and disabled at runtime.

This has worked for a long time, but recent improvements in PREEMPT_RT
and PROVE_LOCKING have highlighted an issue. As the TMU registers itself
as a clockevent provider, clockevents_register_device(), it needs to use
raw spinlocks internally as this is the context of which the clockevent
framework interacts with the TMU driver. However in the context of
holding a raw spinlock the TMU driver can't really manage its power
state or clock with calls to pm_runtime_*() and clk_*() as these calls
end up in other platform drivers using regular spinlocks to control
power and clocks.

This mix of spinlock contexts trips a lockdep warning.

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    [ BUG: Invalid wait context ]
    6.18.0-arm64-renesas-09926-gee959e7c5e34 #1 Not tainted
    -----------------------------
    swapper/0/0 is trying to lock:
    ffff000008c9e180 (&dev->power.lock){-...}-{3:3}, at: __pm_runtime_resume+=
0x38/0x88
    other info that might help us debug this:
    context-{5:5}
    1 lock held by swapper/0/0:
    ccree e6601000.crypto: ARM CryptoCell 630P Driver: HW version 0xAF400001/=
0xDCC63000, Driver version 5.0
     #0: ffff8000817ec298
    ccree e6601000.crypto: ARM ccree device initialized
     (tick_broadcast_lock){-...}-{2:2}, at: __tick_broadcast_oneshot_control+=
0xa4/0x3a8
    stack backtrace:
    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-arm64-renesas-099=
26-gee959e7c5e34 #1 PREEMPT
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
    Call trace:
     show_stack+0x14/0x1c (C)
     dump_stack_lvl+0x6c/0x90
     dump_stack+0x14/0x1c
     __lock_acquire+0x904/0x1584
     lock_acquire+0x220/0x34c
     _raw_spin_lock_irqsave+0x58/0x80
     __pm_runtime_resume+0x38/0x88
     sh_tmu_clock_event_set_oneshot+0x84/0xd4
     clockevents_switch_state+0xfc/0x13c
     tick_broadcast_set_event+0x30/0xa4
     __tick_broadcast_oneshot_control+0x1e0/0x3a8
     tick_broadcast_oneshot_control+0x30/0x40
     cpuidle_enter_state+0x40c/0x680
     cpuidle_enter+0x30/0x40
     do_idle+0x1f4/0x280
     cpu_startup_entry+0x34/0x40
     kernel_init+0x0/0x130
     do_one_initcall+0x0/0x230
     __primary_switched+0x88/0x90

For non-PREEMPT_RT builds this is not really an issue, but for
PREEMPT_RT builds where normal spinlocks can sleep this might be an
issue. Be cautious and always leave the power and clock running after
probe.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251202221341.1856773-1-niklas.soderlund+rene=
sas@ragnatech.se
---
 drivers/clocksource/sh_tmu.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index beffff8..3fc6ed9 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -143,16 +143,6 @@ static void sh_tmu_start_stop_ch(struct sh_tmu_channel *=
ch, int start)
=20
 static int __sh_tmu_enable(struct sh_tmu_channel *ch)
 {
-	int ret;
-
-	/* enable clock */
-	ret =3D clk_enable(ch->tmu->clk);
-	if (ret) {
-		dev_err(&ch->tmu->pdev->dev, "ch%u: cannot enable clock\n",
-			ch->index);
-		return ret;
-	}
-
 	/* make sure channel is disabled */
 	sh_tmu_start_stop_ch(ch, 0);
=20
@@ -174,7 +164,6 @@ static int sh_tmu_enable(struct sh_tmu_channel *ch)
 	if (ch->enable_count++ > 0)
 		return 0;
=20
-	pm_runtime_get_sync(&ch->tmu->pdev->dev);
 	dev_pm_syscore_device(&ch->tmu->pdev->dev, true);
=20
 	return __sh_tmu_enable(ch);
@@ -187,9 +176,6 @@ static void __sh_tmu_disable(struct sh_tmu_channel *ch)
=20
 	/* disable interrupts in TMU block */
 	sh_tmu_write(ch, TCR, TCR_TPSC_CLK4);
-
-	/* stop clock */
-	clk_disable(ch->tmu->clk);
 }
=20
 static void sh_tmu_disable(struct sh_tmu_channel *ch)
@@ -203,7 +189,6 @@ static void sh_tmu_disable(struct sh_tmu_channel *ch)
 	__sh_tmu_disable(ch);
=20
 	dev_pm_syscore_device(&ch->tmu->pdev->dev, false);
-	pm_runtime_put(&ch->tmu->pdev->dev);
 }
=20
 static void sh_tmu_set_next(struct sh_tmu_channel *ch, unsigned long delta,
@@ -552,7 +537,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct=
 platform_device *pdev)
 		goto err_clk_unprepare;
=20
 	tmu->rate =3D clk_get_rate(tmu->clk) / 4;
-	clk_disable(tmu->clk);
=20
 	/* Map the memory resource. */
 	ret =3D sh_tmu_map_memory(tmu);
@@ -626,8 +610,6 @@ static int sh_tmu_probe(struct platform_device *pdev)
  out:
 	if (tmu->has_clockevent || tmu->has_clocksource)
 		pm_runtime_irq_safe(&pdev->dev);
-	else
-		pm_runtime_idle(&pdev->dev);
=20
 	return 0;
 }

