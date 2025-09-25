Return-Path: <linux-tip-commits+bounces-6737-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A3BA190C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8163A2FA3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF704326D62;
	Thu, 25 Sep 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdIFlwK6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tWgButV9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE2322755;
	Thu, 25 Sep 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835999; cv=none; b=aOw/Jx76vYZIde3u+FrCtbPyFI+UTyeNPDu/1nZ2J0ipe3X1c0cKa/qTS6MvX9Swe8YYElqMGgaKfe4FPcP0CNHs8LYQUdIAfQ3BxLuQvXyLF3RoVMBGYNi1Mnsmg7lLWIJcVscKDO6t1jCpYg5Aq9v2lqJNkS76tccW7oSmAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835999; c=relaxed/simple;
	bh=C2QL3ncDBZp1Qg72t+ISOHEDFviViDj00hIZrh0mecw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TpFuof9wL36LUH9EaDcb7Gxwk6hSZ1fObhbw/ZNexbVzNoHG2wT8NPnxg37EPZWmGv9mEfxAbTDqBxBRXlGWWlKoNZBJkRBhUysKSiTJtaxtSX+8RjvyOtdzJDxqNtAn9FtlWjiGTdMswL/SvKS/rvTKXK7p3+NI9+sdBVnBZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JdIFlwK6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tWgButV9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xdZzIPdyvgjzPbXBt5lCO6QnaJ0rwxApDGntg2B6uNI=;
	b=JdIFlwK6eqZJk2C5bsco3KQT2fF4/8awI2zSUcrgcG9IG9B7P3JEhc/iYDtAx8J+oBVxJJ
	jS5saT8HNVfyjLWYBp1iGzB6I/kP0NnENKCito+3DtP+hryMLGO0FzM9ABgcfNiqLMTm2g
	jLmIrD8R7W1ChGBDAgkEw/yYOLNwTbnYp1Pb0wm6BW1E+vYF2MGeuW7gTzf584op4G5gcd
	H18VPeKNvPZ2uxzEPnufhzC3VMq5wrkMED167MOo/ElYvCbl1lgY+LIPC/eUDRMV/17P8B
	SYj9vqPXIcnAAbk69aasMKb37cgQk64M15zuGC2l/jsV23V4gdxinQqrGCR66A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xdZzIPdyvgjzPbXBt5lCO6QnaJ0rwxApDGntg2B6uNI=;
	b=tWgButV9w0mXldX2eRRqv84cIPB6W/daiyPqKvScbbd0FoMm8LAX6skAIiUh3qqvtW9tlg
	9y7Rd9vxP1zhqBAg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] ACPI: GTDT: Generate platform devices for
 MMIO timers
Cc: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599488.709179.318444978040211978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     5669d92f3efa449c3906cbf15e676768a8f4d502
Gitweb:        https://git.kernel.org/tip/5669d92f3efa449c3906cbf15e676768a8f=
4d502
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 16:46:19 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:30:25 +02:00

ACPI: GTDT: Generate platform devices for MMIO timers

In preparation for the MMIO timer support code becoming an actual
driver, mimic what is done for the SBSA watchdog and expose
a synthetic device for each MMIO timer block.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250807160243.1970533-2-maz@kernel.org
---
 drivers/acpi/arm64/gtdt.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 70f8290..fd995a1 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -388,11 +388,11 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtd=
t_watchdog *wd,
 	return 0;
 }
=20
-static int __init gtdt_sbsa_gwdt_init(void)
+static int __init gtdt_platform_timer_init(void)
 {
 	void *platform_timer;
 	struct acpi_table_header *table;
-	int ret, timer_count, gwdt_count =3D 0;
+	int ret, timer_count, gwdt_count =3D 0, mmio_timer_count =3D 0;
=20
 	if (acpi_disabled)
 		return 0;
@@ -414,20 +414,41 @@ static int __init gtdt_sbsa_gwdt_init(void)
 		goto out_put_gtdt;
=20
 	for_each_platform_timer(platform_timer) {
+		ret =3D 0;
+
 		if (is_non_secure_watchdog(platform_timer)) {
 			ret =3D gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
 			if (ret)
-				break;
+				continue;
 			gwdt_count++;
+		} else 	if (is_timer_block(platform_timer)) {
+			struct arch_timer_mem atm =3D {};
+			struct platform_device *pdev;
+
+			ret =3D gtdt_parse_timer_block(platform_timer, &atm);
+			if (ret)
+				continue;
+
+			pdev =3D platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
+							     gwdt_count, &atm,
+							     sizeof(atm));
+			if (IS_ERR(pdev)) {
+				pr_err("Can't register timer %d\n", gwdt_count);
+				continue;
+			}
+
+			mmio_timer_count++;
 		}
 	}
=20
 	if (gwdt_count)
 		pr_info("found %d SBSA generic Watchdog(s).\n", gwdt_count);
+	if (mmio_timer_count)
+		pr_info("found %d Generic MMIO timer(s).\n", mmio_timer_count);
=20
 out_put_gtdt:
 	acpi_put_table(table);
 	return ret;
 }
=20
-device_initcall(gtdt_sbsa_gwdt_init);
+device_initcall(gtdt_platform_timer_init);

