Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3833213C6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Feb 2021 11:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBVKI2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Feb 2021 05:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBVKGE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Feb 2021 05:06:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8BFC061797;
        Mon, 22 Feb 2021 02:05:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:04:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613988298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbzOgEj/ymW7COng4Sq9/R6tSs4nXZCrLET6YtmldxM=;
        b=n48jliwezEGL2pCgs/aP46CFw0osGBaEz3/lNQXo1koIpSzsWNbnO8edcrDWN6SMPvLgNF
        GfiFl2FTzkY/rQ5Gj3fUm3q5sNhWuTTxS60fQs8GnxNH5uYUfXvSkNHz5ka0O1XyNM69lk
        j71pL6AWv6EzBTPKmcJar+mWFuC1vJt77kYutK3jyVYC8R+pxi5rHSwo1r7q81L/yXl4HL
        6NT/uV5B6yIi7YS8jx3u/3bUp+J5/6mbyTaH88zEGM0ajlAmDYeaPaI8FZQzJ2KvoDIl3y
        W3cBvf1RgDmKiF4dAvub63KkKKfptwtjpo0c/9METxn9YxSCsVvJhBqnH6Oaiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613988298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbzOgEj/ymW7COng4Sq9/R6tSs4nXZCrLET6YtmldxM=;
        b=YqQwthm2OhfRnel4nvSLe8YamOA7QGoIaDz+YQtT7as7YoXBmmZF17wdIyqUe6eupXMexN
        hC2xkKuYZXGvCuAA==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/sh_cmt: Make sure channel
 clock supply is enabled
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201210194648.2901899-1-geert+renesas@glider.be>
References: <20201210194648.2901899-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <161398829814.20312.15829489414281374276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     2a97d55333e4299f32c98cca6dc5c4db1c5855fc
Gitweb:        https://git.kernel.org/tip/2a97d55333e4299f32c98cca6dc5c4db1c5=
855fc
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Thu, 10 Dec 2020 20:46:48 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jan 2021 16:20:37 +01:00

clocksource/drivers/sh_cmt: Make sure channel clock supply is enabled

The Renesas Compare Match Timer 0 and 1 (CMT0/1) variants have a
register to control the clock supply to the individual channels.
Currently the driver does not touch this register, and relies on the
documented initial value, which has the clock supply enabled for all
channels present.

However, when Linux starts on the APE6-EVM development board, only the
clock supply to the first CMT1 channel is enabled.  Hence the first
channel (used as a clockevent) works, while the second channel (used as
a clocksource) does not.  Note that the default system clocksource is
the Cortex-A15 architectured timer, and the user needs to manually
switch to the CMT1 clocksource to trigger the broken behavior.

Fix this by removing the fragile dependency on implicit reset and/or
boot loader state, and by enabling the clock supply explicitly for all
channels used instead.  This requires postponing the clk_disable() call,
else the timer's registers cannot be accessed in sh_cmt_setup_channel().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210194648.2901899-1-geert+renesas@glider=
.be
---
 drivers/clocksource/sh_cmt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index e258230..c98f885 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -235,6 +235,8 @@ static const struct sh_cmt_info sh_cmt_info[] =3D {
 #define CMCNT 1 /* channel register */
 #define CMCOR 2 /* channel register */
=20
+#define CMCLKE	0x1000	/* CLK Enable Register (R-Car Gen2) */
+
 static inline u32 sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 {
 	if (ch->iostart)
@@ -853,6 +855,7 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch=
, unsigned int index,
 				unsigned int hwidx, bool clockevent,
 				bool clocksource, struct sh_cmt_device *cmt)
 {
+	u32 value;
 	int ret;
=20
 	/* Skip unused channels. */
@@ -882,6 +885,11 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *c=
h, unsigned int index,
 		ch->iostart =3D cmt->mapbase + ch->hwidx * 0x100;
 		ch->ioctrl =3D ch->iostart + 0x10;
 		ch->timer_bit =3D 0;
+
+		/* Enable the clock supply to the channel */
+		value =3D ioread32(cmt->mapbase + CMCLKE);
+		value |=3D BIT(hwidx);
+		iowrite32(value, cmt->mapbase + CMCLKE);
 		break;
 	}
=20
@@ -1014,12 +1022,10 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, st=
ruct platform_device *pdev)
 	else
 		cmt->rate =3D clk_get_rate(cmt->clk) / 8;
=20
-	clk_disable(cmt->clk);
-
 	/* Map the memory resource(s). */
 	ret =3D sh_cmt_map_memory(cmt);
 	if (ret < 0)
-		goto err_clk_unprepare;
+		goto err_clk_disable;
=20
 	/* Allocate and setup the channels. */
 	cmt->num_channels =3D hweight8(cmt->hw_channels);
@@ -1047,6 +1053,8 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, stru=
ct platform_device *pdev)
 		mask &=3D ~(1 << hwidx);
 	}
=20
+	clk_disable(cmt->clk);
+
 	platform_set_drvdata(pdev, cmt);
=20
 	return 0;
@@ -1054,6 +1062,8 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, stru=
ct platform_device *pdev)
 err_unmap:
 	kfree(cmt->channels);
 	iounmap(cmt->mapbase);
+err_clk_disable:
+	clk_disable(cmt->clk);
 err_clk_unprepare:
 	clk_unprepare(cmt->clk);
 err_clk_put:
