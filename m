Return-Path: <linux-tip-commits+bounces-6724-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E167BA18B5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A503189C806
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5D32142D;
	Thu, 25 Sep 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkjAGV3t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f49+2x8D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06122A7F1;
	Thu, 25 Sep 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835973; cv=none; b=FkoNy3dAW7XgRkh3aGiFi5+D2yI5cb6D2NubEx5JhKkLn26+CIjQixBlXrnFjrk9H5Fi/km3GkAsELV+aWYPwxT3EQTMJT8bO4942SYRwFxHqSsSkdtPp0KWdNMzg6bNdLz/sNhOJYZsgZ9hBiUnGDd9xHBSoRFt9V5OPwDehds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835973; c=relaxed/simple;
	bh=1uqzBLmTKunS/MLADcT5p8as/f1pGRYDjcg03RgBVi4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=E16Oc/JrZg/Ytkg2QWYWfbCf32Uu1Bofi5XHa9kcruG5XDJukH+eq0lPOMUV25+z71Viawm3c927w/DSrrqe2XGOCd5b5mF+jIXxS7+dplJoJpF+VyLgFtle+8nONZlNzaAPf8btyM353w4ewLBzfHpZAp3YMarfe0pcGvgOTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkjAGV3t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f49+2x8D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gZU/E/+QjSXW3ChKG31ntkEAnvSSIIgDpEm64EJuPc4=;
	b=LkjAGV3tk8x4P25aSht/+6nLsyD/BuhP35Nu/b249mLXveSNU1+0AlWj2aJ+pLrTwWFanw
	D2P2bw3XwCnlFB+1b2V/vIDzC8tmTq1TMYDZmyopiay4B1ZXK2auycI51dHBqI8gCIA0bi
	7JXpkkW5hm6WA9I3JaDJUXZSID2bUL+Qa3DlDcQ1+TOt2kN4RTN8Cg40fn2aUAzuzocCp2
	E5WQm5SQldBqWLOhQFPHRSR0cXt3XlIpaYTH5F7XVQA83HgC/BuqvZ7I4XfJVyV56sDf1e
	sxfX+Z7jJuSrhW8Puv/ha2HwHTEMsXNotCAqn1ob6VQEIwIWAROm/fB9UbKy4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gZU/E/+QjSXW3ChKG31ntkEAnvSSIIgDpEm64EJuPc4=;
	b=f49+2x8DBshOyAbJGBsVDwW8XXb5BXIo5u0O5lQXnlBZD9fRVGR7pptZWKT6C72XOYJbwG
	SkirmIeZY4EYDXCg==
From: tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sh_cmt: Split
 start/stop of clock source and events
Cc: niklas.soderlund+renesas@ragnatech.se,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883596800.709179.1627711099279971459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     0c617a3f62100ff25c291735ff907a7ca1c084ae
Gitweb:        https://git.kernel.org/tip/0c617a3f62100ff25c291735ff907a7ca1c=
084ae
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Wed, 10 Sep 2025 16:26:56 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:42:43 +02:00

clocksource/drivers/sh_cmt: Split start/stop of clock source and events

The CMT do a housekeeping such as dealing with runtime PM and
enable/disable clocks when either a clock source is enabled, or when a
new clock event is registered.

Doing this type of housekeeping for when a clock event is registered is
not always possible as it can happen in contexts where holding spinlocks
is not possible. However doing it when registering a clock source is
possible.

As a first step to address this design break apart the CMT start and
stop functions. The path for clock sources need not change, while the
one for clock events need to be reworked in future work.

There is no indented functional change, just breaking the two use-cases
controlled by a flag into two distinct functions.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250910142657.1148696-2-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/clocksource/sh_cmt.c | 84 ++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b72b36e..385eb94 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -578,37 +578,74 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_=
id)
 	return IRQ_HANDLED;
 }
=20
-static int sh_cmt_start(struct sh_cmt_channel *ch, unsigned long flag)
+static int sh_cmt_start_clocksource(struct sh_cmt_channel *ch)
 {
 	int ret =3D 0;
 	unsigned long flags;
=20
-	if (flag & FLAG_CLOCKSOURCE)
-		pm_runtime_get_sync(&ch->cmt->pdev->dev);
+	pm_runtime_get_sync(&ch->cmt->pdev->dev);
=20
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
-	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
-		if (flag & FLAG_CLOCKEVENT)
-			pm_runtime_get_sync(&ch->cmt->pdev->dev);
+	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
 		ret =3D sh_cmt_enable(ch);
-	}
=20
 	if (ret)
 		goto out;
-	ch->flags |=3D flag;
+
+	ch->flags |=3D FLAG_CLOCKSOURCE;
=20
 	/* setup timeout if no clockevent */
-	if (ch->cmt->num_channels =3D=3D 1 &&
-	    flag =3D=3D FLAG_CLOCKSOURCE && (!(ch->flags & FLAG_CLOCKEVENT)))
+	if (ch->cmt->num_channels =3D=3D 1 && !(ch->flags & FLAG_CLOCKEVENT))
 		__sh_cmt_set_next(ch, ch->max_match_value);
+out:
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+	return ret;
+}
+
+static void sh_cmt_stop_clocksource(struct sh_cmt_channel *ch)
+{
+	unsigned long flags;
+	unsigned long f;
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
+	f =3D ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
+
+	ch->flags &=3D ~FLAG_CLOCKSOURCE;
+
+	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
+		sh_cmt_disable(ch);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+	pm_runtime_put(&ch->cmt->pdev->dev);
+}
+
+static int sh_cmt_start_clockevent(struct sh_cmt_channel *ch)
+{
+	int ret =3D 0;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
+	if (!(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
+		pm_runtime_get_sync(&ch->cmt->pdev->dev);
+		ret =3D sh_cmt_enable(ch);
+	}
+
+	if (ret)
+		goto out;
+
+	ch->flags |=3D FLAG_CLOCKEVENT;
  out:
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
=20
 	return ret;
 }
=20
-static void sh_cmt_stop(struct sh_cmt_channel *ch, unsigned long flag)
+static void sh_cmt_stop_clockevent(struct sh_cmt_channel *ch)
 {
 	unsigned long flags;
 	unsigned long f;
@@ -616,22 +653,19 @@ static void sh_cmt_stop(struct sh_cmt_channel *ch, unsi=
gned long flag)
 	raw_spin_lock_irqsave(&ch->lock, flags);
=20
 	f =3D ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
-	ch->flags &=3D ~flag;
+
+	ch->flags &=3D ~FLAG_CLOCKEVENT;
=20
 	if (f && !(ch->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE))) {
 		sh_cmt_disable(ch);
-		if (flag & FLAG_CLOCKEVENT)
-			pm_runtime_put(&ch->cmt->pdev->dev);
+		pm_runtime_put(&ch->cmt->pdev->dev);
 	}
=20
 	/* adjust the timeout to maximum if only clocksource left */
-	if ((flag =3D=3D FLAG_CLOCKEVENT) && (ch->flags & FLAG_CLOCKSOURCE))
+	if (ch->flags & FLAG_CLOCKSOURCE)
 		__sh_cmt_set_next(ch, ch->max_match_value);
=20
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
-
-	if (flag & FLAG_CLOCKSOURCE)
-		pm_runtime_put(&ch->cmt->pdev->dev);
 }
=20
 static struct sh_cmt_channel *cs_to_sh_cmt(struct clocksource *cs)
@@ -672,7 +706,7 @@ static int sh_cmt_clocksource_enable(struct clocksource *=
cs)
=20
 	ch->total_cycles =3D 0;
=20
-	ret =3D sh_cmt_start(ch, FLAG_CLOCKSOURCE);
+	ret =3D sh_cmt_start_clocksource(ch);
 	if (!ret)
 		ch->cs_enabled =3D true;
=20
@@ -685,7 +719,7 @@ static void sh_cmt_clocksource_disable(struct clocksource=
 *cs)
=20
 	WARN_ON(!ch->cs_enabled);
=20
-	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
+	sh_cmt_stop_clocksource(ch);
 	ch->cs_enabled =3D false;
 }
=20
@@ -696,7 +730,7 @@ static void sh_cmt_clocksource_suspend(struct clocksource=
 *cs)
 	if (!ch->cs_enabled)
 		return;
=20
-	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
+	sh_cmt_stop_clocksource(ch);
 	dev_pm_genpd_suspend(&ch->cmt->pdev->dev);
 }
=20
@@ -708,7 +742,7 @@ static void sh_cmt_clocksource_resume(struct clocksource =
*cs)
 		return;
=20
 	dev_pm_genpd_resume(&ch->cmt->pdev->dev);
-	sh_cmt_start(ch, FLAG_CLOCKSOURCE);
+	sh_cmt_start_clocksource(ch);
 }
=20
 static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
@@ -740,7 +774,7 @@ static struct sh_cmt_channel *ced_to_sh_cmt(struct clock_=
event_device *ced)
=20
 static void sh_cmt_clock_event_start(struct sh_cmt_channel *ch, int periodic)
 {
-	sh_cmt_start(ch, FLAG_CLOCKEVENT);
+	sh_cmt_start_clockevent(ch);
=20
 	if (periodic)
 		sh_cmt_set_next(ch, ((ch->cmt->rate + HZ/2) / HZ) - 1);
@@ -752,7 +786,7 @@ static int sh_cmt_clock_event_shutdown(struct clock_event=
_device *ced)
 {
 	struct sh_cmt_channel *ch =3D ced_to_sh_cmt(ced);
=20
-	sh_cmt_stop(ch, FLAG_CLOCKEVENT);
+	sh_cmt_stop_clockevent(ch);
 	return 0;
 }
=20
@@ -763,7 +797,7 @@ static int sh_cmt_clock_event_set_state(struct clock_even=
t_device *ced,
=20
 	/* deal with old setting first */
 	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
-		sh_cmt_stop(ch, FLAG_CLOCKEVENT);
+		sh_cmt_stop_clockevent(ch);
=20
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used for %s clock events\n",
 		 ch->index, periodic ? "periodic" : "oneshot");

