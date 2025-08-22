Return-Path: <linux-tip-commits+bounces-6310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C173B31A4F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B71888E61
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C003302CD8;
	Fri, 22 Aug 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZoovnXqi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AwV7GHi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D121B8F5;
	Fri, 22 Aug 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870831; cv=none; b=HCLz01Y+j17JuRAZXV19b/Txn8tTnDG4DzGAkkCVFTIpJ//7nHXjXlFHvfYoxeOLr/raydd0GAd6xJIDadDGRD03jCLO8ZjI9nCIetQCk3bk6PYA0Xv7jefo2GkrNu6/dEwBAwVELd6lzFQW247x9mjBfmNIX+/T8bdbJpZFQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870831; c=relaxed/simple;
	bh=lQnCEomINcmRwqFVrSFkbJFiEN2HEFfkl3EyOM0zHyA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Az9KodLuAqn25zjz3QvrjEbPqtrB4FW0mo/e/K5lrpY2tFYcHQCFEp8jyW28cVNrmZPmKWQQbgItIESY2/Qfe98AiB/rOqu35OOaHTucS4gZEt39wD6qs3IcwXTA8rKEgmy0pT7Ez0rG1R5GbYRuuEdLBXhtGM8jVkZIxII1E3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZoovnXqi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AwV7GHi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 13:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755870826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw9GeRVvudcvzCBIiVnUrrVOxoWIb8HOF0UiilCY8Us=;
	b=ZoovnXqiAJM5kMA8NAx+o0Q4jrsbtAHy8dGmJ271IY+SDoBDiSuDol5FudaQwuIHoHN3oU
	b8jakMdL3MbHMc8FG31FnJ59DoC2OVaFR5U9rpOheLYdhk6UgqcCO6Ab05hE3O1TsBu3pN
	pSz3FAFaXkgLwveUFnB5ewkniEURnaaHXtbLNyoHJvW6SNvxd0igLij6bEVn7rfl8j2bUe
	4Z+z4YChE/LS5hpTESfCX0zYNzWKD/45yH6N0ufpbSPp3teOosKAFv8JmEBgSE0B0eiktv
	2w71VjV+TtZ4sCHqJU5bQx3J+X3kU6wHvxuMFx7wvrbJPld4D3bBog9gxU5S1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755870826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw9GeRVvudcvzCBIiVnUrrVOxoWIb8HOF0UiilCY8Us=;
	b=0AwV7GHiJTp0KQYOTBg2mVl0EZmI4W+Ut9jdyi2z1T1Ow2TtIAtf0zsfRP09aIoQWBceol
	osbuURpqj0j0gRBA==
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
Message-ID: <175587082441.1420.8704991891461178860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     6bca6b9d414c8127350341f193caa11944ce6fa9
Gitweb:        https://git.kernel.org/tip/6bca6b9d414c8127350341f193caa11944c=
e6fa9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 06 Jun 2025 09:55:02 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 22 Aug 2025 15:35:57 +02:00

x86/its: Move ITS indirect branch thunks to .text..__x86.indirect_thunk

The ITS mitigation includes both indirect branch thunks and return
thunks.  Both are currently placed in .text..__x86.return_thunk, which is
appropriate for the latter but not the former.

For consistency with other mitigations, move the indirect branch thunks to
.text..__x86.indirect_thunk.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/67a17ed2fc8d12111e76504c8364b1597657c29a.174922=
8881.git.jpoimboe@kernel.org
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

