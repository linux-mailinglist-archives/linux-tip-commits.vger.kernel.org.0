Return-Path: <linux-tip-commits+bounces-5893-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7FAE732E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 01:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA617B191A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30625A2CE;
	Tue, 24 Jun 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUgEN5mm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtmbGx3I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40993219E0;
	Tue, 24 Jun 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807861; cv=none; b=GFIJjaJ63Qb+lovrCppspxPH8vLafCCCUIsqkRk7YnOywNbMWKddueSap6RgSsMZkAtZ9rNW6Xsnw2eS3/qkgucuKAzw+ZNIve82Mu92aIJDhVpv6/bUsKSMhd3fWsO/rt6WAZCgYUZSkYBEYRWpeeQL41iLyraZZTAgO+2QTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807861; c=relaxed/simple;
	bh=GoPi4vGEumlDcv3PAVdoynPjU+EPqy/La5SK/Y4ZmnU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=M9OXT0AV+cFBqtPCX4Yq4/Vn6cbhUcSPecJVIggCkZ/FEt/EdMB70Bcfs0vHgRnemYY5W1xYnpwO84Pz/WvXI6iPAZTMenuQ9Xxoz5FWIsaIzX86+xplimzh51z1LaFsBOQY/jvwFOmatLY59EYGxWO5J4BlOUh1ehfQnllEk8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUgEN5mm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtmbGx3I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 23:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750807857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V2SwbPC4Am6TXDoVkDm+GvdaIVrwpxa/apVoJBNF/q4=;
	b=FUgEN5mmwT919iOEk50XdtL6S7I2zgY5YjyImGhSCeQCLsWcSA/dfQ1Y+/mSkPhAwqASOw
	8nUYyFiiAVXKCHG2hRFyc3A8NBSVJ2dfY7cqiS39awzxjySxdbpHygHXwEMW5PSvgfMyGs
	ac5LX8BKVa51jvOnXtEJQKkl5NtvlKaO++GieHx8sYyx3ondDX7750Kbd3+6Af9I41R15s
	UlsU/Da/znkcdPWU1pwMK3TUpS/rimFYKIWCw8qoPcdnrfYd1F3K5LStF5yfMu9tTMad0E
	dIngAhZ4zmhRxAauqAOSGC8699B42tZxivgpetB3bwWOc4uty68HJlnIZgeBiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750807857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V2SwbPC4Am6TXDoVkDm+GvdaIVrwpxa/apVoJBNF/q4=;
	b=PtmbGx3II32vLSO9PP0N3GlzzIZR1l/Ufl2XxbpV0xqzcUm63UJ7wFxzbn9AAzuMIcZ8DJ
	jhK1NlbBcmbnWaDQ==
From: "tip-bot2 for Yang Weijiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Add CET supervisor xfeature support as
 a guest-only feature
Cc: Yang Weijiang <weijiang.yang@intel.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175080785593.406.10511311854621496131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     8b05b3c988162ca117b3854ae7d497927b415299
Gitweb:        https://git.kernel.org/tip/8b05b3c988162ca117b3854ae7d497927b415299
Author:        Yang Weijiang <weijiang.yang@intel.com>
AuthorDate:    Thu, 22 May 2025 08:10:09 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:46:33 -07:00

x86/fpu/xstate: Add CET supervisor xfeature support as a guest-only feature

== Background ==

CET defines two register states: CET user, which includes user-mode control
registers, and CET supervisor, which consists of shadow-stack pointers for
privilege levels 0-2.

Current kernels disable shadow stacks in kernel mode, making the CET
supervisor state unused and eliminating the need for context switching.

== Problem ==

To virtualize CET for guests, KVM must accurately emulate hardware
behavior. A key challenge arises because there is no CPUID flag to indicate
that shadow stack is supported only in user mode. Therefore, KVM cannot
assume guests will not enable shadow stacks in kernel mode and must
preserve the CET supervisor state of vCPUs.

== Solution ==

An initial proposal to manually save and restore CET supervisor states
using raw RDMSR/WRMSR in KVM was rejected due to performance concerns and
its impact on KVM's ABI. Instead, leveraging the kernel's FPU
infrastructure for context switching was favored [1].

The main question then became whether to enable the CET supervisor state
globally for all processes or restrict it to vCPU processes. This decision
involves a trade-off between a 24-byte XSTATE buffer waste for all non-vCPU
processes and approximately 100 lines of code complexity in the kernel [2].
The agreed approach is to first try this optimal solution [3], i.e.,
restricting the CET supervisor state to guest FPUs only and eliminating
unnecessary space waste.

The guest-only xfeature infrastructure has already been added. Now,
introduce CET supervisor xstate support as the first guest-only feature
to prepare for the upcoming CET virtualization in KVM.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/kvm/ZM1jV3UPL0AMpVDI@google.com/ [1]
Link: https://lore.kernel.org/kvm/1c2fd06e-2e97-4724-80ab-8695aa4334e7@intel.com/ [2]
Link: https://lore.kernel.org/kvm/2597a87b-1248-b8ce-ce60-94074bc67ea4@intel.com/ [3]
Link: https://lore.kernel.org/all/20250522151031.426788-7-chao.gao%40intel.com
---
 arch/x86/include/asm/fpu/types.h  | 14 ++++++++++++--
 arch/x86/include/asm/fpu/xstate.h |  5 ++---
 arch/x86/kernel/fpu/xstate.c      |  5 ++++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 54ba567..93e99d2 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -118,7 +118,7 @@ enum xfeature {
 	XFEATURE_PKRU,
 	XFEATURE_PASID,
 	XFEATURE_CET_USER,
-	XFEATURE_CET_KERNEL_UNUSED,
+	XFEATURE_CET_KERNEL,
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
@@ -142,7 +142,7 @@ enum xfeature {
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
 #define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
-#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL_UNUSED)
+#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 #define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
 #define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
@@ -269,6 +269,16 @@ struct cet_user_state {
 };
 
 /*
+ * State component 12 is Control-flow Enforcement supervisor states.
+ * This state includes SSP pointers for privilege levels 0 through 2.
+ */
+struct cet_supervisor_state {
+	u64 pl0_ssp;
+	u64 pl1_ssp;
+	u64 pl2_ssp;
+} __packed;
+
+/*
  * State component 15: Architectural LBR configuration state.
  * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
  */
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index a3cd254..7a7dc9d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -47,7 +47,7 @@
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
 /* Supervisor features which are enabled only in guest FPUs */
-#define XFEATURE_MASK_GUEST_SUPERVISOR	0
+#define XFEATURE_MASK_GUEST_SUPERVISOR	XFEATURE_MASK_CET_KERNEL
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
@@ -79,8 +79,7 @@
  * Unsupported supervisor features. When a supervisor feature in this mask is
  * supported in the future, move it to the supported supervisor feature mask.
  */
-#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT | \
-					      XFEATURE_MASK_CET_KERNEL)
+#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d94a5f4..12ed75c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -57,7 +57,7 @@ static const char *xfeature_names[] =
 	"Protection Keys User registers",
 	"PASID state",
 	"Control-flow User registers",
-	"Control-flow Kernel registers (unused)",
+	"Control-flow Kernel registers (KVM only)",
 	"unknown xstate feature",
 	"unknown xstate feature",
 	"unknown xstate feature",
@@ -81,6 +81,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
 	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
 	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
+	[XFEATURE_CET_KERNEL]			= X86_FEATURE_SHSTK,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_APX]				= X86_FEATURE_APX,
@@ -372,6 +373,7 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_BNDCSR |			\
 	 XFEATURE_MASK_PASID |			\
 	 XFEATURE_MASK_CET_USER |		\
+	 XFEATURE_MASK_CET_KERNEL |		\
 	 XFEATURE_MASK_XTILE |			\
 	 XFEATURE_MASK_APX)
 
@@ -573,6 +575,7 @@ static bool __init check_xstate_against_struct(int nr)
 	case XFEATURE_PASID:	  return XCHECK_SZ(sz, nr, struct ia32_pasid_state);
 	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
 	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
+	case XFEATURE_CET_KERNEL: return XCHECK_SZ(sz, nr, struct cet_supervisor_state);
 	case XFEATURE_APX:        return XCHECK_SZ(sz, nr, struct apx_state);
 	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
 	default:

