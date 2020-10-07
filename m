Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDE28591A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgJGHME (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgJGHME (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFBC0613D3;
        Wed,  7 Oct 2020 00:12:03 -0700 (PDT)
Date:   Wed, 07 Oct 2020 07:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UE+YUeFJl8M3BAvUlIkinIco6yl+8C3KcCHS8YjWRes=;
        b=w0CT71Lj+LKwGOtJvdMGD4UBRSHho++h6xAM6O2TRmFN1CYEl4gz5P44gfsc6SnIudYY3o
        fvcYWFpC7ClkrLOjVwh/OrOwSjuo3RSdlVy5M0cZ4XM7YYmxEHXzzj+iqMcnt63bEGFaMH
        hrI+jdAKwYDO46RF/3spGWASz53sGqHv3P7IfzsndO1M/nedqWY0/LY2O1YmIlbf0XhEEn
        CBqhEAzqvnZD9g1BNgZTTViYPsHUyH72rQSUvAembQFvQIwVxz9UbqYsHUZQrg/DhnlhVM
        I2gtLk1BVgZWgmy+mfSk8o2gzvdy8MJUjk6jd7a+kWSjQeR6+iAVu+0ma6IQaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UE+YUeFJl8M3BAvUlIkinIco6yl+8C3KcCHS8YjWRes=;
        b=CDnVw/NcE6iCEfkgzPB4+pk2/X9PwaJ/FBcNt7lckP4RSE9OmUElgJT/vnvLRBWqjVYh8j
        mqNm4BPokw09Z+Cw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update UV5 TSC checking
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-12-mike.travis@hpe.com>
References: <20201005203929.148656-12-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472083.7002.1987381597518958972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     6a7cf55e9f2b743695adac84375548aa18112327
Gitweb:        https://git.kernel.org/tip/6a7cf55e9f2b743695adac84375548aa18112327
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:27 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:09:04 +02:00

x86/platform/uv: Update UV5 TSC checking

Update check of BIOS TSC sync status to include both possible "invalid"
states provided by newer UV5 BIOS.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-12-mike.travis@hpe.com
---
 arch/x86/include/asm/uv/uv_hub.h   |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c | 24 ++++++++++--------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index ecf5c93..07079b5 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -726,7 +726,7 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_TSC_SYNC_SHIFT_UV2K	16	/* UV2/3k have different bits */
 #define UVH_TSC_SYNC_MASK	3	/* 0011 */
 #define UVH_TSC_SYNC_VALID	3	/* 0011 */
-#define UVH_TSC_SYNC_INVALID	2	/* 0010 */
+#define UVH_TSC_SYNC_UNKNOWN	0	/* 0000 */
 
 /* BMC sets a bit this MMR non-zero before sending an NMI */
 #define UVH_NMI_MMR		UVH_BIOS_KERNEL_MMR
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9b44f45..9a83aa1 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -197,36 +197,32 @@ static void __init uv_tsc_check_sync(void)
 	int sync_state;
 	int mmr_shift;
 	char *state;
-	bool valid;
 
-	/* Accommodate different UV arch BIOSes */
+	/* Different returns from different UV BIOS versions */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
 	mmr_shift =
 		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
 	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
+	/* Check if TSC is valid for all sockets */
 	switch (sync_state) {
 	case UVH_TSC_SYNC_VALID:
 		state = "in sync";
-		valid = true;
+		mark_tsc_async_resets("UV BIOS");
 		break;
 
-	case UVH_TSC_SYNC_INVALID:
-		state = "unstable";
-		valid = false;
+	/* If BIOS state unknown, don't do anything */
+	case UVH_TSC_SYNC_UNKNOWN:
+		state = "unknown";
 		break;
+
+	/* Otherwise, BIOS indicates problem with TSC */
 	default:
-		state = "unknown: assuming valid";
-		valid = true;
+		state = "unstable";
+		mark_tsc_unstable("UV BIOS");
 		break;
 	}
 	pr_info("UV: TSC sync state from BIOS:0%d(%s)\n", sync_state, state);
-
-	/* Mark flag that says TSC != 0 is valid for socket 0 */
-	if (valid)
-		mark_tsc_async_resets("UV BIOS");
-	else
-		mark_tsc_unstable("UV BIOS");
 }
 
 /* Selector for (4|4A|5) structs */
