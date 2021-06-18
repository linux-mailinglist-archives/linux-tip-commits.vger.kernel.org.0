Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208433ACFAD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhFRQFw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhFRQFu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:50 -0400
Date:   Fri, 18 Jun 2021 16:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkLqHqRbisOTijuKbZJuSCTnQUGrENRO7n2FQmX32kU=;
        b=PxyHhfc/0/+welrKEYfYy7xtp+Puvi9YVEwwX7axP2BcfMI362OadZfo8gC2OkZvv5K9bg
        S96uHlcnM9KXrFT3sGPeG21wHhG3UkGmpXnWzXB5S19qvsYYC8RLCNsTSmQOgcWJHh/Bye
        dXJNEzPrGz81UMY6EHDOKpuyVR5vL1+NHpMXbqTCw/oO2ibI5foZhmmg+5uhLFQJPdQmYr
        /oEfERO2sBIXR+Aecc97TMed+AmDnW31/lMrUQJzKvwAKquA0SzqMYEUmry0cWhEFeO6gQ
        0jbQmZUd71gy4Jx0CBqkRDqIrrdK+cM4gLP0K+be5aIem1B1jvVoPzfby+vXFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkLqHqRbisOTijuKbZJuSCTnQUGrENRO7n2FQmX32kU=;
        b=FOmkl3l7FoZCmSxZ3kjqcszm2m/IccXgZQZC1GgtpZAsr9codz8npBQbM8kdYhzHtij6jE
        Fve6D5DfeXqGkzCw==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Rename unreasonable
 array names
Cc:     zhouyanjie@wanyeetech.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1622824306-30987-2-git-send-email-zhouyanjie@wanyeetech.com>
References: <1622824306-30987-2-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <162403221983.19906.5878066725123528836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     870a6e1539829356baf70b57c933d0b309cfac21
Gitweb:        https://git.kernel.org/tip/870a6e1539829356baf70b57c933d0b309c=
fac21
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Sat, 05 Jun 2021 00:31:45 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jun 2021 14:14:14 +02:00

clocksource/drivers/ingenic: Rename unreasonable array names

1.Rename the "ingenic_ost_clk_info[]" to "x1000_ost_clk_info[]" to
  facilitate the addition of OST support for X2000 SoC in a later
  commit

2.When the OST support for X2000 SoC is added, there will be two
  compatible strings, so renaming "ingenic_ost_of_match[]" to
  "ingenic_ost_of_matches[]" is more reasonable

3.Remove the unnecessary comma in "ingenic_ost_of_matches[]" to reduce
  code size as much as possible.

Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1622824306-30987-2-git-send-email-zhouyanjie@=
wanyeetech.com
---
 drivers/clocksource/ingenic-sysost.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingen=
ic-sysost.c
index e77d584..a129840 100644
--- a/drivers/clocksource/ingenic-sysost.c
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -186,7 +186,7 @@ static const struct clk_ops ingenic_ost_global_timer_ops =
=3D {
=20
 static const char * const ingenic_ost_clk_parents[] =3D { "ext" };
=20
-static const struct ingenic_ost_clk_info ingenic_ost_clk_info[] =3D {
+static const struct ingenic_ost_clk_info x1000_ost_clk_info[] =3D {
 	[OST_CLK_PERCPU_TIMER] =3D {
 		.init_data =3D {
 			.name =3D "percpu timer",
@@ -414,14 +414,14 @@ static const struct ingenic_soc_info x1000_soc_info =3D=
 {
 	.num_channels =3D 2,
 };
=20
-static const struct of_device_id __maybe_unused ingenic_ost_of_match[] __ini=
tconst =3D {
-	{ .compatible =3D "ingenic,x1000-ost", .data =3D &x1000_soc_info, },
+static const struct of_device_id __maybe_unused ingenic_ost_of_matches[] __i=
nitconst =3D {
+	{ .compatible =3D "ingenic,x1000-ost", .data =3D &x1000_soc_info },
 	{ /* sentinel */ }
 };
=20
 static int __init ingenic_ost_probe(struct device_node *np)
 {
-	const struct of_device_id *id =3D of_match_node(ingenic_ost_of_match, np);
+	const struct of_device_id *id =3D of_match_node(ingenic_ost_of_matches, np);
 	struct ingenic_ost *ost;
 	unsigned int i;
 	int ret;
@@ -462,7 +462,7 @@ static int __init ingenic_ost_probe(struct device_node *n=
p)
 	ost->clocks->num =3D ost->soc_info->num_channels;
=20
 	for (i =3D 0; i < ost->clocks->num; i++) {
-		ret =3D ingenic_ost_register_clock(ost, i, &ingenic_ost_clk_info[i], ost->=
clocks);
+		ret =3D ingenic_ost_register_clock(ost, i, &x1000_ost_clk_info[i], ost->cl=
ocks);
 		if (ret) {
 			pr_crit("%s: Cannot register clock %d\n", __func__, i);
 			goto err_unregister_ost_clocks;
