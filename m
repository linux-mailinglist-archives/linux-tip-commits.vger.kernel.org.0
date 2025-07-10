Return-Path: <linux-tip-commits+bounces-6067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DBB005A5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91755A386C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB142274FCF;
	Thu, 10 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qT0h2/BA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FSVTv/Po"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC54274665;
	Thu, 10 Jul 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158871; cv=none; b=k/xNQotbMy1TU2GezK2SekfeczKxMUrKrQhK8+D9EhcbARISS+UytV3GA2yNzaeh/4g5sZOgp3vGkEiR+lvg4X1K7+5VXopwOEfA9JnIDmL8h4sPuHIyqsOBatb50QdI1s5IlnFbo6MjxA+yQzUvw1qc4DVtebm3F2jitUMNTj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158871; c=relaxed/simple;
	bh=3RU+YIHQChQrCARB+XKHRWuk0Dau1zrE6q6x1TQzaGI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OmFg3rKajaNOVzM6rHOIW+p1IcDTpvTokQeBnGKbSE7bNTzbr00GzhEn4J5MhMT9EGmWTFb3O3fv3t5wvMAA9KwuSfctFU8Qed7SAs+C1wkkv0/kR0pXZ5rPWEascu3rUYa7t6eZzkDpXLnm/l9ccnTe3sFAXhb4TgNTiGCJExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qT0h2/BA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FSVTv/Po; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 14:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752158868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh/OB2OE6Twj++r88JrNMxzaSRVWTl6veQnxQ9K6akM=;
	b=qT0h2/BANigIiXWt2QnoBEhCsOOd+IpnPraAvaNFpxPCe5NX/Epw1zznn8G6SLAOTp8R3U
	Q0X5Z2t77izcNETThKMeLlqSpJ7JMfJFEgnsEmBh/Nh9ShqecCkUyLm4NXn4X5Oo8S5OuD
	bKwIbeS4Mrg8QT/yLhbLSr/8s0I3RXnBOd0IFhEBwzfxzy6ChB0B6fYZ0ArTN4FnrDU8Mf
	pJcVmE7/uM/1zzyYpymtlr3PucHCRRTEjlH3e8W7oDPJK6QZF/QD9MWF3tVMCn8MN9qqCe
	ZbABTaxjAljkGKeKryKKe0xF/Uu2RssmX9BAGCem31CIb8xaiJApTnfpLrqurg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752158868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh/OB2OE6Twj++r88JrNMxzaSRVWTl6veQnxQ9K6akM=;
	b=FSVTv/PokXau7DRe9JlJyZciC46d/f/pfirX2Qz0YjG5HejneLf92sMaZ4cwNuRn1mbPhN
	93Y2XYrmGJEi0lDA==
From: "tip-bot2 for Kevin Loughlin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/lib: Add WBNOINVD helper functions
Cc: Kevin Loughlin <kevinloughlin@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kai Huang <kai.huang@intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250522233733.3176144-4-seanjc@google.com>
References: <20250522233733.3176144-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215886689.406.5651004432077295222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     07f99c3fbe6e322bdb222fbfd59f708ced799cc5
Gitweb:        https://git.kernel.org/tip/07f99c3fbe6e322bdb222fbfd59f708ced799cc5
Author:        Kevin Loughlin <kevinloughlin@google.com>
AuthorDate:    Thu, 22 May 2025 16:37:27 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Jul 2025 13:23:10 +02:00

x86/lib: Add WBNOINVD helper functions

In line with WBINVD usage, add WBNOINVD helper functions.  Explicitly fall
back to WBINVD (via alternative()) if WBNOINVD isn't supported even though
the instruction itself is backwards compatible (WBNOINVD is WBINVD with an
ignored REP prefix), so that disabling X86_FEATURE_WBNOINVD behaves as one
would expect, e.g. in case there's a hardware issue that affects WBNOINVD.

Opportunistically, add comments explaining the architectural behavior of
WBINVD and WBNOINVD, and provide hints and pointers to uarch-specific
behavior.

Note, alternative() ensures compatibility with early boot code as needed.

  [ bp: Massage, fix typos, make export _GPL. ]

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/20250522233733.3176144-4-seanjc@google.com
---
 arch/x86/include/asm/smp.h           |  6 ++++++-
 arch/x86/include/asm/special_insns.h | 29 ++++++++++++++++++++++++++-
 arch/x86/lib/cache-smp.c             | 11 ++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 028f126..e08f1ae 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -113,6 +113,7 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 void wbinvd_on_all_cpus(void);
+void wbnoinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
 void __noreturn mwait_play_dead(unsigned int eax_hint);
@@ -153,6 +154,11 @@ static inline void wbinvd_on_all_cpus(void)
 	wbinvd();
 }
 
+static inline void wbnoinvd_on_all_cpus(void)
+{
+	wbnoinvd();
+}
+
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index ecda17e..fde2bd7 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -104,9 +104,36 @@ static inline void wrpkru(u32 pkru)
 }
 #endif
 
+/*
+ * Write back all modified lines in all levels of cache associated with this
+ * logical processor to main memory, and then invalidate all caches.  Depending
+ * on the micro-architecture, WBINVD (and WBNOINVD below) may or may not affect
+ * lower level caches associated with another logical processor that shares any
+ * level of this processor's cache hierarchy.
+ */
 static __always_inline void wbinvd(void)
 {
-	asm volatile("wbinvd": : :"memory");
+	asm volatile("wbinvd" : : : "memory");
+}
+
+/* Instruction encoding provided for binutils backwards compatibility. */
+#define ASM_WBNOINVD _ASM_BYTES(0xf3,0x0f,0x09)
+
+/*
+ * Write back all modified lines in all levels of cache associated with this
+ * logical processor to main memory, but do NOT explicitly invalidate caches,
+ * i.e. leave all/most cache lines in the hierarchy in non-modified state.
+ */
+static __always_inline void wbnoinvd(void)
+{
+	/*
+	 * Explicitly encode WBINVD if X86_FEATURE_WBNOINVD is unavailable even
+	 * though WBNOINVD is backwards compatible (it's simply WBINVD with an
+	 * ignored REP prefix), to guarantee that WBNOINVD isn't used if it
+	 * needs to be avoided for any reason.  For all supported usage in the
+	 * kernel, WBINVD is functionally a superset of WBNOINVD.
+	 */
+	alternative("wbinvd", ASM_WBNOINVD, X86_FEATURE_WBNOINVD);
 }
 
 static inline unsigned long __read_cr4(void)
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 079c3f3..74e0d5b 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -19,3 +19,14 @@ void wbinvd_on_all_cpus(void)
 	on_each_cpu(__wbinvd, NULL, 1);
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
+
+static void __wbnoinvd(void *dummy)
+{
+	wbnoinvd();
+}
+
+void wbnoinvd_on_all_cpus(void)
+{
+	on_each_cpu(__wbnoinvd, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(wbnoinvd_on_all_cpus);

