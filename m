Return-Path: <linux-tip-commits+bounces-6572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC557B549D6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Sep 2025 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16F31C265F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Sep 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6A2E9756;
	Fri, 12 Sep 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ggu5c7Bw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsMbCTGC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B29283C90;
	Fri, 12 Sep 2025 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673014; cv=none; b=KBF0IpUdfv71cfDC+h0JAhVMUszMTbuJeItHg8Sq4bxsvbwgbKatmlJA61t0KK6eor2U56stjm1pu3rY6pvbfgcvRJVCDNFDtw1Ay6mYmdY/3vPNsv/KvAUofzk7/+fs16dLFqe4sS5+hYh9NBMRv8zGauDs2d9XiEdbdb2GiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673014; c=relaxed/simple;
	bh=DXMVQwajIHGM20w9QwArrqXxPVylrRI4m3vJglLJ+IU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F0LmOEk61ibkZqbrqWvkG8hV1jR5Si1dVnwl0R7lVpeoKuxyCOuJNMLJun0vdeGHoAty9BL5L8XT4azgvFSR1UYp15ZvkwfL0TG+pvcTv8xy218vQ3RNsDtBwUKSRTNfhxmCATdNigzU4fH+JYjGtF4kANtQZ7qTp3qzlRa8s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ggu5c7Bw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsMbCTGC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Sep 2025 10:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757673010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=652ddeVERFvMmExPVijujEXvSlxRd76/CPNI3WLcaMs=;
	b=Ggu5c7Bw9OofEFbLF4tnKZigBESWoYnNB/TIK3jEONffScqlwEuT9xEE1Z/FzmxVFkpfP8
	CjRWXPuvbev3/i5N6kZraW7Y7UlWohEfNsoTwQYe14itlOdvsrRbkYBwulkg2PLXROhzKn
	RN0RtA8Ecw4BtUSd/CfEB5UJ9iVJhNNbsLXlKda0KuZMnamfEbUg3PD+5DZhGxflMqh6K9
	WPqPQjPHHXBGc77yxl1nfwcfOet62f4G0mxolkBqNTmDr7IGJBfMK0H0hZSp6T1NR3uNdt
	fD5Y0XYPh+ZScFi9U4SLEwf6PKYgwHfXdMG1/MlFG6LMbm/wdS9PaLJ5rdzy1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757673010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=652ddeVERFvMmExPVijujEXvSlxRd76/CPNI3WLcaMs=;
	b=vsMbCTGCzznesSNyRJ1dX0hnlxgU8Pk21YBeTBr00Lzq69DddNsinAdkXMo1dg9cmSGyHn
	34vw/Yi4XMbbLGCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/its: Move ITS indirect branch thunks to
 .text..__x86.indirect_thunk
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <67a17ed2fc8d12111e76504c8364b1597657c29a.1749228881.git.jpoimboe@kernel.org>
References:
 <67a17ed2fc8d12111e76504c8364b1597657c29a.1749228881.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175767300880.709179.1206741455136771586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     41bab90bbfdc55228b8697d960839a4abb5016d4
Gitweb:        https://git.kernel.org/tip/41bab90bbfdc55228b8697d960839a4abb5=
016d4
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 06 Jun 2025 09:55:02 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 12 Sep 2025 12:14:54 +02:00

x86/its: Move ITS indirect branch thunks to .text..__x86.indirect_thunk

The ITS mitigation includes both indirect branch thunks and return
thunks.  Both are currently placed in .text..__x86.return_thunk, which is
appropriate for the latter but not the former.

For consistency with other mitigations, move the indirect branch thunks to
.text..__x86.indirect_thunk.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/lib/retpoline.S | 75 ++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d78d769..f513d33 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -15,7 +15,6 @@
=20
 	.section .text..__x86.indirect_thunk
=20
-
 .macro POLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call    .Ldo_rop_\@
@@ -73,6 +72,7 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 #undef GEN
=20
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
+
 .macro CALL_THUNK reg
 	.align RETPOLINE_THUNK_SIZE
=20
@@ -126,7 +126,45 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #define GEN(reg) __EXPORT_THUNK(__x86_indirect_jump_thunk_ ## reg)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
-#endif
+
+#endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
+
+#ifdef CONFIG_MITIGATION_ITS
+
+.macro ITS_THUNK reg
+
+/*
+ * If CFI paranoid is used then the ITS thunk starts with opcodes (0xea; jne=
 1b)
+ * that complete the fineibt_paranoid caller sequence.
+ */
+1:	.byte 0xea
+SYM_INNER_LABEL(__x86_indirect_paranoid_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_UNDEFINED
+	ANNOTATE_NOENDBR
+	jne 1b
+SYM_INNER_LABEL(__x86_indirect_its_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_UNDEFINED
+	ANNOTATE_NOENDBR
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%\reg
+	int3
+	.align 32, 0xcc		/* fill to the end of the line */
+	.skip  32 - (__x86_indirect_its_thunk_\reg - 1b), 0xcc /* skip to the next =
upper half */
+.endm
+
+/* ITS mitigation requires thunks be aligned to upper half of cacheline */
+.align 64, 0xcc
+.skip 29, 0xcc
+
+#define GEN(reg) ITS_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+	.align 64, 0xcc
+SYM_FUNC_ALIAS(__x86_indirect_its_thunk_array, __x86_indirect_its_thunk_rax)
+SYM_CODE_END(__x86_indirect_its_thunk_array)
+
+#endif /* CONFIG_MITIGATION_ITS */
=20
 #ifdef CONFIG_MITIGATION_RETHUNK
=20
@@ -370,39 +408,6 @@ SYM_FUNC_END(call_depth_return_thunk)
=20
 #ifdef CONFIG_MITIGATION_ITS
=20
-.macro ITS_THUNK reg
-
-/*
- * If CFI paranoid is used then the ITS thunk starts with opcodes (0xea; jne=
 1b)
- * that complete the fineibt_paranoid caller sequence.
- */
-1:	.byte 0xea
-SYM_INNER_LABEL(__x86_indirect_paranoid_thunk_\reg, SYM_L_GLOBAL)
-	UNWIND_HINT_UNDEFINED
-	ANNOTATE_NOENDBR
-	jne 1b
-SYM_INNER_LABEL(__x86_indirect_its_thunk_\reg, SYM_L_GLOBAL)
-	UNWIND_HINT_UNDEFINED
-	ANNOTATE_NOENDBR
-	ANNOTATE_RETPOLINE_SAFE
-	jmp *%\reg
-	int3
-	.align 32, 0xcc		/* fill to the end of the line */
-	.skip  32 - (__x86_indirect_its_thunk_\reg - 1b), 0xcc /* skip to the next =
upper half */
-.endm
-
-/* ITS mitigation requires thunks be aligned to upper half of cacheline */
-.align 64, 0xcc
-.skip 29, 0xcc
-
-#define GEN(reg) ITS_THUNK reg
-#include <asm/GEN-for-each-reg.h>
-#undef GEN
-
-	.align 64, 0xcc
-SYM_FUNC_ALIAS(__x86_indirect_its_thunk_array, __x86_indirect_its_thunk_rax)
-SYM_CODE_END(__x86_indirect_its_thunk_array)
-
 .align 64, 0xcc
 .skip 32, 0xcc
 SYM_CODE_START(its_return_thunk)

