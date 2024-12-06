Return-Path: <linux-tip-commits+bounces-3015-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232859E78A5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 20:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FA71678BF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AA203D4D;
	Fri,  6 Dec 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIOIFhjg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdHyNlcl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F51FD7BF;
	Fri,  6 Dec 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512363; cv=none; b=mpvSo7QAbsFhivsL1ck2CSfK7IOXznsu7lk7+GWDpscVWXvRyWMuKFauAppIfYBCL0SPqEgpUaYokK28D+t9GuXio26UdW2GKI4SG2SU5oC1hW7BZax56RAdbtlzbwMcAIR+C7YDvhOAQy3+HmBxvhL2GBe4rAoiDCMshNqs7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512363; c=relaxed/simple;
	bh=MsseRD0PrfFXUtmNMY+wzIVpzNHYj2Wotpj6Zf0fnAk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N4UD1g9H7yFoQxsHogDvFz/wXKvcSEU8IUHPimhjF1WYcGMoYkvw2mDeDVo0OFBbW1kNvjF8MS6X4J8XhHJJC8m38lIkDhddXlOmbclqEv+WhB6tslyJFFUdAxfQtsm/6IVENmXO/qssA0+nqfv4iP//zV5ESYa2wRzuPDyxCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIOIFhjg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdHyNlcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 19:12:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733512359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTwLRYn1xlN0xwQtn9ib93W3IjHn8f8J/06Hm1XFyBA=;
	b=vIOIFhjgY/hZ4LqUnOD56OZWHCWi2V46r6yoo3VXzxyChHnV30WOPTgyTZMz2ytxkUd1A6
	SSffaLOBuHI7pDv5Svs2a+1aXymGU3U+tI2gj6QG7Q/FcG1IrSRxx1s+m/+DLEvUuHZmG+
	A/Q9q/r7ekoDDxf0+AMOJQO5UA4ptnEyoYVPxw2lpO8dKruHBI00+hj95DP4QkR3dAcZr8
	goWzYnu7uDeDaz2r5RUIlYjeDRxSdFPJdpTfyFxVWQ1cFRffXAzCIp8iPZZa2EOjLbKSnj
	h856oau8NVnINZgKLFGbm5zkuZAer+chirLfOYnVzsaD96W5KYlvAY/lEmRmuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733512359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTwLRYn1xlN0xwQtn9ib93W3IjHn8f8J/06Hm1XFyBA=;
	b=vdHyNlclIhhRdOklXFuXVxAeM1D/wxT7cLJtkjp9JzhPiQH1GDMlmItvkf4Cm6xaDTE8ok
	rdsUa2PjEDLoPjAA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mtrr: Rename mtrr_overwrite_state() to
 guest_force_mtrr_state()
Cc: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241202073139.448208-1-kirill.shutemov@linux.intel.com>
References: <20241202073139.448208-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173351235815.412.5345648297797036518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     dd4059634dab548c904eeae2660ba3c8f7ce843c
Gitweb:        https://git.kernel.org/tip/dd4059634dab548c904eeae2660ba3c8f7ce843c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 02 Dec 2024 09:31:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 20:06:52 +01:00

x86/mtrr: Rename mtrr_overwrite_state() to guest_force_mtrr_state()

Rename the helper to better reflect its function.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20241202073139.448208-1-kirill.shutemov@linux.intel.com
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

