Return-Path: <linux-tip-commits+bounces-5898-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78164AE733C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 01:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E25A630B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC126D4E1;
	Tue, 24 Jun 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXGshkSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kt2wLFlt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2CA26C387;
	Tue, 24 Jun 2025 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807866; cv=none; b=qSY1cINlg/XtrUJrRkEyK3G0rFzDeETqIEicZUt7yo3fdeqSXHXmFWxbolZRQaWDZz1J9lK3fDxk6iKVb3t11chLXWKjuUboZBVlf9sVpOVv1T5UHbCKiqhN+fUdiHeyvg03gdLUPRkkckjIfcR9OCndZo2nzuJUaaVYi8cIyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807866; c=relaxed/simple;
	bh=QafC5mA9OIeERazoLVuIgRlflPW5pbEU11IEB7bs09M=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LgIpQqfZ3Tbdk/DsIfmaVrk3Y+ynpP3tMLedhX/ExnmHcD1+ALjtDXQ6LD11Q2oC/CDybAD66NWV86mSgMdU0jymql3qcGiLeHhfMxXUkcaidS2iJwsnntD8inEd29Ncdq+VzXIpriZRTeEs1p9mbjwAY6NdfwzvN53252bXhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXGshkSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kt2wLFlt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 23:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750807861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ntOrh/trKQXMHXPChqHzkmvXaUhkHxnTK+rRriucFxQ=;
	b=OXGshkSM/vIzb/9K/zyJHmNfR7eIZQUXFsHGM6W6I+Ri7qrPHRvwHQiXr4Q1hBaeAg0mO8
	ilwxSpJM0wjZlPpsqpN9UJoj8Lo4liI4VkClj4eGHd9bsy3Citdkpz2imheyURdhUGdcdd
	1KJLWbpV/Qr06YWrap+vC+JXHM9dCG6zRdCQkWWkr2p/21XQ7te5BoTdbLMIMaR0C9kdGl
	hn6Le5Mtn6k8CCFcCGQN1GY4UCEYji8MrNiX5r88+iPxerehiOBYbGOff1J4UtVmKi485V
	jUj/diDW9awj1UllyMVIAX+tHdUJiiz3YlNmhJnjNAU8moV5HoWfVSlhxrikyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750807861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ntOrh/trKQXMHXPChqHzkmvXaUhkHxnTK+rRriucFxQ=;
	b=kt2wLFlt/T8lB6zHrw9ljAAkie8VRIXApHbem9vnBHUbajzVQ0ubYBVxO08zTWUGBU6sPY
	9aZuAzCMUyMvysBg==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Differentiate default features for
 host and guest FPUs
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Sean Christopherson <seanjc@google.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, John Allen <john.allen@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175080786079.406.9724622795864506479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7bc4ed75f2d664c5a96d1f0874c41431a84c62b2
Gitweb:        https://git.kernel.org/tip/7bc4ed75f2d664c5a96d1f0874c41431a84c62b2
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Thu, 22 May 2025 08:10:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:46:32 -07:00

x86/fpu/xstate: Differentiate default features for host and guest FPUs

Currently, guest and host FPUs share the same default features. However,
the CET supervisor xstate is the first feature that needs to be enabled
exclusively for guest FPUs. Enabling it for host FPUs leads to a waste of
24 bytes in the XSAVE buffer.

To support "guest-only" features, add a new structure to hold the
default features and sizes for guest FPUs to clearly differentiate them
from those for host FPUs.

Add two helpers to provide the default feature masks for guest and host
FPUs. Default features are derived by applying the masks to the maximum
supported features.

Note that,
1) for now, guest_default_mask() and host_default_mask() are identical.
This will change in a follow-up patch once guest permissions, default
xfeatures, and fpstate size are all converted to use the guest defaults.

2) only supervisor features will diverge between guest FPUs and host
FPUs, while user features will remain the same [1][2]. So, the new
vcpu_fpu_config struct does not include default user features and size
for the UABI buffer.

An alternative approach is adding a guest_only_xfeatures member to
fpu_kernel_cfg and adding two helper functions to calculate the guest
default xfeatures and size. However, calculating these defaults at runtime
would introduce unnecessary overhead.

Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/kvm/aAwdQ759Y6V7SGhv@google.com/ [1]
Link: https://lore.kernel.org/kvm/9ca17e1169805f35168eb722734fbf3579187886.camel@intel.com/ [2]
Link: https://lore.kernel.org/all/20250522151031.426788-2-chao.gao%40intel.com
---
 arch/x86/include/asm/fpu/types.h | 26 +++++++++++++++++++++++++-
 arch/x86/kernel/fpu/core.c       |  1 +-
 arch/x86/kernel/fpu/init.c       |  1 +-
 arch/x86/kernel/fpu/xstate.c     | 32 +++++++++++++++++++++++++------
 4 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 1c94121..abd193a 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -552,6 +552,31 @@ struct fpu_guest {
 };
 
 /*
+ * FPU state configuration data for fpu_guest.
+ * Initialized at boot time. Read only after init.
+ */
+struct vcpu_fpu_config {
+	/*
+	 * @size:
+	 *
+	 * The default size of the register state buffer in guest FPUs.
+	 * Includes all supported features except independent managed
+	 * features and features which have to be requested by user space
+	 * before usage.
+	 */
+	unsigned int size;
+
+	/*
+	 * @features:
+	 *
+	 * The default supported features bitmap in guest FPUs. Does not
+	 * include independent managed features and features which have to
+	 * be requested by user space before usage.
+	 */
+	u64 features;
+};
+
+/*
  * FPU state configuration data. Initialized at boot time. Read only after init.
  */
 struct fpu_state_config {
@@ -606,5 +631,6 @@ struct fpu_state_config {
 
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
+extern struct vcpu_fpu_config guest_default_cfg;
 
 #endif /* _ASM_X86_FPU_TYPES_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea13858..aa72523 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -37,6 +37,7 @@ DEFINE_PER_CPU(u64, xfd_state);
 /* The FPU state configuration data for kernel and user space */
 struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
 struct fpu_state_config fpu_user_cfg __ro_after_init;
+struct vcpu_fpu_config guest_default_cfg __ro_after_init;
 
 /*
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 99db41b..ff988b9 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -205,6 +205,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
+	guest_default_cfg.size = size;
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8..7c5f9f1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -743,6 +743,9 @@ static int __init init_xstate_size(void)
 	fpu_user_cfg.default_size =
 		xstate_calculate_size(fpu_user_cfg.default_features, false);
 
+	guest_default_cfg.size =
+		xstate_calculate_size(guest_default_cfg.features, compacted);
+
 	return 0;
 }
 
@@ -763,6 +766,7 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	fpu_kernel_cfg.default_size = legacy_size;
 	fpu_user_cfg.max_size = legacy_size;
 	fpu_user_cfg.default_size = legacy_size;
+	guest_default_cfg.size = legacy_size;
 
 	/*
 	 * Prevent enabling the static branch which enables writes to the
@@ -773,6 +777,21 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	fpstate_reset(x86_task_fpu(current));
 }
 
+static u64 __init host_default_mask(void)
+{
+	/* Exclude dynamic features, which require userspace opt-in. */
+	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
+}
+
+static u64 __init guest_default_mask(void)
+{
+	/*
+	 * Exclude dynamic features, which require userspace opt-in even
+	 * for KVM guests.
+	 */
+	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
+}
+
 /*
  * Enable and initialize the xsave feature.
  * Called once per system bootup.
@@ -855,12 +874,13 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	fpu_user_cfg.max_features = fpu_kernel_cfg.max_features;
 	fpu_user_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;
 
-	/* Clean out dynamic features from default */
-	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
-	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
-
-	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
-	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+	/*
+	 * Now, given maximum feature set, determine default values by
+	 * applying default masks.
+	 */
+	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features & host_default_mask();
+	fpu_user_cfg.default_features   = fpu_user_cfg.max_features & host_default_mask();
+	guest_default_cfg.features      = fpu_kernel_cfg.max_features & guest_default_mask();
 
 	/* Store it for paranoia check at the end */
 	xfeatures = fpu_kernel_cfg.max_features;

