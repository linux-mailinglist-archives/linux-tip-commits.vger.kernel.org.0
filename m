Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0638E22B68E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jul 2020 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGWTK1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Jul 2020 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGWTJk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1382C0619DC;
        Thu, 23 Jul 2020 12:09:40 -0700 (PDT)
Date:   Thu, 23 Jul 2020 19:09:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+nKSOIrfkErF+Y+zhgHRjQA/DXzOar1/zZiB2UybB0=;
        b=ZcY5GtozpTclmspBKu0f2IQ8pVeQxbBP+guSjy0tAJJh4CZ33YVMc01NgUzgTdNUSKbu5h
        xstwJa97j1ivvRaIiV2Ul26kw+heQzpOg9eRWfXRu2W4gCauVujxqyvL/ERuXaLDsxA59X
        ifYVIdGKZUCMmC2JAEyVhXEXsl/smPmdbnJjZTVKPtrwyY+Y1+sGBBuOYvhXyipDhAXRp5
        ITsbQmlKs39wwmvfDAonU5LUaBJR2U0Ln08JDJOBkI1orX+eNBmrGTydEomNqKlHN2ZIvs
        9o0svhb+5lOhRQx/Vy0tBmC81BVgA93yGEabKqpKHUTYEFanxZ2FAXGrybMTAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+nKSOIrfkErF+Y+zhgHRjQA/DXzOar1/zZiB2UybB0=;
        b=9dj1K5EySfhIQ05i/KtV+vTC037yJi7jYWFwSZhoi7WH8l5+lkBPe0nuxQtKRup5e+XJrk
        QIk+Sat1HFyTOuDw==
From:   "tip-bot2 for Alexander A. Klimov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers: Replace HTTP links with HTTPS ones
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708165856.15322-1-grandmaster@al2klimov.de>
References: <20200708165856.15322-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Message-ID: <159553137839.4006.9381655365973041428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dcf30fc0ca9e2df2f5f9daddd1a0ab8f1ccbc9e4
Gitweb:        https://git.kernel.org/tip/dcf30fc0ca9e2df2f5f9daddd1a0ab8f1ccbc9e4
Author:        Alexander A. Klimov <grandmaster@al2klimov.de>
AuthorDate:    Wed, 08 Jul 2020 18:58:56 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:57:43 +02:00

clocksource/drivers: Replace HTTP links with HTTPS ones

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200708165856.15322-1-grandmaster@al2klimov.de
---
 Documentation/devicetree/bindings/timer/ti,keystone-timer.txt | 2 +-
 drivers/clocksource/timer-ti-32k.c                            | 2 +-
 drivers/clocksource/timer-ti-dm.c                             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt b/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
index 5fbe361..d3905a5 100644
--- a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
+++ b/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
@@ -10,7 +10,7 @@ It is global timer is a free running up-counter and can generate interrupt
 when the counter reaches preset counter values.
 
 Documentation:
-http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
+https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
 
 Required properties:
 
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index ae12bbf..59b0be4 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -21,7 +21,7 @@
  * Roughly modelled after the OMAP1 MPU timer code.
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 60aff08..33eeabf 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -4,7 +4,7 @@
  *
  * OMAP Dual-Mode Timers
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  * Tarun Kanti DebBarma <tarun.kanti@ti.com>
  * Thara Gopinath <thara@ti.com>
  *
