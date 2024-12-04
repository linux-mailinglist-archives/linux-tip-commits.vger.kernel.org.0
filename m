Return-Path: <linux-tip-commits+bounces-2970-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6389E4706
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2024 22:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2522FB2BDBC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD711A8F9A;
	Wed,  4 Dec 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKq1CUVv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p/m9NCOC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273E1C3BE2;
	Wed,  4 Dec 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338806; cv=none; b=NaFUd7puGfSjoIFgwuYLAo2I5aN8C7rFEXoO3IVyCIht3Y+G/BQXNbFHW/oqtfuv1+/3ULtWdgDJ3aTdasuDCBvKB+Xl1rOK8suJ0zThagC9N7V+7O8saCNGdghfVYOSgMxApoS3XqW6mSiJZlXKSKGbzCcGMq9QAUroy48YJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338806; c=relaxed/simple;
	bh=+7APIjw98mEOigcPwjrOzA0AYJLQWpVk11qnxfXuHfw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=C2L38FkSIBvUi4reO6KOUxKv8Um2ZNLTN/oXLm2+033zWMWwqQPtaFN1Oz5RWX67gk5oXb2UuSH31UGfQnmvRX9eaPhafzK8g854AIVaWFeiibKZHW/ZVv3EjBUiSZf81ADZYe4tssaax6+xOxlHuwgpafzTs/87dSjkqNjUEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKq1CUVv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p/m9NCOC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Dec 2024 19:00:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733338803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3pIGPQKLHkLvhD6Iq13KbVseNIPIHGZ/NtfeEfaEMME=;
	b=uKq1CUVv8lGlfgcut2fRCn3zvNKO50Z0zWkPRb4fJGn3u8UlTr2C9wX/c/arx75vb/VaV/
	3C+shKKrXKdb//0V8t7Kt6wXi4K/hXSgaIn+VPxmJDU2ExZN/Ck9RSYAxU6EUhVKYB/qnZ
	J5RcRhs/jplotvOaOVqrfjDm6QOXRGEPauwlwG2uJOGu8sGMUngkCmuWBDMbvIbaBHOFjJ
	WdI2IOmIvK5wlLjL0pGgPI7LTRw9fMzzVgxBjzfHKizyyoHJAC4UYIG+Y/Z1uW6As0Z+8g
	xvQuZIvrPeZuySlfyfiuzrjTUPJIRMNQGl6oGy/GeSqIZTPXb2H1aqdtXO5HKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733338803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3pIGPQKLHkLvhD6Iq13KbVseNIPIHGZ/NtfeEfaEMME=;
	b=p/m9NCOCkOcWwmFR0iypwY+JFZJHGYwI7juC3LkDvipSN3HTrlLR1MxL/xUisZDcKSSoG+
	LnNae/VCJO6o1rCQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mtrr: Rename mtrr_overwrite_state() to
 guest_force_mtrr_state()
Cc: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173333880207.412.8515220180299226143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     6a5abeea9c72e1d2c538622b4cf66c80cc816fd3
Gitweb:        https://git.kernel.org/tip/6a5abeea9c72e1d2c538622b4cf66c80cc816fd3
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 02 Dec 2024 09:31:39 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Dec 2024 10:46:19 -08:00

x86/mtrr: Rename mtrr_overwrite_state() to guest_force_mtrr_state()

Rename the helper to better reflect its function.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/all/20241202073139.448208-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/mtrr.h        | 10 +++++-----
 arch/x86/kernel/cpu/mtrr/generic.c |  6 +++---
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
 arch/x86/kernel/kvm.c              |  2 +-
 arch/x86/xen/enlighten_pv.c        |  4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 60fc3ed..90aabe1 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -664,7 +664,7 @@ void __init hv_vtom_init(void)
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
 
 	/* Set WB as the default cache mode. */
-	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+	guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
 #endif /* defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST) */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 4218248..c69e269 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -58,8 +58,8 @@ struct mtrr_state_type {
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
-void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
-			  mtrr_type def_type);
+void guest_force_mtrr_state(struct mtrr_var_range *var, unsigned int num_var,
+			    mtrr_type def_type);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -75,9 +75,9 @@ void mtrr_disable(void);
 void mtrr_enable(void);
 void mtrr_generic_set_state(void);
 #  else
-static inline void mtrr_overwrite_state(struct mtrr_var_range *var,
-					unsigned int num_var,
-					mtrr_type def_type)
+static inline void guest_force_mtrr_state(struct mtrr_var_range *var,
+					  unsigned int num_var,
+					  mtrr_type def_type)
 {
 }
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 7b29ebd..2fdfda2 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -423,7 +423,7 @@ void __init mtrr_copy_map(void)
 }
 
 /**
- * mtrr_overwrite_state - set static MTRR state
+ * guest_force_mtrr_state - set static MTRR state for a guest
  *
  * Used to set MTRR state via different means (e.g. with data obtained from
  * a hypervisor).
@@ -436,8 +436,8 @@ void __init mtrr_copy_map(void)
  * @num_var: length of the @var array
  * @def_type: default caching type
  */
-void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
-			  mtrr_type def_type)
+void guest_force_mtrr_state(struct mtrr_var_range *var, unsigned int num_var,
+			    mtrr_type def_type)
 {
 	unsigned int i;
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 989d368..ecbda03 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -625,7 +625,7 @@ void mtrr_save_state(void)
 static int __init mtrr_init_finalize(void)
 {
 	/*
-	 * Map might exist if mtrr_overwrite_state() has been called or if
+	 * Map might exist if guest_force_mtrr_state() has been called or if
 	 * mtrr_enabled() returns true.
 	 */
 	mtrr_copy_map();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 21e9e48..7a422a6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -983,7 +983,7 @@ static void __init kvm_init_platform(void)
 	x86_platform.apic_post_init = kvm_apic_init;
 
 	/* Set WB as the default cache mode for SEV-SNP and TDX */
-	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+	guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index d6818c6..633469f 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -171,7 +171,7 @@ static void __init xen_set_mtrr_data(void)
 
 	/* Only overwrite MTRR state if any MTRR could be got from Xen. */
 	if (reg)
-		mtrr_overwrite_state(var, reg, MTRR_TYPE_UNCACHABLE);
+		guest_force_mtrr_state(var, reg, MTRR_TYPE_UNCACHABLE);
 #endif
 }
 
@@ -195,7 +195,7 @@ static void __init xen_pv_init_platform(void)
 	if (xen_initial_domain())
 		xen_set_mtrr_data();
 	else
-		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+		guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
 
 	/* Adjust nr_cpu_ids before "enumeration" happens */
 	xen_smp_count_cpus();

