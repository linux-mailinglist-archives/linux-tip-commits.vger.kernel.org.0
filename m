Return-Path: <linux-tip-commits+bounces-7547-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B3C8A652
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59147358518
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966DF3081BE;
	Wed, 26 Nov 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="42d+jpHi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TITVaXr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9A3064A1;
	Wed, 26 Nov 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168048; cv=none; b=UmJWe+77OfF7Pp7PUSdxkaTukBzhbiA7fO+d5/XHbmZD9+mDb2ENh+8H9Wpu5Lvevx5iDqbmdYWsxUvH4qAuc/O3sieO+ItTCwDgVkaiEQdUcVHAmyl8pGc4uqAtwW0ddIyBUsWSkWwBixmvTaWN8peJB+lGIIX71gnS7BnaPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168048; c=relaxed/simple;
	bh=6FeQnPwJNh2ORmCig5QPLqwhU8ZH8CrdWd4M02mCCQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EmAkEJfHjzbcFuMrWMnP1njA3XLv01PNbAJXwBiy/U8MDj40xFpqiPZ9aYGviddzoCvFwd6861HHHJZss54BJy2fHKx2EmbMaYMq72+ZFjRS3jNhf0nsOd+pVsR/dJwKnybJB3/FX0EQBC1ApVtU7PqlcgsLG6urp0raXxvyOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=42d+jpHi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TITVaXr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5xyeduKlcarbukILfSeT8pAzPZ6d/CYGfZ7zgUshLM=;
	b=42d+jpHiSdP79oSv5aF4J2cLukQkP9jKZeuTf+TcwsXLX3Y4LA9CKuZmC/8QzMnjUNruH5
	5YmUKU/8YDL+P9bbCieHsgBAA8QL/NwDfYnJqXTU7aKS5qMmekhc9ZUp1PzjhMtT+2W8OT
	LtXCFEt6X7UjdMutaFdbABpW1hC0fIp6khMQEXwyANDmUmTq5Y66As6tr36hP/6aEgK5oK
	7YgPwOwBkbDEBt7+KPVrSsIVAe7/0S6nC1l7oH0ouxCHcKvNhQoNgY5xHKhBy5RvS6lW8J
	6dmNA6bBmWtR2DRFQZNo4XKMITDwaCgpK6aXt4iAmdxZ8brz+yiCmk9See6pgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5xyeduKlcarbukILfSeT8pAzPZ6d/CYGfZ7zgUshLM=;
	b=8TITVaXrWzD8kkTXkA4/x0j6nkkaVEPRQ+hdSSfXkYHeIwqkkgTXnbmElxctfHI5VZoDp8
	OJMhs/KGQZtNSjDA==
From: tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sh_cmt: Always leave
 device running after probe
Cc: niklas.soderlund+renesas@ragnatech.se,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016182022.1837417-1-niklas.soderlund+renesas@ragnatech.se>
References: <20251016182022.1837417-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804340.498.4499320924270390397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     62524f285c11d6e6168ad31b586143755b27b2e5
Gitweb:        https://git.kernel.org/tip/62524f285c11d6e6168ad31b586143755b2=
7b2e5
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 16 Oct 2025 20:20:22 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:40 +01:00

clocksource/drivers/sh_cmt: Always leave device running after probe

The CMT device can be used as both a clocksource and a clockevent
provider. The driver tries to be smart and power itself on and off, as
well as enabling and disabling its clock when it's not in operation.
This behavior is slightly altered if the CMT is used as an early
platform device in which case the device is left powered on after probe,
but the clock is still enabled and disabled at runtime.

This has worked for a long time, but recent improvements in PREEMPT_RT
and PROVE_LOCKING have highlighted an issue. As the CMT registers itself
as a clockevent provider, clockevents_register_device(), it needs to use
raw spinlocks internally as this is the context of which the clockevent
framework interacts with the CMT driver. However in the context of
holding a raw spinlock the CMT driver can't really manage its power
state or clock with calls to pm_runtime_*() and clk_*() as these calls
end up in other platform drivers using regular spinlocks to control
power and clocks.

This mix of spinlock contexts trips a lockdep warning.

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    [ BUG: Invalid wait context ]
    6.17.0-rc3-arm64-renesas-03071-gb3c4f4122b28-dirty #21 Not tainted
    -----------------------------
    swapper/1/0 is trying to lock:
    ffff00000898d180 (&dev->power.lock){-...}-{3:3}, at: __pm_runtime_resume+=
0x38/0x88
    ccree e6601000.crypto: ARM CryptoCell 630P Driver: HW version 0xAF400001/=
0xDCC63000, Driver version 5.0
    other info that might help us debug this:
    ccree e6601000.crypto: ARM ccree device initialized
    context-{5:5}
    2 locks held by swapper/1/0:
     #0: ffff80008173c298 (tick_broadcast_lock){-...}-{2:2}, at: __tick_broad=
cast_oneshot_control+0xa4/0x3a8
     #1: ffff0000089a5858 (&ch->lock){....}-{2:2}
    usbcore: registered new interface driver usbhid
    , at: sh_cmt_start+0x30/0x364
    stack backtrace:
    CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc3-arm64-renesas=
-03071-gb3c4f4122b28-dirty #21 PREEMPT
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
    Call trace:
     show_stack+0x14/0x1c (C)
     dump_stack_lvl+0x6c/0x90
     dump_stack+0x14/0x1c
     __lock_acquire+0x904/0x1584
     lock_acquire+0x220/0x34c
     _raw_spin_lock_irqsave+0x58/0x80
     __pm_runtime_resume+0x38/0x88
     sh_cmt_start+0x54/0x364
     sh_cmt_clock_event_set_oneshot+0x64/0xb8
     clockevents_switch_state+0xfc/0x13c
     tick_broadcast_set_event+0x30/0xa4
     __tick_broadcast_oneshot_control+0x1e0/0x3a8
     tick_broadcast_oneshot_control+0x30/0x40
     cpuidle_enter_state+0x40c/0x680
     cpuidle_enter+0x30/0x40
     do_idle+0x1f4/0x26c
     cpu_startup_entry+0x34/0x40
     secondary_start_kernel+0x11c/0x13c
     __secondary_switched+0x74/0x78

For non-PREEMPT_RT builds this is not really an issue, but for
PREEMPT_RT builds where normal spinlocks can sleep this might be an
issue. Be cautious and always leave the power and clock running after
probe.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251016182022.1837417-1-niklas.soderlund+rene=
sas@ragnatech.se
---
 drivers/clocksource/sh_cmt.c | 36 ++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 385eb94..791b298 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -355,14 +355,6 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
=20
 	dev_pm_syscore_device(&ch->cmt->pdev->dev, true);
=20
-	/* enable clock */
-	ret =3D clk_enable(ch->cmt->clk);
-	if (ret) {
-		dev_err(&ch->cmt->pdev->dev, "ch%u: cannot enable clock\n",
-			ch->index);
-		goto err0;
-	}
-
 	/* make sure channel is disabled */
 	sh_cmt_start_stop_ch(ch, 0);
=20
@@ -384,19 +376,12 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 	if (ret || sh_cmt_read_cmcnt(ch)) {
 		dev_err(&ch->cmt->pdev->dev, "ch%u: cannot clear CMCNT\n",
 			ch->index);
-		ret =3D -ETIMEDOUT;
-		goto err1;
+		return -ETIMEDOUT;
 	}
=20
 	/* enable channel */
 	sh_cmt_start_stop_ch(ch, 1);
 	return 0;
- err1:
-	/* stop clock */
-	clk_disable(ch->cmt->clk);
-
- err0:
-	return ret;
 }
=20
 static void sh_cmt_disable(struct sh_cmt_channel *ch)
@@ -407,9 +392,6 @@ static void sh_cmt_disable(struct sh_cmt_channel *ch)
 	/* disable interrupts in CMT block */
 	sh_cmt_write_cmcsr(ch, 0);
=20
-	/* stop clock */
-	clk_disable(ch->cmt->clk);
-
 	dev_pm_syscore_device(&ch->cmt->pdev->dev, false);
 }
=20
@@ -583,8 +565,6 @@ static int sh_cmt_start_clocksource(struct sh_cmt_channel=
 *ch)
 	int ret =3D 0;
 	unsigned long flags;
=20
-	pm_runtime_get_sync(&ch->cmt->pdev->dev);
-
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
 	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
@@ -619,8 +599,6 @@ static void sh_cmt_stop_clocksource(struct sh_cmt_channel=
 *ch)
 		sh_cmt_disable(ch);
=20
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
-
-	pm_runtime_put(&ch->cmt->pdev->dev);
 }
=20
 static int sh_cmt_start_clockevent(struct sh_cmt_channel *ch)
@@ -630,10 +608,8 @@ static int sh_cmt_start_clockevent(struct sh_cmt_channel=
 *ch)
=20
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
-	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
-		pm_runtime_get_sync(&ch->cmt->pdev->dev);
+	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
 		ret =3D sh_cmt_enable(ch);
-	}
=20
 	if (ret)
 		goto out;
@@ -656,10 +632,8 @@ static void sh_cmt_stop_clockevent(struct sh_cmt_channel=
 *ch)
=20
 	ch->flags &=3D ~FLAG_CLOCKEVENT;
=20
-	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
+	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
 		sh_cmt_disable(ch);
-		pm_runtime_put(&ch->cmt->pdev->dev);
-	}
=20
 	/* adjust the timeout to maximum if only clocksource left */
 	if (ch->flags & FLAG_CLOCKSOURCE)
@@ -1134,8 +1108,6 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, stru=
ct platform_device *pdev)
 		mask &=3D ~(1 << hwidx);
 	}
=20
-	clk_disable(cmt->clk);
-
 	platform_set_drvdata(pdev, cmt);
=20
 	return 0;
@@ -1183,8 +1155,6 @@ static int sh_cmt_probe(struct platform_device *pdev)
  out:
 	if (cmt->has_clockevent || cmt->has_clocksource)
 		pm_runtime_irq_safe(&pdev->dev);
-	else
-		pm_runtime_idle(&pdev->dev);
=20
 	return 0;
 }

