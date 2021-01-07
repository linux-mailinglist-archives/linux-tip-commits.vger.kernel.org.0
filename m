Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DE2ECBC3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Jan 2021 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbhAGIdJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 7 Jan 2021 03:33:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbhAGIdJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 7 Jan 2021 03:33:09 -0500
Date:   Thu, 07 Jan 2021 08:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610008346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzvJi7F2EteM6rhRpf2w3zsOevfIbpep1onnVi0E3yc=;
        b=pBCaS9n/JueNwJyceHdqAli1khlesfA5DhXrpAvnOtYXLTevX26N1TtPaHVvb2yYIX8ZvG
        HA43qkpXzXU7B/Po3WzCkVzRTbvvWKHnWuCGbMm3VWsqwnhLOMXD92LDh03JTL3XB3STuR
        QrvfAFeD3P4Z1/aVDJDILOr1lieRhWqkizubHQa2vojbnPMLRo+bbvzWrPJsb2+tQrpsoD
        AMp0P3QbCRF1CF8ktuu65u9UF4gahIbqqrv0/OCEiUpblTeyG1Gg6BkwUiRlSgHOnuokJM
        S/BHQHUWYSuMYhhLIQOElrErWGkPJe4ATF8YYEN3FeRtBeEIz/D9SBR+Fa0/CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610008346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzvJi7F2EteM6rhRpf2w3zsOevfIbpep1onnVi0E3yc=;
        b=hO+1cGeyfR6iwp+u342smsztj5tfiM+abN5/QxbWia79bSnxF2SWAT5rhMZ/boYHq0vjP0
        LLX6o8F71qq3CdDg==
From:   "tip-bot2 for Roman Kiryanov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform: Retire arch/x86/platform/goldfish
Cc:     Roman Kiryanov <rkir@google.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201117025522.1874864-1-rkir@google.com>
References: <20201117025522.1874864-1-rkir@google.com>
MIME-Version: 1.0
Message-ID: <161000834585.414.17890422566889835723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     2b29eed3f201b49feb92fdd0178b10825a5528f4
Gitweb:        https://git.kernel.org/tip/2b29eed3f201b49feb92fdd0178b10825a5528f4
Author:        Roman Kiryanov <rkir@google.com>
AuthorDate:    Mon, 16 Nov 2020 18:55:22 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Jan 2021 09:22:31 +01:00

x86/platform: Retire arch/x86/platform/goldfish

The Android Studio Emulator (aka goldfish) does not use
arch/x86/platform/goldfish since 5.4 kernel.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201117025522.1874864-1-rkir@google.com
---
 arch/x86/platform/Makefile            |  1 +-
 arch/x86/platform/goldfish/Makefile   |  2 +-
 arch/x86/platform/goldfish/goldfish.c | 54 +--------------------------
 3 files changed, 57 deletions(-)
 delete mode 100644 arch/x86/platform/goldfish/Makefile
 delete mode 100644 arch/x86/platform/goldfish/goldfish.c

diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
index d0e8354..b2f90a1 100644
--- a/arch/x86/platform/Makefile
+++ b/arch/x86/platform/Makefile
@@ -4,7 +4,6 @@ obj-y	+= atom/
 obj-y	+= ce4100/
 obj-y	+= efi/
 obj-y	+= geode/
-obj-y	+= goldfish/
 obj-y	+= iris/
 obj-y	+= intel/
 obj-y	+= intel-mid/
diff --git a/arch/x86/platform/goldfish/Makefile b/arch/x86/platform/goldfish/Makefile
deleted file mode 100644
index 072c395..0000000
--- a/arch/x86/platform/goldfish/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_GOLDFISH)	+= goldfish.o
diff --git a/arch/x86/platform/goldfish/goldfish.c b/arch/x86/platform/goldfish/goldfish.c
deleted file mode 100644
index 6b6f8b4..0000000
--- a/arch/x86/platform/goldfish/goldfish.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2007 Google, Inc.
- * Copyright (C) 2011 Intel, Inc.
- * Copyright (C) 2013 Intel, Inc.
- */
-
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-
-/*
- * Where in virtual device memory the IO devices (timers, system controllers
- * and so on)
- */
-
-#define GOLDFISH_PDEV_BUS_BASE	(0xff001000)
-#define GOLDFISH_PDEV_BUS_END	(0xff7fffff)
-#define GOLDFISH_PDEV_BUS_IRQ	(4)
-
-#define GOLDFISH_TTY_BASE	(0x2000)
-
-static struct resource goldfish_pdev_bus_resources[] = {
-	{
-		.start  = GOLDFISH_PDEV_BUS_BASE,
-		.end    = GOLDFISH_PDEV_BUS_END,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.start	= GOLDFISH_PDEV_BUS_IRQ,
-		.end	= GOLDFISH_PDEV_BUS_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static bool goldfish_enable __initdata;
-
-static int __init goldfish_setup(char *str)
-{
-	goldfish_enable = true;
-	return 0;
-}
-__setup("goldfish", goldfish_setup);
-
-static int __init goldfish_init(void)
-{
-	if (!goldfish_enable)
-		return -ENODEV;
-
-	platform_device_register_simple("goldfish_pdev_bus", -1,
-					goldfish_pdev_bus_resources, 2);
-	return 0;
-}
-device_initcall(goldfish_init);
