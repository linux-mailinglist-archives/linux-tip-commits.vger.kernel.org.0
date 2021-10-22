Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFD437EE7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhJVT6y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhJVT6w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA5C061766;
        Fri, 22 Oct 2021 12:56:33 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:56:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jfje8YW+0qsmZLq0Poj+O1v9foCTTHwZk0N5bqDooj8=;
        b=V5CztjpAG8FYbI5jEjsoCTBRAiHnQVCRIQkfAsv2qi1xg4W4oQPkM8KR1KdL6OSkaGbXAn
        RUqYgOKTa/9nnE7t7aEPa+tMXq+rqn72PFbHc5UbFUZ8IlGQ6gPTa+FQ2ToP6B0QZ/JP4h
        ZFnOqefjDtMap7iktovH+M2xMJBbQLTvDNV6PgzYQZ0vYWnpnv2IgcsB00F9n5pWlBTWHM
        PIYzxMQaeWhXEnwtY4BqOAG/H7KdgO3t0OGMuEc5CBWBXwNbFRsILUkmevjDaWLuIcNznz
        P+m3DdgTRwlWNWG3HivsEJ/Oh0xtxEUzYG8uZBfSHb+n5Z8hoHakVX5xnqajLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jfje8YW+0qsmZLq0Poj+O1v9foCTTHwZk0N5bqDooj8=;
        b=eVbzgI+vNvoUrd+AQhF7wtdZaxn0UpD/+2g3pl3RKV2FgHdVpGQss94LfgT9oJ+NF8CCbT
        U2c+ZnMLiXFkzGAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Provide struct fpu_config
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.126107370@linutronix.de>
References: <20211014230739.126107370@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493259162.626.9826889378679636793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     578971f4e228f386ad4d7ce16e979f2ed922de54
Gitweb:        https://git.kernel.org/tip/578971f4e228f386ad4d7ce16e979f2ed922de54
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 19:17:58 +02:00

x86/fpu: Provide struct fpu_config

Provide a struct to store information about the maximum supported and the
default feature set and buffer sizes for both user and kernel space.

This allows quick retrieval of this information for the upcoming support
for dynamically enabled features.

 [ bp: Add vertical spacing between the struct members. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.126107370@linutronix.de
---
 arch/x86/include/asm/fpu/types.h | 42 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/core.c       |  4 +++-
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 3a12e97..a32be07 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -378,4 +378,46 @@ struct fpu {
 	 */
 };
 
+/*
+ * FPU state configuration data. Initialized at boot time. Read only after init.
+ */
+struct fpu_state_config {
+	/*
+	 * @max_size:
+	 *
+	 * The maximum size of the register state buffer. Includes all
+	 * supported features except independent managed features.
+	 */
+	unsigned int		max_size;
+
+	/*
+	 * @default_size:
+	 *
+	 * The default size of the register state buffer. Includes all
+	 * supported features except independent managed features and
+	 * features which have to be requested by user space before usage.
+	 */
+	unsigned int		default_size;
+
+	/*
+	 * @max_features:
+	 *
+	 * The maximum supported features bitmap. Does not include
+	 * independent managed features.
+	 */
+	u64 max_features;
+
+	/*
+	 * @default_features:
+	 *
+	 * The default supported features bitmap. Does not include
+	 * independent managed features and features which have to
+	 * be requested by user space before usage.
+	 */
+	u64 default_features;
+};
+
+/* FPU state configuration information */
+extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
+
 #endif /* _ASM_X86_FPU_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index b497eca..3512bb2 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -25,6 +25,10 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/fpu.h>
 
+/* The FPU state configuration data for kernel and user space */
+struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
+struct fpu_state_config fpu_user_cfg __ro_after_init;
+
 /*
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
