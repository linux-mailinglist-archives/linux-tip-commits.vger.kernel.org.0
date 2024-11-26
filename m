Return-Path: <linux-tip-commits+bounces-2887-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA39D9DF0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 20:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB39B21BDF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECC1DE2AA;
	Tue, 26 Nov 2024 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y2mXsQ6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANhDph5O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AE18858E;
	Tue, 26 Nov 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648790; cv=none; b=dJgvVrIDaar0O1+kWYJ0CXCE76F5AEz4cjXap3U7Ze2AFBtGmcrH4brk1unbv71IH+xvEuHg6pW5OVMCp5dPptDdCmSHVvlsxNuZZx/oy+wecFC4mOVzXSi8OsiZnDUQAKFNkT0XfjO9txdv+ZC4XqFZ984GBWcY6bk127fpxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648790; c=relaxed/simple;
	bh=Bi199jctiM2exmO/SsyMikZ+Iwzu20xhIHBWn5X9604=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X5zq4dDwOl/CzDE7M/C4qrtZ1DJnJUlanFVzB+milq0Tu/gHWw1sgmYrQy3eBj42tKiXqQedZbvVY2Lzwk4oYIVgQhdUNuuQkz1TAmsOSyIc3etpLDOwf3oEs/neO6E/EixLFO6FlIUuuIZl9a8+xc4kjxCI2ttVga4ZB51JHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y2mXsQ6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANhDph5O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Nov 2024 19:19:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732648787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiiVOw6VUTuBXa3p1meDtG4n71kgXSDbg0KApYqx8oI=;
	b=Y2mXsQ6hyCLgXfad+xZVNx5tP0j0B/pU4uSBJxKZSeGr2j/vLRFDfkrJaZvJN+1GPGyDQW
	avGE/UkdkTpF2EUJR3ftQhnxkFTYBYA8anqjf7yyWFndJu0+hb5rg1isXzsa+nVZp7bAIc
	HQtYfBRr1NLsQo4FCZ8+VeoIjH0T8yA9LpqMpjcbDbdWo0me7GUNz4x4H+BLh0TX5SDcAj
	NAoegUP8vMl8U+xqr4Ev4cwBhSS2KYf33vS+UYdRQoVWlgeUQZjcIORBiwozp1+S67onFz
	G7b77wInNkKAAEexcUwGV9wCBUrymvV8CA1grxDxugvbDhqzlTK/9IfNzX1lAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732648787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiiVOw6VUTuBXa3p1meDtG4n71kgXSDbg0KApYqx8oI=;
	b=ANhDph5OPDXuPDdtRFSzxYS+7O1jOfFq48hmDGSroNEUzSToJOKhj+29lcPqlXKarVo7hD
	EU1SK+QMteL54uAw==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip: Switch back to struct platform_driver::remove()
Cc: u.kleine-koenig@baylibre.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241109173828.291172-2-u.kleine-koenig@baylibre.com>
References: <20241109173828.291172-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173264878636.412.16179759316815548729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     cc47268cb4841c84d54f0ac73858986bcd515eb4
Gitweb:        https://git.kernel.org/tip/cc47268cb4841c84d54f0ac73858986bcd5=
15eb4
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
AuthorDate:    Sat, 09 Nov 2024 18:38:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 26 Nov 2024 20:09:06 +01:00

irqchip: Switch back to struct platform_driver::remove()

After commit 0edb555a65d1 ("platform: Make platform_driver::remove() return
void") .remove() is (again) the right callback to implement for platform
drivers.

Convert all platform drivers below drivers/irqchip/ to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done by
just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241109173828.291172-2-u.kleine-koenig@bay=
libre.com
---
 drivers/irqchip/irq-imgpdc.c              | 2 +-
 drivers/irqchip/irq-imx-intmux.c          | 2 +-
 drivers/irqchip/irq-imx-irqsteer.c        | 2 +-
 drivers/irqchip/irq-keystone.c            | 2 +-
 drivers/irqchip/irq-ls-scfg-msi.c         | 2 +-
 drivers/irqchip/irq-madera.c              | 2 +-
 drivers/irqchip/irq-mvebu-pic.c           | 2 +-
 drivers/irqchip/irq-pruss-intc.c          | 2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c | 2 +-
 drivers/irqchip/irq-renesas-irqc.c        | 2 +-
 drivers/irqchip/irq-renesas-rza1.c        | 2 +-
 drivers/irqchip/irq-ts4800.c              | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index b42ed68..85f80ba 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -479,7 +479,7 @@ static struct platform_driver pdc_intc_driver =3D {
 		.of_match_table	=3D pdc_intc_match,
 	},
 	.probe		=3D pdc_intc_probe,
-	.remove_new	=3D pdc_intc_remove,
+	.remove		=3D pdc_intc_remove,
 };
=20
 static int __init pdc_intc_init(void)
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index 511adfa..787543d 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -361,6 +361,6 @@ static struct platform_driver imx_intmux_driver =3D {
 		.pm		=3D &imx_intmux_pm_ops,
 	},
 	.probe		=3D imx_intmux_probe,
-	.remove_new	=3D imx_intmux_remove,
+	.remove		=3D imx_intmux_remove,
 };
 builtin_platform_driver(imx_intmux_driver);
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index 75a0e98..b0e9788 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -328,6 +328,6 @@ static struct platform_driver imx_irqsteer_driver =3D {
 		.pm		=3D &imx_irqsteer_pm_ops,
 	},
 	.probe		=3D imx_irqsteer_probe,
-	.remove_new	=3D imx_irqsteer_remove,
+	.remove		=3D imx_irqsteer_remove,
 };
 builtin_platform_driver(imx_irqsteer_driver);
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 30f1979..808c781 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -211,7 +211,7 @@ MODULE_DEVICE_TABLE(of, keystone_irq_dt_ids);
=20
 static struct platform_driver keystone_irq_device_driver =3D {
 	.probe		=3D keystone_irq_probe,
-	.remove_new	=3D keystone_irq_remove,
+	.remove		=3D keystone_irq_remove,
 	.driver		=3D {
 		.name	=3D "keystone_irq",
 		.of_match_table	=3D of_match_ptr(keystone_irq_dt_ids),
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index 1aef5c4..c0e1aaf 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -418,7 +418,7 @@ static struct platform_driver ls_scfg_msi_driver =3D {
 		.of_match_table	=3D ls_scfg_msi_id,
 	},
 	.probe		=3D ls_scfg_msi_probe,
-	.remove_new	=3D ls_scfg_msi_remove,
+	.remove		=3D ls_scfg_msi_remove,
 };
=20
 module_platform_driver(ls_scfg_msi_driver);
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index acceb6e..b32982c 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -236,7 +236,7 @@ static void madera_irq_remove(struct platform_device *pde=
v)
=20
 static struct platform_driver madera_irq_driver =3D {
 	.probe		=3D madera_irq_probe,
-	.remove_new	=3D madera_irq_remove,
+	.remove		=3D madera_irq_remove,
 	.driver =3D {
 		.name	=3D "madera-irq",
 		.pm	=3D &madera_irq_pm_ops,
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 08b0cc8..bd1e06e 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -183,7 +183,7 @@ MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
=20
 static struct platform_driver mvebu_pic_driver =3D {
 	.probe		=3D mvebu_pic_probe,
-	.remove_new	=3D mvebu_pic_remove,
+	.remove		=3D mvebu_pic_remove,
 	.driver =3D {
 		.name		=3D "mvebu-pic",
 		.of_match_table	=3D mvebu_pic_of_match,
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-int=
c.c
index 060eb00..bee0198 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -648,7 +648,7 @@ static struct platform_driver pruss_intc_driver =3D {
 		.suppress_bind_attrs	=3D true,
 	},
 	.probe		=3D pruss_intc_probe,
-	.remove_new	=3D pruss_intc_remove,
+	.remove		=3D pruss_intc_remove,
 };
 module_platform_driver(pruss_intc_driver);
=20
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index 9ad3723..954419f 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -584,7 +584,7 @@ static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_=
suspend, NULL);
=20
 static struct platform_driver intc_irqpin_device_driver =3D {
 	.probe		=3D intc_irqpin_probe,
-	.remove_new	=3D intc_irqpin_remove,
+	.remove		=3D intc_irqpin_remove,
 	.driver		=3D {
 		.name		=3D "renesas_intc_irqpin",
 		.of_match_table	=3D intc_irqpin_dt_ids,
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas=
-irqc.c
index 76026e0..cbce8ff 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -247,7 +247,7 @@ MODULE_DEVICE_TABLE(of, irqc_dt_ids);
=20
 static struct platform_driver irqc_device_driver =3D {
 	.probe		=3D irqc_probe,
-	.remove_new	=3D irqc_remove,
+	.remove		=3D irqc_remove,
 	.driver		=3D {
 		.name		=3D "renesas_irqc",
 		.of_match_table	=3D irqc_dt_ids,
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index f05afe8..d4e6a68 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -259,7 +259,7 @@ MODULE_DEVICE_TABLE(of, rza1_irqc_dt_ids);
=20
 static struct platform_driver rza1_irqc_device_driver =3D {
 	.probe		=3D rza1_irqc_probe,
-	.remove_new	=3D rza1_irqc_remove,
+	.remove		=3D rza1_irqc_remove,
 	.driver		=3D {
 		.name		=3D "renesas_rza1_irqc",
 		.of_match_table	=3D rza1_irqc_dt_ids,
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index b5dddb3..cc219f2 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -154,7 +154,7 @@ MODULE_DEVICE_TABLE(of, ts4800_ic_of_match);
=20
 static struct platform_driver ts4800_ic_driver =3D {
 	.probe		=3D ts4800_ic_probe,
-	.remove_new	=3D ts4800_ic_remove,
+	.remove		=3D ts4800_ic_remove,
 	.driver =3D {
 		.name		=3D "ts4800-irqc",
 		.of_match_table	=3D ts4800_ic_of_match,

