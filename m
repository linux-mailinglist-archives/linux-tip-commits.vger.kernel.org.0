Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3062143B6C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhJZQTE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbhJZQTC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BEC061767;
        Tue, 26 Oct 2021 09:16:38 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwAjAeJGbLn8gpVsv7xBnpdIpCX/fPYau0zhuhpH13w=;
        b=O6J7KNS1vzlXtMG5TXfvevhOamBpkYttJdgyQXocQB215O3PY6Nu4dvx0zK3rRfusjhn6b
        p2kxsnDGj1ivz/N4m8rSlOmjF1HYJvh+juU/MDf563yeOI04zCiY6KCWYQ+Mi1KvlpXtGP
        ZuOld5MJaGChvlTnYSFj+S0ocxNoEkkCqXO2CS86A1aAJbodjJAW7k3KN2L4Fka+OT1z+S
        catHesQCcvE0EsY16tP9GrVMGVnVHJryHoBIWYP0ZrUFAy504pyPVU5AxubUfgyMFaJJ2G
        TtVIpdyVe/ZhFaLevLeFddbx5ecoWgS6mXuWi+e6YYo+e5kf3kAgHwJAe5k+Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwAjAeJGbLn8gpVsv7xBnpdIpCX/fPYau0zhuhpH13w=;
        b=MkfGuON0FnwEfwNbHdXZupw04ugepVCUaLSUExrtzMR4gniTylsILkAoEMZXEMDezfVMNC
        77r3cs3gMqR2vHBg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Prepare XSAVE feature table for gaps
 in state component numbers
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-20-chang.seok.bae@intel.com>
References: <20211021225527.10184-20-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499640.626.13202039095128997117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     70c3f1671b0cbc386b387f1de33b7837e276a195
Gitweb:        https://git.kernel.org/tip/70c3f1671b0cbc386b387f1de33b7837e276a195
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:23 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:02 +02:00

x86/fpu/xstate: Prepare XSAVE feature table for gaps in state component numbers

The kernel checks at boot time which features are available by walking a
XSAVE feature table which contains the CPUID feature bit numbers which need
to be checked whether a feature is available on a CPU or not. So far the
feature numbers have been linear, but AMX will create a gap which the
current code cannot handle.

Make the table entries explicitly indexed and adjust the loop code
accordingly to prepare for that.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-20-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index db0bfc2..e3d1898 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -53,18 +53,18 @@ static const char *xfeature_names[] =
 	"unknown xstate feature"	,
 };
 
-static short xsave_cpuid_features[] __initdata = {
-	X86_FEATURE_FPU,
-	X86_FEATURE_XMM,
-	X86_FEATURE_AVX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_INTEL_PT,
-	X86_FEATURE_PKU,
-	X86_FEATURE_ENQCMD,
+static unsigned short xsave_cpuid_features[] __initdata = {
+	[XFEATURE_FP]				= X86_FEATURE_FPU,
+	[XFEATURE_SSE]				= X86_FEATURE_XMM,
+	[XFEATURE_YMM]				= X86_FEATURE_AVX,
+	[XFEATURE_BNDREGS]			= X86_FEATURE_MPX,
+	[XFEATURE_BNDCSR]			= X86_FEATURE_MPX,
+	[XFEATURE_OPMASK]			= X86_FEATURE_AVX512F,
+	[XFEATURE_ZMM_Hi256]			= X86_FEATURE_AVX512F,
+	[XFEATURE_Hi16_ZMM]			= X86_FEATURE_AVX512F,
+	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
+	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
+	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
 };
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
@@ -809,7 +809,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
+		unsigned short cid = xsave_cpuid_features[i];
+
+		/* Careful: X86_FEATURE_FPU is 0! */
+		if ((i != XFEATURE_FP && !cid) || !boot_cpu_has(cid))
 			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
 	}
 
