Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280102D1D72
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Dec 2020 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgLGWiZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Dec 2020 17:38:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLGWiZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Dec 2020 17:38:25 -0500
Date:   Mon, 07 Dec 2020 22:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlOv2nhZSYUNfrDH/NODvJ/R+ba+fzVidFl8yW+bX4U=;
        b=AWtwOsZXFLKxyvWxxjwD2yvjoHMyBy7axHmaL23yQ1loTYgFptqo2iDc2Ksp0kh0gMigcS
        UDhx4hCYEbPfxrOAIHtEANbj3Y8bJbM7PIPlE/U/rr6934yZdDMZsfP3x2xbMWj/lmh9M+
        fdsBh9F7q/gvxz0NWaPfJllu4iOjgLkA878pNzcfA2X9MAUJMh0+XFuBzAngZL2m0LSlco
        HLEiFrxhVLJfxkX+fHOfXcj4OPUDTjR0x6O7eKHQFnCMNkEbhH1hhpQ/2McmLOTcGpAo9o
        /dFPAAhQD1U15jg4ky3fJnomy5tAKDlgm23SJzLqr3jNp+0OyYSr9fo1w6fGWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlOv2nhZSYUNfrDH/NODvJ/R+ba+fzVidFl8yW+bX4U=;
        b=pLk7yayMjffPBEs4HqX/u29iXw9efjgSqNsm+d4HSguJX9ojYW4sDMUP95OoySf5V/PbAR
        VpLL0KawZltmduAA==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add deprecated messages to /proc
 info leaves
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128034227.120869-5-mike.travis@hpe.com>
References: <20201128034227.120869-5-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160738066254.3364.17197742331172905331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     148c277165cdc72d97d1711b9a1e566d66521828
Gitweb:        https://git.kernel.org/tip/148c277165cdc72d97d1711b9a1e566d66521828
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 27 Nov 2020 21:42:26 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Dec 2020 20:03:09 +01:00

x86/platform/uv: Add deprecated messages to /proc info leaves

Add "deprecated" message to any access to old /proc/sgi_uv/* leaves.

 [ bp: Do not have a trailing function opening brace and the arguments
   continuing on the next line and align them on the opening brace. ]

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201128034227.120869-5-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 4874603..d75e1d9 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1615,21 +1615,30 @@ static void check_efi_reboot(void)
 		reboot_type = BOOT_ACPI;
 }
 
-/* Setup user proc fs files */
+/*
+ * User proc fs file handling now deprecated.
+ * Recommend using /sys/firmware/sgi_uv/... instead.
+ */
 static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
 {
+	pr_notice_once("%s: using deprecated /proc/sgi_uv/hubbed, use /sys/firmware/sgi_uv/hub_type\n",
+		       current->comm);
 	seq_printf(file, "0x%x\n", uv_hubbed_system);
 	return 0;
 }
 
 static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 {
+	pr_notice_once("%s: using deprecated /proc/sgi_uv/hubless, use /sys/firmware/sgi_uv/hubless\n",
+		       current->comm);
 	seq_printf(file, "0x%x\n", uv_hubless_system);
 	return 0;
 }
 
 static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
 {
+	pr_notice_once("%s: using deprecated /proc/sgi_uv/archtype, use /sys/firmware/sgi_uv/archtype\n",
+		       current->comm);
 	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
 	return 0;
 }
