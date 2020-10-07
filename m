Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5684128591B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgJGHMq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgJGHME (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC80C0613D4;
        Wed,  7 Oct 2020 00:12:03 -0700 (PDT)
Date:   Wed, 07 Oct 2020 07:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXBKwDORBnSpivPnl1Mrpdd83AE9tAl9lbmGfsXzByc=;
        b=ywKlcUo1g+xvtop54XvNKyPSZcr8z+dknO80sWTFt8wsHVoB/OKY7zStQuVcSBv45Qi8yM
        4yBEFurFIfz4zwa4IgR2KE14KaArvbJC04xo2ZNruzydysyyaJdW9VJTt92W05ZjH3kuCM
        w98COxlceZWPeyaio0WpeCOSFCxeKZ3C1jECiAcTkMWgkrOSFzxl9XxbLd/syeq7VbafGm
        vzWipd4mY7bN0iq+7z/UacMyRAaRXLnW1KpfhZgsZ/MpElULCebY/jPYtZbbISq2ZiASe0
        PGs19dDW2WaHOueoiuHDZ425iNsKuEHelY3SUsKAyuF1P4XcEvdKUeS1lOydJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXBKwDORBnSpivPnl1Mrpdd83AE9tAl9lbmGfsXzByc=;
        b=gdZy5oZ693m2kR4ZtOuI0F8T0SP97yhdrGmRhU4Bucl+lgNpUs+PwU0+E8xF1pfL4mzSjf
        +utSQZh6cSxY05AQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update for UV5 NMI MMR changes
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-13-mike.travis@hpe.com>
References: <20201005203929.148656-13-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472033.7002.14164903565017374344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     ae5f8ce3c247b8d937782e76802a9036c09998ad
Gitweb:        https://git.kernel.org/tip/ae5f8ce3c247b8d937782e76802a9036c09998ad
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:28 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:09:50 +02:00

x86/platform/uv: Update for UV5 NMI MMR changes

The UV NMI MMR addresses and fields moved between UV4 and UV5
necessitating a rewrite of the UV NMI handler.  Adjust references
to accommodate those changes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-13-mike.travis@hpe.com
---
 arch/x86/include/asm/uv/uv_hub.h | 13 +------
 arch/x86/platform/uv/uv_nmi.c    | 64 ++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 07079b5..610bda2 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -734,19 +734,6 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_NMI_MMR_SHIFT	63
 #define UVH_NMI_MMR_TYPE	"SCRATCH5"
 
-/* Newer SMM NMI handler, not present in all systems */
-#define UVH_NMI_MMRX		UVH_EVENT_OCCURRED0
-#define UVH_NMI_MMRX_CLEAR	UVH_EVENT_OCCURRED0_ALIAS
-#define UVH_NMI_MMRX_SHIFT	UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT
-#define UVH_NMI_MMRX_TYPE	"EXTIO_INT0"
-
-/* Non-zero indicates newer SMM NMI handler present */
-#define UVH_NMI_MMRX_SUPPORTED	UVH_EXTIO_INT0_BROADCAST
-
-/* Indicates to BIOS that we want to use the newer SMM NMI handler */
-#define UVH_NMI_MMRX_REQ	UVH_BIOS_KERNEL_MMR_ALIAS_2
-#define UVH_NMI_MMRX_REQ_SHIFT	62
-
 struct uv_hub_nmi_s {
 	raw_spinlock_t	nmi_lock;
 	atomic_t	in_nmi;		/* flag this node in UV NMI IRQ */
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 9d08ff5..eac26fe 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -2,8 +2,8 @@
 /*
  * SGI NMI support routines
  *
- *  Copyright (c) 2009-2013 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Mike Travis
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Mike Travis
  */
 
 #include <linux/cpu.h>
@@ -54,6 +54,20 @@ static struct uv_hub_nmi_s **uv_hub_nmi_list;
 
 DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 
+/* Newer SMM NMI handler, not present in all systems */
+static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
+static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
+static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
+static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
+static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
+
+/* Non-zero indicates newer SMM NMI handler present */
+static unsigned long uvh_nmi_mmrx_supported;	/* UVH_EXTIO_INT0_BROADCAST */
+
+/* Indicates to BIOS that we want to use the newer SMM NMI handler */
+static unsigned long uvh_nmi_mmrx_req;		/* UVH_BIOS_KERNEL_MMR_ALIAS_2 */
+static int uvh_nmi_mmrx_req_shift;		/* 62 */
+
 /* UV hubless values */
 #define NMI_CONTROL_PORT	0x70
 #define NMI_DUMMY_PORT		0x71
@@ -227,13 +241,43 @@ static inline bool uv_nmi_action_is(const char *action)
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
-	if (uv_read_local_mmr(UVH_NMI_MMRX_SUPPORTED)) {
-		uv_write_local_mmr(UVH_NMI_MMRX_REQ,
-					1UL << UVH_NMI_MMRX_REQ_SHIFT);
-		nmi_mmr = UVH_NMI_MMRX;
-		nmi_mmr_clear = UVH_NMI_MMRX_CLEAR;
-		nmi_mmr_pending = 1UL << UVH_NMI_MMRX_SHIFT;
-		pr_info("UV: SMI NMI support: %s\n", UVH_NMI_MMRX_TYPE);
+	/* First determine arch specific MMRs to handshake with BIOS */
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
+		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
+		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
+		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
+		uvh_nmi_mmrx_type = "OCRD0-EXTIO_INT0";
+
+		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
+		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
+		uvh_nmi_mmrx_req_shift = 62;
+
+	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
+		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
+		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
+		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
+		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK;
+		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
+
+		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
+		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
+		uvh_nmi_mmrx_req_shift = 62;
+
+	} else {
+		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
+			__func__);
+		return;
+	}
+
+	/* Then find out if new NMI is supported */
+	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
+		uv_write_local_mmr(uvh_nmi_mmrx_req,
+					1UL << uvh_nmi_mmrx_req_shift);
+		nmi_mmr = uvh_nmi_mmrx;
+		nmi_mmr_clear = uvh_nmi_mmrx_clear;
+		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
+		pr_info("UV: SMI NMI support: %s\n", uvh_nmi_mmrx_type);
 	} else {
 		nmi_mmr = UVH_NMI_MMR;
 		nmi_mmr_clear = UVH_NMI_MMR_CLEAR;
@@ -1049,5 +1093,5 @@ void __init uv_nmi_setup_hubless(void)
 	/* Ensure NMI enabled in Processor Interface Reg: */
 	uv_reassert_nmi();
 	uv_register_nmi_notifier();
-	pr_info("UV: Hubless NMI enabled\n");
+	pr_info("UV: PCH NMI enabled\n");
 }
