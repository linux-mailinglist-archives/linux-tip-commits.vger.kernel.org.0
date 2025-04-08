Return-Path: <linux-tip-commits+bounces-4776-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A00A81714
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FDB4E20E6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D854A188A0E;
	Tue,  8 Apr 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHjqO6Pm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9UGv4goT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A32AE86;
	Tue,  8 Apr 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145166; cv=none; b=tMCIdqFagF4Tna0kMuUyTNSoLAuEGInC9iKArVom8zwxE9uQu7LZ2xhTY+yRF2scXy/FJYh8yRXL2yfZ8WMJHq8Q/YXHGN/N0uw+sEebfhuujOa9v04LNOL1YY6/F33VOyInxAvrXXcYqbYKkB+ovR4/r2+Ztl5e7j8Wd6+geKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145166; c=relaxed/simple;
	bh=BGn19BNZNaod4cVdTZOMUKKliOPbXHKLsOjaavarhzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=maLryQnWduFCNHrZEAYne6j7Y4utepwoLsLUapYMlAjLBAZr9SKzHTwc2iALd5otBRYrhu9WWxPay1K/ky01uNzaF3JggLe/Qx1AEyxjqRQj7tDVuzmlt3P1X6ujAe+u4AelILKVPocKZbPfqjsGglqnxpwYmP6qYdh+0jp1y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHjqO6Pm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9UGv4goT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 20:45:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744145160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOlUqtV6zzR2sS24S2cBRoEY5VIl1D1KZLAfo9l7wa4=;
	b=dHjqO6PmXUv3qulFTJL6ZbKHi2jZI5yyS52P7jx5IkE8EOGV0jZxegrGPw9K5JQ7L3hPE9
	D7GDBVaM6MFmvwPNWD4xoHT0PJ3L/UJPNW3iF/8KctpPH60gHieJYCqm5mHAn05KtSNg1U
	4f7te9G5WtQjf5anXpf2Y97JSb3tm8ye/k3a3Z6Od7xIi7YAkoQLmYjlM8zOwWUh3FlVyA
	YRSavJCKduLuV/rwm2IL31tkxN68G1R1bZhHnE3A+9CZI7rq+0nXK2XNfz2WcHpCJk1EqZ
	fnL45Rv3DYM/ofuDd+YeFNSz0saqnVM6EKGzAl/BRPzm8M0obJgK3I7e5hb/Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744145160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOlUqtV6zzR2sS24S2cBRoEY5VIl1D1KZLAfo9l7wa4=;
	b=9UGv4goTb4B2cnubmIqzRUwbGFEjUkK698vAfO7xdnVcu27i1QoAxoZnhVG/PTT96blopb
	UW2yu1lmosEuOTDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Remove ANNOTATE_IGNORE_ALTERNATIVE
 from CLAC/STAC
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <fc972ba4995d826fcfb8d02733a14be8d670900b.1744098446.git.jpoimboe@kernel.org>
References:
 <fc972ba4995d826fcfb8d02733a14be8d670900b.1744098446.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174414515158.31282.6804487200090840468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2d12c6fb78753925f494ca9079e2383529e8ae0e
Gitweb:        https://git.kernel.org/tip/2d12c6fb78753925f494ca9079e2383529e8ae0e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 01:21:14 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Apr 2025 22:03:51 +02:00

objtool: Remove ANNOTATE_IGNORE_ALTERNATIVE from CLAC/STAC

ANNOTATE_IGNORE_ALTERNATIVE adds additional noise to the code generated
by CLAC/STAC alternatives, hurting readability for those whose read
uaccess-related code generation on a regular basis.

Remove the annotation specifically for the "NOP patched with CLAC/STAC"
case in favor of a manual check.

Leave the other uses of that annotation in place as they're less common
and more difficult to detect.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/fc972ba4995d826fcfb8d02733a14be8d670900b.1744098446.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/smap.h | 12 ++++++------
 tools/objtool/check.c       | 30 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 55a5e65..4f84d42 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -16,23 +16,23 @@
 #ifdef __ASSEMBLER__
 
 #define ASM_CLAC \
-	ALTERNATIVE __stringify(ANNOTATE_IGNORE_ALTERNATIVE), "clac", X86_FEATURE_SMAP
+	ALTERNATIVE "", "clac", X86_FEATURE_SMAP
 
 #define ASM_STAC \
-	ALTERNATIVE __stringify(ANNOTATE_IGNORE_ALTERNATIVE), "stac", X86_FEATURE_SMAP
+	ALTERNATIVE "", "stac", X86_FEATURE_SMAP
 
 #else /* __ASSEMBLER__ */
 
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative(ANNOTATE_IGNORE_ALTERNATIVE "", "clac", X86_FEATURE_SMAP);
+	alternative("", "clac", X86_FEATURE_SMAP);
 }
 
 static __always_inline void stac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative(ANNOTATE_IGNORE_ALTERNATIVE "", "stac", X86_FEATURE_SMAP);
+	alternative("", "stac", X86_FEATURE_SMAP);
 }
 
 static __always_inline unsigned long smap_save(void)
@@ -59,9 +59,9 @@ static __always_inline void smap_restore(unsigned long flags)
 
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
-	ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "", "clac", X86_FEATURE_SMAP)
+	ALTERNATIVE("", "clac", X86_FEATURE_SMAP)
 #define ASM_STAC \
-	ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "", "stac", X86_FEATURE_SMAP)
+	ALTERNATIVE("", "stac", X86_FEATURE_SMAP)
 
 #define ASM_CLAC_UNSAFE \
 	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "clac", X86_FEATURE_SMAP)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 69f94bc..b649049 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3505,6 +3505,34 @@ next_orig:
 	return next_insn_same_sec(file, alt_group->orig_group->last_insn);
 }
 
+static bool skip_alt_group(struct instruction *insn)
+{
+	struct instruction *alt_insn = insn->alts ? insn->alts->insn : NULL;
+
+	/* ANNOTATE_IGNORE_ALTERNATIVE */
+	if (insn->alt_group && insn->alt_group->ignore)
+		return true;
+
+	/*
+	 * For NOP patched with CLAC/STAC, only follow the latter to avoid
+	 * impossible code paths combining patched CLAC with unpatched STAC
+	 * or vice versa.
+	 *
+	 * ANNOTATE_IGNORE_ALTERNATIVE could have been used here, but Linus
+	 * requested not to do that to avoid hurting .s file readability
+	 * around CLAC/STAC alternative sites.
+	 */
+
+	if (!alt_insn)
+		return false;
+
+	/* Don't override ASM_{CLAC,STAC}_UNSAFE */
+	if (alt_insn->alt_group && alt_insn->alt_group->ignore)
+		return false;
+
+	return alt_insn->type == INSN_CLAC || alt_insn->type == INSN_STAC;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3625,7 +3653,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			}
 		}
 
-		if (insn->alt_group && insn->alt_group->ignore)
+		if (skip_alt_group(insn))
 			return 0;
 
 		if (handle_insn_ops(insn, next_insn, &state))

