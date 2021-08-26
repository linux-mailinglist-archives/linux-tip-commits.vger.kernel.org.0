Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B441E3F8C1C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhHZQ0W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbhHZQ0H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E28C061757;
        Thu, 26 Aug 2021 09:25:19 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:25:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7DzhjvT6Rl6jgJnHlkwtf/rs3jI/uo4EVhmZyAj3o4=;
        b=yY8ob0FEwUnZc/tkK+e3JehTBIqd5224hfOi/XzZVu3fdcDWv/Kz4ZgcQ10LUgI0ASWnia
        oC3u9mctXh+3hIOOQcCUX5qvZDOkXKbscDUuZBHO+IlcqnFZanmE9QlV1/1J9Rm+iZMP6t
        2ZwPqgnogCUphmu1tmlXUytasB20RrtwA/ZFSnwX9rJqFKzBKwLqZd9k72ps0Vqyi6O9iw
        h9bCl6mf+Z/TaDO8otB1N6aicebIOp7GL8wezI0CmtgNF2omWoADH4jnTh0jBdRm8j4jwr
        s5QaXJpvAQCaKsgqZ66VqK1rLVTWdMZ6RUNFe+VHe8FySUZjJI498Hu8hveMbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7DzhjvT6Rl6jgJnHlkwtf/rs3jI/uo4EVhmZyAj3o4=;
        b=tnjXYOy3pjfDNrNQ/4IjvozcDLzPS9q2Oz3qe38IFskiH9S7ue3jFq5ZHAbr3JWnDiH9nE
        qRIl2/ezbge0xwDA==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Use bitfield macro helpers
Cc:     zhouyanjie@wanyeetech.com, Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1627638188-116163-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1627638188-116163-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <162999511697.25758.16027378854390463391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3b87265d825a2d29eb6b67511f0e7ed62225cd97
Gitweb:        https://git.kernel.org/tip/3b87265d825a2d29eb6b67511f0e7ed6222=
5cd97
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Fri, 30 Jul 2021 17:43:08 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 02:44:35 +02:00

clocksource/drivers/ingenic: Use bitfield macro helpers

Use "FIELD_GET()" and "FIELD_PREP()" to simplify the code.

[dlezcano] : Changed title

Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1627638188-116163-1-git-send-email-zhouyanjie=
@wanyeetech.com
---
 drivers/clocksource/ingenic-sysost.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingen=
ic-sysost.c
index a129840..cb6fc2f 100644
--- a/drivers/clocksource/ingenic-sysost.c
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2020 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@=
wanyeetech.com>
  */
=20
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
@@ -34,8 +35,6 @@
 /* bits within the OSTCCR register */
 #define OSTCCR_PRESCALE1_MASK	0x3
 #define OSTCCR_PRESCALE2_MASK	0xc
-#define OSTCCR_PRESCALE1_LSB	0
-#define OSTCCR_PRESCALE2_LSB	2
=20
 /* bits within the OSTCR register */
 #define OSTCR_OST1CLR			BIT(0)
@@ -98,7 +97,7 @@ static unsigned long ingenic_ost_percpu_timer_recalc_rate(s=
truct clk_hw *hw,
=20
 	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
=20
-	prescale =3D (prescale & OSTCCR_PRESCALE1_MASK) >> OSTCCR_PRESCALE1_LSB;
+	prescale =3D FIELD_GET(OSTCCR_PRESCALE1_MASK, prescale);
=20
 	return parent_rate >> (prescale * 2);
 }
@@ -112,7 +111,7 @@ static unsigned long ingenic_ost_global_timer_recalc_rate=
(struct clk_hw *hw,
=20
 	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
=20
-	prescale =3D (prescale & OSTCCR_PRESCALE2_MASK) >> OSTCCR_PRESCALE2_LSB;
+	prescale =3D FIELD_GET(OSTCCR_PRESCALE2_MASK, prescale);
=20
 	return parent_rate >> (prescale * 2);
 }
@@ -151,7 +150,8 @@ static int ingenic_ost_percpu_timer_set_rate(struct clk_h=
w *hw, unsigned long re
 	int val;
=20
 	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
-	val =3D (val & ~OSTCCR_PRESCALE1_MASK) | (prescale << OSTCCR_PRESCALE1_LSB);
+	val &=3D ~OSTCCR_PRESCALE1_MASK;
+	val |=3D FIELD_PREP(OSTCCR_PRESCALE1_MASK, prescale);
 	writel(val, ost_clk->ost->base + info->ostccr_reg);
=20
 	return 0;
@@ -166,7 +166,8 @@ static int ingenic_ost_global_timer_set_rate(struct clk_h=
w *hw, unsigned long re
 	int val;
=20
 	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
-	val =3D (val & ~OSTCCR_PRESCALE2_MASK) | (prescale << OSTCCR_PRESCALE2_LSB);
+	val &=3D ~OSTCCR_PRESCALE2_MASK;
+	val |=3D FIELD_PREP(OSTCCR_PRESCALE2_MASK, prescale);
 	writel(val, ost_clk->ost->base + info->ostccr_reg);
=20
 	return 0;
