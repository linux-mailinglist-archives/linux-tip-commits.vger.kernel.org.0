Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6143B6BB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhJZQTA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhJZQTA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19BC061767;
        Tue, 26 Oct 2021 09:16:36 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxyg+iJYlh06LcS0CdLNfiRNQXFOwuYySUb5E1VjJ3E=;
        b=AdLiA7gbdBN6fKYB5kIzKYluPKRSckQZK2cKgXenig2qi2rRKpFCiuEmcnUsa9FfvLvDG0
        ZrwEAXV5IO7mrAeyd/giZJc7FwBPb2gHiW/um2HQxQmDoEkAs4WAJQhoasz+9pLAU0/TaP
        1jFQ6pIBBltkX4YtJXx5wWd2GJcFq0rO0Y665wdCAYfxnBos0fpL6jD0fVGrB2jRfpKGKp
        cczjKXoPzjdJc5DKRBJM6f8FrTCWnFGt+4RsUWPfP1oSnq2cjIAGLQiuzGknUXSkuKAV8u
        9McJI4bR/C1KJ+/Eqrj6uIC4nAqQNiU7NgESVUJKcGaU+hXPxkH77VHZVhsDQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxyg+iJYlh06LcS0CdLNfiRNQXFOwuYySUb5E1VjJ3E=;
        b=5fCEUZULgxwLTR9a3Iqed8mgJpIyygJF1k8ArYdNKMi4x6r5ZNdgw0MnfOK14S4X3qq+hc
        ocWFFbdwoco/HNDg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-24-chang.seok.bae@intel.com>
References: <20211021225527.10184-24-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499347.626.1084245122471661147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2308ee57d93d896618dd65c996429c9d3e469fe0
Gitweb:        https://git.kernel.org/tip/2308ee57d93d896618dd65c996429c9d3e469fe0
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:27 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:03 +02:00

x86/fpu/amx: Enable the AMX feature in 64-bit mode

Add the AMX state components in XFEATURE_MASK_USER_SUPPORTED and the
TILE_DATA component to the dynamic states and update the permission check
table accordingly.

This is only effective on 64 bit kernels as for 32bit kernels
XFEATURE_MASK_TILE is defined as 0.

TILE_DATA is caller-saved state and the only dynamic state. Add build time
sanity check to ensure the assumption that every dynamic feature is caller-
saved.

Make AMX state depend on XFD as it is dynamic feature.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-24-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/xstate.h | 5 +++--
 arch/x86/kernel/cpu/cpuid-deps.c  | 1 +
 arch/x86/kernel/fpu/core.c        | 6 ++++++
 arch/x86/kernel/fpu/xstate.c      | 5 +++--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 10adf13..0f8b90a 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,7 +35,8 @@
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR)
+				      XFEATURE_MASK_BNDCSR | \
+				      XFEATURE_MASK_XTILE)
 
 /*
  * Features which are restored when returning to user space.
@@ -46,7 +47,7 @@
 	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
 
 /* Features which are dynamically enabled for a process on request */
-#define XFEATURE_MASK_USER_DYNAMIC	0ULL
+#define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d9ead9c..cb2fdd1 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -76,6 +76,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{}
 };
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12ca174..290836d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -495,6 +495,12 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 	}
 
 	/*
+	 * If a new feature is added, ensure all dynamic features are
+	 * caller-saved from here!
+	 */
+	BUILD_BUG_ON(XFEATURE_MASK_USER_DYNAMIC != XFEATURE_MASK_XTILE_DATA);
+
+	/*
 	 * Save the default portion of the current FPU state into the
 	 * clone. Assume all dynamic features to be defined as caller-
 	 * saved, which enables skipping both the expansion of fpstate
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 987a07b..d288294 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -404,7 +404,8 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_PKRU |			\
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
-	 XFEATURE_MASK_PASID)
+	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_XTILE)
 
 /*
  * setup the xstate image representing the init state
@@ -1636,7 +1637,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
  * Permissions array to map facilities with more than one component
  */
 static const u64 xstate_prctl_req[XFEATURE_MAX] = {
-	/* [XFEATURE_XTILE_DATA] = XFEATURE_MASK_XTILE, */
+	[XFEATURE_XTILE_DATA] = XFEATURE_MASK_XTILE_DATA,
 };
 
 static int xstate_request_perm(unsigned long idx)
