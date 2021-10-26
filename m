Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55F043B6D7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhJZQTS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhJZQTL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12EC061767;
        Tue, 26 Oct 2021 09:16:47 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdghuU66TBlI2LDNlvIdBVesAL/bvj3emUYRWWAJtjY=;
        b=ZuPZbD+kPi1afWG9/Qlyvw0I7KgDApW+VYi+p5Afs6hhTrtD4J9T7yjj06/8PBDZsPZcnI
        77Q0hsVW9VpA+5rPpLoa2kX2VUe802M8FVM3jNDTY1lA4lq3+9fLvxpJ58xx6Yr4i31IcS
        bJk6b0jPKc/bFCwZiJ3jxWYlknIrgLz3g5GQMmMAJ/93oervMoTCOXKbQKLNdKVMbenHNF
        eXN/wwQKJzpghlvMWzA+PsHS2zR709i8t4sDuqr8Abe8OfE0pVrcEnLkD6TcoOJma3wU86
        gskz0C/EAMHVmeeXJ+btZi9xdTtmLKmjW2+EsYQoe3l4r0DJNlf59LQHdH8JXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdghuU66TBlI2LDNlvIdBVesAL/bvj3emUYRWWAJtjY=;
        b=9R+Bm0Cw/Yqbn9gGOb+F2TN3THWuzVqcETSShTPBL1SmAQhfKzSzzD0C1Hq/2FDfC9IYLd
        CRS9r7lKq0ZTeDDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add basic helpers for dynamically enabled features
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-8-chang.seok.bae@intel.com>
References: <20211021225527.10184-8-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500485.626.11095255835330131135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     23686ef25d4ae81bc12fe3994d1905191fcf71f8
Gitweb:        https://git.kernel.org/tip/23686ef25d4ae81bc12fe3994d1905191fcf71f8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:11 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu: Add basic helpers for dynamically enabled features

To allow building up the infrastructure required to support dynamically
enabled FPU features, add:

 - XFEATURES_MASK_DYNAMIC

   This constant will hold xfeatures which can be dynamically enabled.

 - fpu_state_size_dynamic()

   A static branch for 64-bit and a simple 'return false' for 32-bit.

   This helper allows to add dynamic-feature-specific changes to common
   code which is shared between 32-bit and 64-bit without #ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-8-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/xstate.h | 21 +++++++++++++++++++++
 arch/x86/kernel/fpu/core.c        |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 43ae89d..cf28546 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -43,6 +43,9 @@
 #define XFEATURE_MASK_USER_RESTORE	\
 	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
 
+/* Features which are dynamically enabled for a process on request */
+#define XFEATURE_MASK_USER_DYNAMIC	0ULL
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
@@ -96,4 +99,22 @@ int xfeature_size(int xfeature_nr);
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+#endif
+
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+
+static __always_inline __pure bool fpu_state_size_dynamic(void)
+{
+	return static_branch_unlikely(&__fpu_state_size_dynamic);
+}
+#else
+static __always_inline __pure bool fpu_state_size_dynamic(void)
+{
+	return false;
+}
+#endif
+
 #endif
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index b05f6a3..4018083 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -25,6 +25,10 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/fpu.h>
 
+#ifdef CONFIG_X86_64
+DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+#endif
+
 /* The FPU state configuration data for kernel and user space */
 struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
 struct fpu_state_config fpu_user_cfg __ro_after_init;
