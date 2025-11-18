Return-Path: <linux-tip-commits+bounces-7399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7FC6B701
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 39F94292A6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99082EDD62;
	Tue, 18 Nov 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/9qE/Jw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNx4HzMx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297B2E8B6C;
	Tue, 18 Nov 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494124; cv=none; b=WLstATs/+8ZUoH3FMruis60hAnHc3laHRl8bbJw5d7G4UogWIb8muDUqCgVOiSnCxjd5AKoCJecCpVr0htNNwrg671xUSqRNUXxs0yMdtbKiE3cLsvdoVz/Z5S60oHGzYgoYI8TpUzOz/rB2P1jKZZqa7/62cjyLhCBahoZtdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494124; c=relaxed/simple;
	bh=TfxC71Z66YETSnsZ8+QOpzYjFHkZVneQClVaRaZTZV8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=R6a7+LFpXFzkLFpolICiEDr6CSIhNlYaVhjf3MgMFNvYmlT2bNWBLFUsGTBjRVC0rpxOHyosw/RGkgHQ9sPxH+qxalXla/HMtDxavbnu7/FTJ8RAdeCtoysL5igU8sQq3IxQWQhR9TIFgR6hmN2xOtz6eRWp5b8+EWk6X7sMVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/9qE/Jw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNx4HzMx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=y+IWZuOxi2eiLmC8zL+m5BMUHP5yb73OmcJAmIdIx/k=;
	b=Y/9qE/Jw8vWm6e1qfRjnCPQz2QGT9sIQxid3Bj3jxcMPg/1j3G96j9t6ceufcilhpEfm9Q
	IvT6T0FWQhRQDmIJ9OMLWlIj4/vOwf4zeRFh7kqv0wqB6QzEvX/cAgAsy8BccptyfYXe8l
	NL6fXZDj8U9UA9VB+z62S8i8Y+om6CTf9rYLnmF+XvkC3qOe6+2I1/xbMWnn2Hqkw2MsVd
	ZzL+SERGYTY0F5x3MZjr5Bx+M8enqURs53Q4sOtnAjoc9FqWrsg8zeX62JJ3BYR0lYFrI8
	McyjigARvzSmLBXPPIs93MiKFuESDnXCdSQQByReEtheuxqNqNk/alK9+Ec7Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=y+IWZuOxi2eiLmC8zL+m5BMUHP5yb73OmcJAmIdIx/k=;
	b=VNx4HzMx422fw3vk3sx/1AEXGozCYBRTv/jK/WPc9ZVRjEruLU1TSfSN1iIT5e69bsxee8
	ZjkHagFvTXP4bnAw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/alternatives: Disable LASS when patching kernel code
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349412038.498.13802521902299845588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b3a7e973abe6fe3b56adb39be52a4bdaefe14b65
Gitweb:        https://git.kernel.org/tip/b3a7e973abe6fe3b56adb39be52a4bdaefe=
14b65
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:06 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

x86/alternatives: Disable LASS when patching kernel code

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. LASS blocks these accesses because its
enforcement relies on bit 63 of the virtual address as opposed to SMAP
which depends on the _PAGE_BIT_USER bit in the page table. Disable LASS
enforcement by toggling the RFLAGS.AC bit during patching to avoid
triggering a #GP fault.

Introduce LASS-specific STAC/CLAC helpers to set the AC bit only on
platforms that need it. Name the wrappers as lass_stac()/_clac() instead
of lass_disable()/_enable() because they only control the kernel data
access enforcement. The entire LASS mechanism (including instruction
fetch enforcement) is controlled by the CR4.LASS bit.

Describe the usage of the new helpers in comparison to the ones used for
SMAP. Also, add comments to explain when the existing stac()/clac()
should be used. While at it, move the duplicated "barrier" comment to
the same block.

The Text poking functions use standard memcpy()/memset() while patching
kernel code. However, objtool complains about calling such dynamic
functions within an AC=3D1 region. See warning #9, regarding function
calls with UACCESS enabled, in tools/objtool/Documentation/objtool.txt.

To pacify objtool, one option is to add memcpy() and memset() to the
list of allowed-functions. However, that would provide a blanket
exemption for all usages of memcpy() and memset(). Instead, replace the
standard calls in the text poking functions with their unoptimized,
always-inlined versions. Considering that patching is usually small,
there is no performance impact expected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-5-sohil.mehta%40intel.c=
om
---
 arch/x86/include/asm/smap.h   | 41 ++++++++++++++++++++++++++++++++--
 arch/x86/kernel/alternative.c | 18 +++++++++++++--
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d42..20a3baa 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,55 @@
=20
 #else /* __ASSEMBLER__ */
=20
+/*
+ * The CLAC/STAC instructions toggle the enforcement of
+ * X86_FEATURE_SMAP along with X86_FEATURE_LASS.
+ *
+ * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page
+ * tables. The kernel is not allowed to touch pages with that bit set
+ * unless the AC bit is set.
+ *
+ * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
+ * regardless of location.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
 static __always_inline void clac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "clac", X86_FEATURE_SMAP);
 }
=20
 static __always_inline void stac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "stac", X86_FEATURE_SMAP);
 }
=20
+/*
+ * LASS enforcement is based on bit 63 of the virtual address. The
+ * kernel is not allowed to touch memory in the lower half of the
+ * virtual address space.
+ *
+ * Use lass_stac()/lass_clac() to toggle the AC bit for kernel data
+ * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP.
+ *
+ * Even with the AC bit set, LASS will continue to block instruction
+ * fetches from the user half of the address space. To allow those,
+ * clear CR4.LASS to disable the LASS mechanism entirely.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
+static __always_inline void lass_clac(void)
+{
+	alternative("", "clac", X86_FEATURE_LASS);
+}
+
+static __always_inline void lass_stac(void)
+{
+	alternative("", "stac", X86_FEATURE_LASS);
+}
+
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff5..5b09f89 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2469,16 +2469,30 @@ void __init_or_module text_poke_early(void *addr, con=
st void *opcode,
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
=20
+/*
+ * Text poking creates and uses a mapping in the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking
+ * address.
+ *
+ * objtool enforces a strict policy of "no function calls within AC=3D1
+ * regions". Adhere to the policy by using inline versions of
+ * memcpy()/memset() that will never result in a function call.
+ */
+
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	lass_stac();
+	__inline_memcpy(dst, src, len);
+	lass_clac();
 }
=20
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c =3D *(const int *)src;
=20
-	memset(dst, c, len);
+	lass_stac();
+	__inline_memset(dst, c, len);
+	lass_clac();
 }
=20
 typedef void text_poke_f(void *dst, const void *src, size_t len);

