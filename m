Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050C32AA465
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgKGKSy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 05:18:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgKGKSv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 05:18:51 -0500
Date:   Sat, 07 Nov 2020 10:18:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604744326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfpOKFPHnxu+UuxH1OShMP6HvIVxuAuxNfzN3n9l++c=;
        b=N0N+SAKZdpb5bhlGGZF+bWUa5eTY1N7qhLLKmaH/+CdAaFFbByCYo0LS7oEY8E/c8eX0GE
        umXHt2GeKboBaGhXUKixQiYlkLA7w5mZ2iSt5AADvSdk15JLG742qHsntcTbYKkIDT5FW0
        Y3MUUREiAiMqrbOxf1fIAkwRIjVQiRYWoWBT/f/mpXxTa7sZRRjTs74E6XxlQP4FEIOqP1
        cPywr4w297xcqWCombCbwQE/Qh49Kwwzq2jgyIbocP8ED7OPG/x0jJxdgRfco0yRUnMwaR
        uZ4wqc+Aj9wWHA2IwHnmdkk6G7S8MkQ/3RE02v0+XVL1KiYFZ40SlK0OyU0tyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604744326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfpOKFPHnxu+UuxH1OShMP6HvIVxuAuxNfzN3n9l++c=;
        b=fzmPhdcrxweCLy6ZP/40uT5mx4dynQffhIWomK9L/+uW6loEtUHuvlDiNyVClNO3tRsTr+
        Ykbe4R8b0z9br0Bg==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Fix missing OEM_TABLE_ID
Cc:     Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201105222741.157029-2-mike.travis@hpe.com>
References: <20201105222741.157029-2-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160474432572.397.11629900432820445475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1aec69ae56be28b5fd3c9daead5f3840c30153c8
Gitweb:        https://git.kernel.org/tip/1aec69ae56be28b5fd3c9daead5f3840c30153c8
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Thu, 05 Nov 2020 16:27:39 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:17:39 +01:00

x86/platform/uv: Fix missing OEM_TABLE_ID

Testing shows a problem in that the OEM_TABLE_ID was missing for
hubless systems.  This is used to determine the APIC type (legacy or
extended).  Add the OEM_TABLE_ID to the early hubless processing.

Fixes: 1e61f5a95f191 ("Add and decode Arch Type in UVsystab")
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201105222741.157029-2-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 714233c..a579479 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -366,7 +366,7 @@ static int __init early_get_arch_type(void)
 	return ret;
 }
 
-static int __init uv_set_system_type(char *_oem_id)
+static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 {
 	/* Save OEM_ID passed from ACPI MADT */
 	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
@@ -394,6 +394,9 @@ static int __init uv_set_system_type(char *_oem_id)
 		else
 			uv_hubless_system = 0x9;
 
+		/* Copy APIC type */
+		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
+
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
 		return 0;
@@ -456,7 +459,7 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	uv_cpu_info->p_uv_hub_info = &uv_hub_info_node0;
 
 	/* If not UV, return. */
-	if (likely(uv_set_system_type(_oem_id) == 0))
+	if (uv_set_system_type(_oem_id, _oem_table_id) == 0)
 		return 0;
 
 	/* Save and Decode OEM Table ID */
