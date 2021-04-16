Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F5361E54
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhDPK5P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 06:57:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbhDPK5O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 06:57:14 -0400
Date:   Fri, 16 Apr 2021 10:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618570608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ4lprZqt+8n8gDiVEn8FcY2iGhKtVDymOj7pvaCp2I=;
        b=m1fJpzsMCrFBvP2uVYCeIX60HPvCPi70fvn4QxSAxjsx8ZV6jH+VqgrtSRQjcE16Z0i3es
        f2F7wdD2cvg7/6l+MKG3ptC1kVWTWGY1Wl/g5/8GiQAUV28MwIu8BOnirPKH+PFiV61BIo
        OdHrytu0VBY+SiCEqVgufvh6fLtyQxycLrvDMKtYTOMbPT12ngS5PU3qhr566+3fFozmSk
        /UMQAcJMIYhFnfB6hrmRb2Q6wvbL+7El+EBSl8GOaZxg6HrdoFbyUfmRC10+Tn46UqcsfW
        J0Se8lrG4HNWFQFWEiUgR4vcagQ0q4gvAjQDuD9SANlLYyCpmD4kIUFhmsp/qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618570608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ4lprZqt+8n8gDiVEn8FcY2iGhKtVDymOj7pvaCp2I=;
        b=u66uUyFGeOeTiYKI+bqgMce2wlyXXEdjlPWi2TBw7VcBuMYHqv+T5hQRAWReO53KyZFLGm
        YZ6cUYgOoK9rqMDQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Use x2apic enabled bit as set by
 BIOS to indicate APIC mode
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210408160047.1703-1-mike.travis@hpe.com>
References: <20210408160047.1703-1-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <161857060761.29796.13495516816737315712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     26d4be3ea1b77cc00b5b638faed7a357204f9150
Gitweb:        https://git.kernel.org/tip/26d4be3ea1b77cc00b5b638faed7a357204f9150
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Thu, 08 Apr 2021 11:00:47 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 16 Apr 2021 12:51:03 +02:00

x86/platform/uv: Use x2apic enabled bit as set by BIOS to indicate APIC mode

BIOS now sets the x2apic enabled bit (and the ACPI table) for extended
APIC modes. Use that bit to indicate if extended mode is set.

 [ bp: Fixup subject prefix, merge subsequent fix
   https://lkml.kernel.org/r/20210415220626.223955-1-mike.travis@hpe.com ]

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210408160047.1703-1-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 30 ++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index c9ddd23..f5a48e6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -369,6 +369,15 @@ static int __init early_get_arch_type(void)
 	return ret;
 }
 
+/* UV system found, check which APIC MODE BIOS already selected */
+static void __init early_set_apic_mode(void)
+{
+	if (x2apic_enabled())
+		uv_system_type = UV_X2APIC;
+	else
+		uv_system_type = UV_LEGACY_APIC;
+}
+
 static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 {
 	/* Save OEM_ID passed from ACPI MADT */
@@ -404,11 +413,12 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 		else
 			uv_hubless_system |= 0x8;
 
-		/* Copy APIC type */
+		/* Copy OEM Table ID */
 		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
 
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
+
 		return 0;
 	}
 
@@ -453,6 +463,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 	early_set_hub_type();
 
 	/* Other UV setup functions */
+	early_set_apic_mode();
 	early_get_pnodeid();
 	early_get_apic_socketid_shift();
 	x86_platform.is_untracked_pat_range = uv_is_untracked_pat_range;
@@ -472,29 +483,14 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	if (uv_set_system_type(_oem_id, _oem_table_id) == 0)
 		return 0;
 
-	/* Save and Decode OEM Table ID */
+	/* Save for display of the OEM Table ID */
 	uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
 
-	/* This is the most common hardware variant, x2apic mode */
-	if (!strcmp(oem_table_id, "UVX"))
-		uv_system_type = UV_X2APIC;
-
-	/* Only used for very small systems, usually 1 chassis, legacy mode  */
-	else if (!strcmp(oem_table_id, "UVL"))
-		uv_system_type = UV_LEGACY_APIC;
-
-	else
-		goto badbios;
-
 	pr_info("UV: OEM IDs %s/%s, System/UVType %d/0x%x, HUB RevID %d\n",
 		oem_id, oem_table_id, uv_system_type, is_uv(UV_ANY),
 		uv_min_hub_revision_id);
 
 	return 0;
-
-badbios:
-	pr_err("UV: UVarchtype:%s not supported\n", uv_archtype);
-	BUG();
 }
 
 enum uv_system_type get_uv_system_type(void)
