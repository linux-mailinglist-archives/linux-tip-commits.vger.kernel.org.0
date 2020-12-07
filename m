Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B682D1D78
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Dec 2020 23:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgLGWi3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Dec 2020 17:38:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgLGWi0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Dec 2020 17:38:26 -0500
Date:   Mon, 07 Dec 2020 22:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBcx+lKmWz+jWcuORdN5ZzXrx+oJgRxfeyHAyf49Aag=;
        b=O9xH0O7VCf6FS22Me0XrOnOPDJrm58zk1ccqgGcBKWbIbEmtnmGnS4oaFLkXMoyNPBGDTC
        kxKmCA848mBt0TAWQsZsokNspFaKFisUnNQoruao69jVXY66Tn7/0ZquWgBe/165NskWzv
        o/HRvVYyoHHvHQT+xCA/WdXZSD5Hf+SVy5ahBSwpGexcJxyk9LvyeS/V3Lrqb8Lcv1IclX
        mQh0psEvWVe2HUBHJSySq1TcWF6GLd2baxE7RcdvE6KpmkOSYsH75tnTrjiiUOGYi5ybzQ
        6H2dJDrEeusuvt+FemT7l42CW2KcgU3qb4yfAlhju3A6JnPKyWgBRzXfFmIetQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBcx+lKmWz+jWcuORdN5ZzXrx+oJgRxfeyHAyf49Aag=;
        b=1iIP+g4/K8QUGmsTcosfkhlOfqzSVoGZJfGkUoLy2Pfmpo83/pBm3IrQZqJLDKgCQGKwIJ
        LUh4PqOv4ONT1iCg==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add kernel interfaces for
 obtaining system info
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128034227.120869-2-mike.travis@hpe.com>
References: <20201128034227.120869-2-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160738066295.3364.4859407678343290345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     a67fffb017aed93fca42ce7aa5b6aaf54ff912ad
Gitweb:        https://git.kernel.org/tip/a67fffb017aed93fca42ce7aa5b6aaf54ff912ad
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 27 Nov 2020 21:42:23 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Dec 2020 19:44:54 +01:00

x86/platform/uv: Add kernel interfaces for obtaining system info

Add kernel interfaces used to obtain info for the uv_sysfs driver
to display.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201128034227.120869-2-mike.travis@hpe.com
---
 arch/x86/include/asm/uv/bios.h     |  2 ++
 arch/x86/kernel/apic/x2apic_uv_x.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 01ba080..1b6455f 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -200,6 +200,8 @@ extern long sn_partition_id;
 extern long sn_coherency_id;
 extern long sn_region_size;
 extern long system_serial_number;
+extern ssize_t uv_get_archtype(char *buf, int len);
+extern int uv_get_hubless_system(void);
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1b98f8c..4874603 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -502,6 +502,18 @@ enum uv_system_type get_uv_system_type(void)
 	return uv_system_type;
 }
 
+int uv_get_hubless_system(void)
+{
+	return uv_hubless_system;
+}
+EXPORT_SYMBOL_GPL(uv_get_hubless_system);
+
+ssize_t uv_get_archtype(char *buf, int len)
+{
+	return scnprintf(buf, len, "%s/%s", uv_archtype, oem_table_id);
+}
+EXPORT_SYMBOL_GPL(uv_get_archtype);
+
 int is_uv_system(void)
 {
 	return uv_system_type != UV_NONE;
