Return-Path: <linux-tip-commits+bounces-6733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395DBBA18F8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1201C24C01
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D55321F24;
	Thu, 25 Sep 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yy71tAWY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sziv3N61"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33A321F35;
	Thu, 25 Sep 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835992; cv=none; b=HCWy9fEDxSQWLhf/LYsw1eDsYktFaufX8PrOKJuMvEZ/vY2gdOkfJBfVclflIle9w2oZ4Ygmf8OOwxamKp0TYbK+HoMUS5VsrqDl5fKZYVeOEcoWD6NcWoJBzTGpLoZgmkpnB4beAAGF8qvDjgaVY0G7fkhThQun6RRFiAPcuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835992; c=relaxed/simple;
	bh=MLrhm/HNbbrKDO6dJYqaQboWMGRjE2WO8OE4fV6xeQE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tFGvduVPo96aEgYI5UKf4gpcTNfx4dSDxeW+qYsWgFUeAcKd/uztL5mXVYcJ12J5uHZKSDMALfK+mAA2kDcghcgqJg1dqlKxVImwJK5oCwxmpqSo7zMcZSfkYLNTcXo/9sR9DSXgxeJU+Xtc58hy4UMtSH84C3UvngvrNhsu75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yy71tAWY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sziv3N61; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GrLNUHpFiHPDn4bftOFAyiLxZiayM8aFBi4zAxM6OAQ=;
	b=Yy71tAWYRD77uxAIs8rmF5nYUb73npTr9ptacGC68dHv6h1wS/zquIuqBp4YWq6s2h8CDa
	dVv8pnqg4X38pfy0xQ+EfXBe1Bq5eTi7VHxbc7ENIxwbyV34bA0nLE2JWT+2v8Bb+yeoRA
	MMEORaUhTXEyArBVlLZY4b66sGMIjQpftDASKbfqHN0AfTyja5UZWpwl6Dyi5JDCajIYwi
	A6oYbe7jgMiVeufGjAgXmJrkwbPhUiW3/gRrb7iFy/WjOyt2jA48oGagO1Larj20AEDyPY
	3H4o9H9gM+CHIS9Og6P/IFic6+0WAehp3ao/42j+U1TkYu2XiK3ewwfxXuGZKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GrLNUHpFiHPDn4bftOFAyiLxZiayM8aFBi4zAxM6OAQ=;
	b=sziv3N61Xq6jDir85xoOfqFQoJloeV5yTON1eHNfAhK2OCGaksjUNvyWPzDkDGX5bxrwV4
	xk1h8Rd7DDMGQPDg==
From: "tip-bot2 for Gokul Praveen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-ti-dm : Capture
 functionality for OMAP DM timer
Cc: Gokul Praveen <g-praveen@ti.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597863.709179.2623058663919361391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     0494fc345b377d1207c2cbfef67dc51f6ec874c0
Gitweb:        https://git.kernel.org/tip/0494fc345b377d1207c2cbfef67dc51f6ec=
874c0
Author:        Gokul Praveen <g-praveen@ti.com>
AuthorDate:    Tue, 12 Aug 2025 16:23:46 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:32:40 +02:00

clocksource/drivers/timer-ti-dm : Capture functionality for OMAP DM timer

Add PWM capture function in DM timer driver.

OMAP DM timer hardware supports capture feature.It can be used to
timestamp events (falling/rising edges) detected on input signal.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://lore.kernel.org/r/20250812105346.203541-1-g-praveen@ti.com
---
 drivers/clocksource/timer-ti-dm.c          | 119 +++++++++++++++++++-
 include/linux/platform_data/dmtimer-omap.h |   4 +-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index e9e32df..793e7cd 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/dmtimer-omap.h>
=20
 #include <clocksource/timer-ti-dm.h>
+#include <linux/delay.h>
=20
 /*
  * timer errata flags
@@ -836,6 +837,48 @@ static int omap_dm_timer_set_match(struct omap_dm_timer =
*cookie, int enable,
 	return 0;
 }
=20
+static int omap_dm_timer_set_cap(struct omap_dm_timer *cookie,
+					int autoreload, bool config_period)
+{
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
+	u32 l;
+
+	timer =3D to_dmtimer(cookie);
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+	/*
+	 *  1. Select autoreload mode. TIMER_TCLR[1] AR bit.
+	 *  2. TIMER_TCLR[14]: Sets the functionality of the TIMER IO pin.
+	 *  3. TIMER_TCLR[13] : Capture mode select bit.
+	 *  3. TIMER_TCLR[9-8] : Select transition capture mode.
+	 */
+
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+
+	if (autoreload)
+		l |=3D OMAP_TIMER_CTRL_AR;
+
+	l |=3D OMAP_TIMER_CTRL_CAPTMODE | OMAP_TIMER_CTRL_GPOCFG;
+
+	if (config_period =3D=3D true)
+		l |=3D OMAP_TIMER_CTRL_TCM_LOWTOHIGH; /* Time Period config */
+	else
+		l |=3D OMAP_TIMER_CTRL_TCM_BOTHEDGES; /* Duty Cycle config */
+
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
@@ -1023,23 +1066,92 @@ static unsigned int omap_dm_timer_read_counter(struct=
 omap_dm_timer *cookie)
 	return __omap_dm_timer_read_counter(timer);
 }
=20
+static inline unsigned int __omap_dm_timer_cap(struct dmtimer *timer, int id=
x)
+{
+	return idx =3D=3D 0 ? dmtimer_read(timer, OMAP_TIMER_CAPTURE_REG) :
+			  dmtimer_read(timer, OMAP_TIMER_CAPTURE2_REG);
+}
+
 static int omap_dm_timer_write_counter(struct omap_dm_timer *cookie, unsigne=
d int value)
 {
 	struct dmtimer *timer;
+	struct device *dev;
=20
 	timer =3D to_dmtimer(cookie);
-	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
+	if (unlikely(!timer)) {
+		pr_err("%s: timer not available.\n", __func__);
 		return -EINVAL;
 	}
=20
+	dev =3D &timer->pdev->dev;
+
+	pm_runtime_resume_and_get(dev);
 	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, value);
+	pm_runtime_put_sync(dev);
=20
 	/* Save the context */
 	timer->context.tcrr =3D value;
 	return 0;
 }
=20
+/**
+ * omap_dm_timer_cap_counter() - Calculate the high count or period count de=
pending on the
+ * configuration.
+ * @cookie:Pointer to OMAP DM timer
+ * @is_period:Whether to configure timer in period or duty cycle mode
+ *
+ * Return high count or period count if timer is enabled else appropriate er=
ror.
+ */
+static unsigned int omap_dm_timer_cap_counter(struct omap_dm_timer *cookie,	=
bool is_period)
+{
+	struct dmtimer *timer;
+	unsigned int cap1 =3D 0;
+	unsigned int cap2 =3D 0;
+	u32 l, ret;
+
+	timer =3D to_dmtimer(cookie);
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
+		pr_err("%s:timer is not available or enabled.%p\n", __func__, (void *)time=
r);
+		return -EINVAL;
+	}
+
+	/* Stop the timer */
+	omap_dm_timer_stop(cookie);
+
+	/* Clear the timer counter value to 0 */
+	ret =3D omap_dm_timer_write_counter(cookie, 0);
+	if (ret)
+		return ret;
+
+	/* Sets the timer capture configuration for period/duty cycle calculation */
+	ret =3D omap_dm_timer_set_cap(cookie, true, is_period);
+	if (ret) {
+		pr_err("%s: Failed to set timer capture configuration.\n", __func__);
+		return ret;
+	}
+	/* Start the timer */
+	omap_dm_timer_start(cookie);
+
+	/*
+	 * 1 sec delay is given so as to provide
+	 * enough time to capture low frequency signals.
+	 */
+	msleep(1000);
+
+	cap1 =3D __omap_dm_timer_cap(timer, 0);
+	cap2 =3D __omap_dm_timer_cap(timer, 1);
+
+	/*
+	 *  Clears the TCLR configuration.
+	 *  The start bit must be set to 1 as the timer is already in start mode.
+	 */
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l &=3D ~(0xffff) | 0x1;
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	return (cap2-cap1);
+}
+
 static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 {
 	struct dmtimer *timer =3D dev_get_drvdata(dev);
@@ -1246,6 +1358,9 @@ static const struct omap_dm_timer_ops dmtimer_ops =3D {
 	.write_counter =3D omap_dm_timer_write_counter,
 	.read_status =3D omap_dm_timer_read_status,
 	.write_status =3D omap_dm_timer_write_status,
+	.set_cap =3D omap_dm_timer_set_cap,
+	.get_cap_status =3D omap_dm_timer_get_pwm_status,
+	.read_cap =3D omap_dm_timer_cap_counter,
 };
=20
 static const struct dmtimer_platform_data omap3plus_pdata =3D {
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platf=
orm_data/dmtimer-omap.h
index 95d852a..726d891 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -36,9 +36,13 @@ struct omap_dm_timer_ops {
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger, int autoreload);
 	int	(*get_pwm_status)(struct omap_dm_timer *timer);
+	int	(*set_cap)(struct omap_dm_timer *timer,
+			   int autoreload, bool config_period);
+	int	(*get_cap_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
=20
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);
+	unsigned int (*read_cap)(struct omap_dm_timer *timer, bool is_period);
 	int	(*write_counter)(struct omap_dm_timer *timer,
 				 unsigned int value);
 	unsigned int (*read_status)(struct omap_dm_timer *timer);

