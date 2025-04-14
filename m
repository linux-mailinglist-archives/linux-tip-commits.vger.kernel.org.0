Return-Path: <linux-tip-commits+bounces-4966-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753CA878E8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3D6167C08
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9CA25DD0A;
	Mon, 14 Apr 2025 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aee6hvOF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGjZZEQJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254E25D1FE;
	Mon, 14 Apr 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616096; cv=none; b=c1B2sM8yspnafpN9pr1JaXR5zVczMCHXgxyn5VFyDCdOXiRK4sL2vevlr2rHCFP5Q528Ch0ovrffKT7DZF1koCKhxbuYYpVvUnAHiVjef38TcBcBr+ORroBKGrvoaCiIgPVlVm8EwBlIBFW5ZtTVi9FheOm56b6sz/46zg9ASo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616096; c=relaxed/simple;
	bh=BlB4hX5gZAEo3PhYQrDc3bOYaSKp/evcKwZsnjCvipQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tRO6laMHSZMMsc7OuenmypOLnG1lBvEfOi5AGJj29CBjIXsyCxAPIFWar56rm9xnovV97dnAy9YN8WIXLIS0mi7YGgfVK66jfHJZjsJq28GKPC8qIXgNH7yBQ+EuJR9RBZxqQFgcANFRqNYPZmZMJHk1gRbAu4ei12oA4A17m4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aee6hvOF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGjZZEQJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP+ub7AafzJoQw5b3j83nCyw03f9xvgTij3wFYu/+4=;
	b=Aee6hvOFFKHDa0UQvh1lTQD9OU1yYardyRenT+IXAzcu75zJ/fIEUghx6dA5psd1AFf5m8
	xsRmOCb+Gwp0aTjF/nWVmscQxQeLqprcLPUBPvOB8KmAS+eOg5nox3c6unnn6ImA1fN+th
	KP30Qx7dgOSU9knjRtbnJ4Xev9NptvJOTSL4gvGp0l53DDuZJcN/az9lq4h30UGjRe6zSm
	D6IyX1VJjLhJwBD/GW9lKrq1vi9J3TOV5jw/Ei8gPvcNJdpP+OyRU6G8ggi8K3+wz8yk3A
	Cyy3kSGV1BIVbYEYCnB4JbbHj0o3mREoi3lBCbw5tK9EMFSKaY8m+/wJnGpkWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aP+ub7AafzJoQw5b3j83nCyw03f9xvgTij3wFYu/+4=;
	b=bGjZZEQJi20eJAl8TnGpsEMtdLhOQM39Vl2S29D1MLYGshY1Bi9D/KJcQtpmcURehiZFLT
	RuGNS8BKtRO+foCw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu/xstate: Introduce xfeature order table and
 accessor macro
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320234301.8342-3-chang.seok.bae@intel.com>
References: <20250320234301.8342-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461609267.31282.13761304195938367317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     15d51a2f6f3f7057311d6e37d5190d58597a94a9
Gitweb:        https://git.kernel.org/tip/15d51a2f6f3f7057311d6e37d5190d58597=
a94a9
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 20 Mar 2025 16:42:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu/xstate: Introduce xfeature order table and accessor macro

The kernel has largely assumed that higher xstate component numbers
correspond to later offsets in the buffer. However, this assumption no
longer holds for the non-compacted format, where a newer state component
may have a lower offset.

When iterating over xstate components in offset order, using the feature
number as an index may be misleading. At the same time, the CPU exposes
each component=E2=80=99s size and offset based on its feature number, making =
it a
key for state information.

To provide flexibility in handling xstate ordering, introduce a mapping
table: feature order -> feature number.  The table is dynamically
populated based on the CPU-exposed features and is sorted in offset order
at boot time.

Additionally, add an accessor macro to facilitate sequential traversal of
xstate components based on their actual buffer positions, given a feature
bitmask. This accessor macro will be particularly useful for computing
custom non-compacted format sizes and iterating over xstate offsets in
non-compacted buffers.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250320234301.8342-3-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 58 ++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 542c698..1e22103 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -14,6 +14,7 @@
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/coredump.h>
+#include <linux/sort.h>
=20
 #include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
@@ -88,6 +89,31 @@ static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_=
init =3D
 	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
 static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
=20
+/*
+ * Ordering of xstate components in uncompacted format:  The xfeature
+ * number does not necessarily indicate its position in the XSAVE buffer.
+ * This array defines the traversal order of xstate features.
+ */
+static unsigned int xfeature_uncompact_order[XFEATURE_MAX] __ro_after_init =
=3D
+	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
+
+static inline unsigned int next_xfeature_order(unsigned int i, u64 mask)
+{
+	for (; xfeature_uncompact_order[i] !=3D -1; i++) {
+		if (mask & BIT_ULL(xfeature_uncompact_order[i]))
+			break;
+	}
+
+	return i;
+}
+
+/* Iterate xstate features in uncompacted order: */
+#define for_each_extended_xfeature_in_order(i, mask)	\
+	for (i =3D 0;					\
+	     i =3D next_xfeature_order(i, mask),		\
+	     xfeature_uncompact_order[i] !=3D -1;		\
+	     i++)
+
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
 #define XSTATE_FLAG_ALIGNED64	BIT(1)
=20
@@ -209,13 +235,20 @@ static bool xfeature_enabled(enum xfeature xfeature)
 	return fpu_kernel_cfg.max_features & BIT_ULL(xfeature);
 }
=20
+static int compare_xstate_offsets(const void *xfeature1, const void *xfeatur=
e2)
+{
+	return  xstate_offsets[*(unsigned int *)xfeature1] -
+		xstate_offsets[*(unsigned int *)xfeature2];
+}
+
 /*
  * Record the offsets and sizes of various xstates contained
- * in the XSAVE state memory layout.
+ * in the XSAVE state memory layout. Also, create an ordered
+ * list of xfeatures for handling out-of-order offsets.
  */
 static void __init setup_xstate_cache(void)
 {
-	u32 eax, ebx, ecx, edx, i;
+	u32 eax, ebx, ecx, edx, xfeature, i =3D 0;
 	/*
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
@@ -229,21 +262,30 @@ static void __init setup_xstate_cache(void)
 	xstate_sizes[XFEATURE_SSE]	=3D sizeof_field(struct fxregs_state,
 						       xmm_space);
=20
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		cpuid_count(CPUID_LEAF_XSTATE, i, &eax, &ebx, &ecx, &edx);
+	for_each_extended_xfeature(xfeature, fpu_kernel_cfg.max_features) {
+		cpuid_count(CPUID_LEAF_XSTATE, xfeature, &eax, &ebx, &ecx, &edx);
=20
-		xstate_sizes[i] =3D eax;
-		xstate_flags[i] =3D ecx;
+		xstate_sizes[xfeature] =3D eax;
+		xstate_flags[xfeature] =3D ecx;
=20
 		/*
 		 * If an xfeature is supervisor state, the offset in EBX is
 		 * invalid, leave it to -1.
 		 */
-		if (xfeature_is_supervisor(i))
+		if (xfeature_is_supervisor(xfeature))
 			continue;
=20
-		xstate_offsets[i] =3D ebx;
+		xstate_offsets[xfeature] =3D ebx;
+
+		/* Populate the list of xfeatures before sorting */
+		xfeature_uncompact_order[i++] =3D xfeature;
 	}
+
+	/*
+	 * Sort xfeatures by their offsets to support out-of-order
+	 * offsets in the uncompacted format.
+	 */
+	sort(xfeature_uncompact_order, i, sizeof(unsigned int), compare_xstate_offs=
ets, NULL);
 }
=20
 /*

