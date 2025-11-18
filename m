Return-Path: <linux-tip-commits+bounces-7402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82AC6B713
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 70B5B292BD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6F2F5A13;
	Tue, 18 Nov 2025 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4qGGwDr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OVCGD4K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D82F0C45;
	Tue, 18 Nov 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494128; cv=none; b=e8g/vRskWV6jty2hyGZ+fdBegyzomyj7jIbTtk0zQRj2OhXIZncgJDXWB0o7D016qy0nbJN16t1rkAGQ749nYqECDoYpBk4cQleETsaJgLxzouWbG3+LEZqRHMQF25KfuQeNS8gnRcrJpDG5xoLvBDPJ3pbo4kHXZW3eaifkzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494128; c=relaxed/simple;
	bh=t7T7VdlqfzsTjczJpbLxbQUGs5n/artWzrnjPOFq1x8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WrWZf2pORQUUs384YDR9FGAAjLB6uk7JIfvhnjzUw/nDQwiWBDPp1f9uNO5P2QpvSjvRZvbysabvG53jtddhtI/FheOrp1R8qwaqnHJk/q5dDXLzzV0S6O0O68mkT+ePcSSlop3NmUU1TnXvsMRaDGMoeUgZ0G4KKlbDp7tuQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4qGGwDr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OVCGD4K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mZsDbh27QRMrR33ha9/mVPB1n2nIaVkop/gIZDVirIQ=;
	b=q4qGGwDrO5vpfmg6lcAlyfizkMLis+kHVtRrUKpriKTiIbWifY/NndsVR0YTXVaKIFS8G7
	Ox/z8Pqvo5hD3AkfxuSX+OO5DIWFKGiDtWeznqyUwaIdZygWeC5Lg018MoXcwxLNBeByNC
	8beXKD0+AeHRj1tIHrmQm9qsBpatq6u6ECsbNjwYG/5B1rwZ5JQlD607I+zBnKFTALIi/I
	JNbZypE9RMbP8LJ/SciBCjouPO1kWrDdrI1rnRxPpKejzVoD+tPz5il2RJsJvdY7AeUjoj
	7E52wYLrNIKiDaU3TY0DjEyC7i8MFgL+lI4e+/O3YB8Nw31Ddrse+KrN5ZCpzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mZsDbh27QRMrR33ha9/mVPB1n2nIaVkop/gIZDVirIQ=;
	b=2OVCGD4Kre1OHLdHSxfIUitqpd+0lpOG3OQ0G6KTGRk+YLKbDtMpwhUfEA1ORf1yExjqpJ
	BgQq+CisuySWheBQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Enumerate the LASS feature bits
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349412339.498.2543524640453621205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7baadd463e147fdcb6d3a091d85e23f89832569c
Gitweb:        https://git.kernel.org/tip/7baadd463e147fdcb6d3a091d85e23f8983=
2569c
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:03 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

x86/cpufeatures: Enumerate the LASS feature bits

Linear Address Space Separation (LASS) is a security feature that
mitigates a class of side-channel attacks relying on speculative access
across the user/kernel boundary.

Privilege mode based access protection already exists today with paging
and features such as SMEP and SMAP. However, to enforce these
protections, the processor must traverse the paging structures in
memory. An attacker can use timing information resulting from this
traversal to determine details about the paging structures, and to
determine the layout of the kernel memory.

LASS provides the same mode-based protections as paging but without
traversing the paging structures. Because the protections are enforced
prior to page-walks, an attacker will not be able to derive paging-based
timing information from the various caching structures such as the TLBs,
mid-level caches, page walker, data caches, etc.

LASS enforcement relies on the kernel implementation to divide the
64-bit virtual address space into two halves:
  Addr[63]=3D0 -> User address space
  Addr[63]=3D1 -> Kernel address space

Any data access or code execution across address spaces typically
results in a #GP fault, with an #SS generated in some rare cases. The
LASS enforcement for kernel data accesses is dependent on CR4.SMAP being
set. The enforcement can be disabled by toggling the RFLAGS.AC bit
similar to SMAP.

Define the CPU feature bits to enumerate LASS. Also, disable the feature
at compile time on 32-bit kernels. Use a direct dependency on X86_32
(instead of !X86_64) to make it easier to combine with similar 32-bit
specific dependencies in the future.

LASS mitigates a class of side-channel speculative attacks, such as
Spectre LAM, described in the paper, "Leaky Address Masking: Exploiting
Unmasked Spectre Gadgets with Noncanonical Address Translation".

Add the "lass" flag to /proc/cpuinfo to indicate that the feature is
supported by hardware and enabled by the kernel. This allows userspace
to determine if the system is secure against such attacks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-2-sohil.mehta%40intel.c=
om
---
 arch/x86/Kconfig.cpufeatures                | 4 ++++
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 250c106..733d5af 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
 	def_bool y
 	depends on !X86_64
=20
+config X86_DISABLED_FEATURE_LASS
+	def_bool y
+	depends on X86_32
+
 config X86_DISABLED_FEATURE_PKU
 	def_bool y
 	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 80b68f4..6f82302 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -314,6 +314,7 @@
 #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions=
 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16=
 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separati=
on */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions=
 */
 #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfM=
on Extension */
 #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/u=
api/asm/processor-flags.h
index f1a4adc..81d0c8b 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -136,6 +136,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LASS_BIT	27 /* enable Linear Address Space Separation suppor=
t */
+#define X86_CR4_LASS		_BITUL(X86_CR4_LASS_BIT)
 #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
 #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
=20

