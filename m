Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0A420A3A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhJDLnZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhJDLnT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 07:43:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72F8C061749;
        Mon,  4 Oct 2021 04:41:30 -0700 (PDT)
Date:   Mon, 04 Oct 2021 11:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633347689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ir78h2bax1p7S9EXZ1M6DyyOQllMZIcBDeSybVjB4EU=;
        b=f15/VJDpgWIPW7sxYlQqrO8mlWgEv++d6zpy4G+Kz1pV4ZXo7bEIq+xq0IuBAnT32BKBXv
        vdjM4hFa/Xu+Xur2wAc5p6at23AUyzMdfLbQJZMrI9pCSTiHyg7jxgN19IFg7fsNF7+bLB
        HRMhqbluOs+DtdbBeE3wtaEsLcWQxP0scZIdMPd4ysyP8JOSn9POhoxOklJxBkIGKxJvJz
        B4geo0Z4NNxF5//Ct9JzSEVMODAgeshz0iRTaW4o86FPmFkspPIiF6DzNtT3qB+W4iHeYr
        3hYtOvoZwwTQBhlNWl9K/s0NTOIfhAq7Rl0S+PMd0kBFRPZ1YY39S1N1ykuYDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633347689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ir78h2bax1p7S9EXZ1M6DyyOQllMZIcBDeSybVjB4EU=;
        b=PiDe7XwhMNFn7tu5JavALU9OLuOKmPwJQMmbx3OR1mepy06OUTCQUB39vgHziKo+5VknCc
        UM73QzSiPlHTkADQ==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928191009.32551-5-bp@alien8.de>
References: <20210928191009.32551-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163334768869.25758.17411401562140367695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     bfebd37e99dece9c83a373cf9f35def440fdd5df
Gitweb:        https://git.kernel.org/tip/bfebd37e99dece9c83a373cf9f35def440fdd5df
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 08 Sep 2021 17:58:35 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:46:33 +02:00

powerpc/pseries/svm: Add a powerpc version of cc_platform_has()

Introduce a powerpc version of the cc_platform_has() function. This will
be used to replace the powerpc mem_encrypt_active() implementation, so
the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
attribute.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lkml.kernel.org/r/20210928191009.32551-5-bp@alien8.de
---
 arch/powerpc/platforms/pseries/Kconfig       |  1 +-
 arch/powerpc/platforms/pseries/Makefile      |  2 +-
 arch/powerpc/platforms/pseries/cc_platform.c | 26 +++++++++++++++++++-
 3 files changed, 29 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5e037df..2e57391 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -159,6 +159,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_CC_PLATFORM
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 4cda0ef..41d8aee 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o
+
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/platforms/pseries/cc_platform.c
new file mode 100644
index 0000000..e8021af
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/cc_platform.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/export.h>
+#include <linux/cc_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/svm.h>
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_secure_guest();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
