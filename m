Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE727E037
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgI3FWx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgI3FWW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0E8C061755;
        Tue, 29 Sep 2020 22:22:22 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mUzJTkhwU5r5M505flGpRdsJxhxNzqeTLp2KJJuEoJs=;
        b=0637RWseILa5hOHVtqHzfyZobWpEdYud9gLl/4Ou+b3Cb43yzI0JeB5/8WUMoep+/V6Cyp
        aM1IZYPRGQSyhPi5Yyq8FzAezTC4/yZkKZoPpXHsHkDqL0DOenCmP5BIBNHEup4uP15CWi
        TulY4vNMtMrT9d8RuQh5/yvFzR2DpOsNcdZHNty6zGvhDID1oa8JlslXb8EX8Mu6+V0jH9
        qAJec9INDMBIgok5z4EgGVgUikqaYW9xVfoY9kf/3dYgFvx+IeFz5y0RGHxdeQujcfh9K3
        clAVop9o4YXdCgMY2jJQQOmYOZgTEz0f994lObKgkeY0Rcw39AvAAU072zf29Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mUzJTkhwU5r5M505flGpRdsJxhxNzqeTLp2KJJuEoJs=;
        b=w1nPwPqtscASP72E5vxKvtljnjuW+9+LWl/Uf7j+Pth2kj7Nbs2a2f2SEUqA4JFIFe3Efx
        4mMsL/a9P1o9FEAg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: gsmi: fix false dependency on CONFIG_EFI_VARS
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144334023.7002.2948247564097221973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     9846d86031eeca2fb2867fe4ac9d92803a97e8e4
Gitweb:        https://git.kernel.org/tip/9846d86031eeca2fb2867fe4ac9d92803a97e8e4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 10:18:31 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: gsmi: fix false dependency on CONFIG_EFI_VARS

The gsmi code does not actually rely on CONFIG_EFI_VARS, since it only
uses the efivars abstraction that is included unconditionally when
CONFIG_EFI is defined. CONFIG_EFI_VARS controls the inclusion of the
code that exposes the sysfs entries, and which has been deprecated for
some time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/google/Kconfig | 2 +-
 drivers/firmware/google/gsmi.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a3a6ca6..97968ae 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -15,7 +15,7 @@ config GOOGLE_SMI
 	help
 	  Say Y here if you want to enable SMI callbacks for Google
 	  platforms.  This provides an interface for writing to and
-	  clearing the event log.  If EFI_VARS is also enabled this
+	  clearing the event log.  If CONFIG_EFI is also enabled this
 	  driver provides an interface for reading and writing NVRAM
 	  variables.
 
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 5b2011e..7d9367b 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -302,7 +302,7 @@ static int gsmi_exec(u8 func, u8 sub)
 	return rc;
 }
 
-#ifdef CONFIG_EFI_VARS
+#ifdef CONFIG_EFI
 
 static struct efivars efivars;
 
@@ -483,7 +483,7 @@ static const struct efivar_operations efivar_ops = {
 	.get_next_variable = gsmi_get_next_variable,
 };
 
-#endif /* CONFIG_EFI_VARS */
+#endif /* CONFIG_EFI */
 
 static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
@@ -1007,7 +1007,7 @@ static __init int gsmi_init(void)
 		goto out_remove_bin_file;
 	}
 
-#ifdef CONFIG_EFI_VARS
+#ifdef CONFIG_EFI
 	ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
 	if (ret) {
 		printk(KERN_INFO "gsmi: Failed to register efivars\n");
@@ -1047,7 +1047,7 @@ static void __exit gsmi_exit(void)
 	unregister_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &gsmi_panic_notifier);
-#ifdef CONFIG_EFI_VARS
+#ifdef CONFIG_EFI
 	efivars_unregister(&efivars);
 #endif
 
