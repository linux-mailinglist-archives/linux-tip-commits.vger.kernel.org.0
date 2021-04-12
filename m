Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E235C70A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Apr 2021 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbhDLNJq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Apr 2021 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbhDLNJp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Apr 2021 09:09:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B13C061574;
        Mon, 12 Apr 2021 06:09:27 -0700 (PDT)
Date:   Mon, 12 Apr 2021 13:09:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618232966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHX2Vmkq/amSHVQbX2220WI83Gezgw89KYaGdbOBMAw=;
        b=K8yVnXroAiLpmnrA92kYwi4DE4ECi4syaLqHtwcPR19wvTPEOBHmmnLmd+toCAtnTcxOHq
        Eh8PaWyoxvlUz9cT5wvav7gaUR8Dvi7xfQjq+6rpVPnc90meiMJp1LqmX+fdJEj39DsdNY
        gmzvBxVRhzY57r6O1M2SpnUKqyQvJppSUHN7NIKclYaxQz2yMmB355/VJKgn88hOtnvMUa
        mGk+QRP/tCB/QH9bkEbgDM4HTMpVb3OFTVYsHzE2jBIe8L1AxAhoQ0NqS2oASaUPCVGEMQ
        +j59DiIA2VQ0mpoKNBtxIaEqj+k00UbBN/+zgxmh1GoTkteCyOkrUwSwX9Gb5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618232966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHX2Vmkq/amSHVQbX2220WI83Gezgw89KYaGdbOBMAw=;
        b=1A5zf1rUHVoxppEyrlrGBX/evkogVZ7J/5EvfOra3onJJLiG3z002z2n2rh8C+iJLTRiPr
        OEqd0wstcC/KsUBw==
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
Message-ID: <161823296510.29796.15311781031089345064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     41e2da9b5e670a9876ea7b4d8c685a49b1eeee70
Gitweb:        https://git.kernel.org/tip/41e2da9b5e670a9876ea7b4d8c685a49b1eeee70
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Thu, 08 Apr 2021 11:00:47 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 12 Apr 2021 15:00:34 +02:00

x86/platform/uv: Use x2apic enabled bit as set by BIOS to indicate APIC mode

BIOS now sets the x2apic enabled bit (and the ACPI table) for extended
APIC modes. Use that bit to indicate if extended mode is set.

 [ bp: Fixup subject prefix. ]

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210408160047.1703-1-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 31 +++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index c9ddd23..930dd09 100644
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
@@ -404,11 +413,13 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 		else
 			uv_hubless_system |= 0x8;
 
-		/* Copy APIC type */
+		/* Copy OEM Table ID and set APIC Mode */
 		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
+		early_set_apic_mode();
 
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
+
 		return 0;
 	}
 
@@ -453,6 +464,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 	early_set_hub_type();
 
 	/* Other UV setup functions */
+	early_set_apic_mode();
 	early_get_pnodeid();
 	early_get_apic_socketid_shift();
 	x86_platform.is_untracked_pat_range = uv_is_untracked_pat_range;
@@ -472,29 +484,14 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
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
