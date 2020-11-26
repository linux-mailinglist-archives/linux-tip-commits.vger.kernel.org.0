Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1FB2C5BE2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Nov 2020 19:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404602AbgKZSUt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Nov 2020 13:20:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404912AbgKZSUs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Nov 2020 13:20:48 -0500
Date:   Thu, 26 Nov 2020 18:20:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606414846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlcayK7R35d/8wHwJfe/xLq08spN1DiYPSDFbWFxf5o=;
        b=P8zfevwL6j12rqXh0fD2+yngsXb95Nt9m1Y9xCAmmUZdhL0rITq0MUan+qzuzzud3UmMYI
        TJiZ7VrBe8BW5J/clMpbKbZi3HDtVYEzHlrpQdesiC1UY95HnlltvAVdqjY0C3yMfk+hS6
        kW3yo9ko0uAS038P3drSPBSThuerxhcd8K+yXhYHmS5hiHTNr9NUYT2MCZmJGA71MzNXJd
        0qEqwvEOhOZWs39KtefQJucAOY7tjyUBUIQ6zTPDkFcfj1QD/kHwkBTRi9tE0SnUMgIGED
        gJwPdXKS1GYTDDFhVlqSq8cv/X456nspjlUtclVZB59bxCkR18AQ4cfMBlDA0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606414846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlcayK7R35d/8wHwJfe/xLq08spN1DiYPSDFbWFxf5o=;
        b=5jzMxz5ne8VCJjUidy5y1UTdgqz5RITgMw2c1Ecy6Qrj6sz/U+bpLkZwoQwH5svYrVm3zq
        gxEn0/ln+uEjygAw==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove existing
 /sys/firmware/sgi_uv/ interface
Cc:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201125175444.279074-2-justin.ernst@hpe.com>
References: <20201125175444.279074-2-justin.ernst@hpe.com>
MIME-Version: 1.0
Message-ID: <160641484575.3364.16776997871843821538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8f061abbf543355d77fac5c23521b6b452da6310
Gitweb:        https://git.kernel.org/tip/8f061abbf543355d77fac5c23521b6b452da6310
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Wed, 25 Nov 2020 11:54:40 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 26 Nov 2020 12:08:17 +01:00

x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface

Remove existing interface at /sys/firmware/sgi_uv/, created by
arch/x86/platform/uv/uv_sysfs.c

This interface includes:
/sys/firmware/sgi_uv/coherence_id
/sys/firmware/sgi_uv/partition_id

Both coherence_id and partition_id will be re-introduced via a
new uv_sysfs driver.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201125175444.279074-2-justin.ernst@hpe.com
---
 arch/x86/platform/uv/Makefile   |  2 +-
 arch/x86/platform/uv/uv_sysfs.c | 63 +--------------------------------
 2 files changed, 1 insertion(+), 64 deletions(-)
 delete mode 100644 arch/x86/platform/uv/uv_sysfs.c

diff --git a/arch/x86/platform/uv/Makefile b/arch/x86/platform/uv/Makefile
index 224ff05..1441dda 100644
--- a/arch/x86/platform/uv/Makefile
+++ b/arch/x86/platform/uv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_X86_UV)		+= bios_uv.o uv_irq.o uv_sysfs.o uv_time.o uv_nmi.o
+obj-$(CONFIG_X86_UV)		+= bios_uv.o uv_irq.o uv_time.o uv_nmi.o
diff --git a/arch/x86/platform/uv/uv_sysfs.c b/arch/x86/platform/uv/uv_sysfs.c
deleted file mode 100644
index 266773e..0000000
--- a/arch/x86/platform/uv/uv_sysfs.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * This file supports the /sys/firmware/sgi_uv interfaces for SGI UV.
- *
- *  Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson
- */
-
-#include <linux/device.h>
-#include <asm/uv/bios.h>
-#include <asm/uv/uv.h>
-
-struct kobject *sgi_uv_kobj;
-
-static ssize_t partition_id_show(struct kobject *kobj,
-			struct kobj_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_partition_id);
-}
-
-static ssize_t coherence_id_show(struct kobject *kobj,
-			struct kobj_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_coherency_id);
-}
-
-static struct kobj_attribute partition_id_attr =
-	__ATTR(partition_id, S_IRUGO, partition_id_show, NULL);
-
-static struct kobj_attribute coherence_id_attr =
-	__ATTR(coherence_id, S_IRUGO, coherence_id_show, NULL);
-
-
-static int __init sgi_uv_sysfs_init(void)
-{
-	unsigned long ret;
-
-	if (!is_uv_system())
-		return -ENODEV;
-
-	if (!sgi_uv_kobj)
-		sgi_uv_kobj = kobject_create_and_add("sgi_uv", firmware_kobj);
-	if (!sgi_uv_kobj) {
-		printk(KERN_WARNING "kobject_create_and_add sgi_uv failed\n");
-		return -EINVAL;
-	}
-
-	ret = sysfs_create_file(sgi_uv_kobj, &partition_id_attr.attr);
-	if (ret) {
-		printk(KERN_WARNING "sysfs_create_file partition_id failed\n");
-		return ret;
-	}
-
-	ret = sysfs_create_file(sgi_uv_kobj, &coherence_id_attr.attr);
-	if (ret) {
-		printk(KERN_WARNING "sysfs_create_file coherence_id failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-device_initcall(sgi_uv_sysfs_init);
