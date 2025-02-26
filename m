Return-Path: <linux-tip-commits+bounces-3679-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D78A45FCE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1154D3AE75D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEC11E1DFD;
	Wed, 26 Feb 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8kIWi6i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nA/yIeWS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95A258CD1;
	Wed, 26 Feb 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574479; cv=none; b=VO7xmcxKZh2QyrgT0l83Km9AaG15rYGphSgI2oghXPqjYTmhLwzeKuh4GA/4WnPux4KCbO9w8aRA26Ys+0Z+nGWhaRsbKJOYNxWzZb1T+tEXbQ60azGl+Xce7sqyllxFVt5c1mZeU7Z2olBiI7YRGy/OHX6B1PVwpo4kaaw55rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574479; c=relaxed/simple;
	bh=JDKkiSfLHuCyNatFzQjSaB9g8HG0MbsM5nXVveeJHp0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eTb707vK2FG2YPiiIv5TMJ67ILF4tVhEytFVlZw6n5Ky5oajRReOb8D7a3HuZ2OgM+O0BggkHX8Jh7Lr+JZokjEdpiOC+VcOMe/bKiQrrkdPvwGDsDC+GYwczYQojtD9GRxRBI9hQlDwj0VwVE/xAhTfAjOzkaHzxFuTUvy3EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8kIWi6i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nA/yIeWS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740574475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cegxWfMOnhRr75WjAoi+N2y8psFDvw8YU2/P7Mj9j40=;
	b=b8kIWi6iAW3wsDoFDKFBoqYTM/+z8uTY2JTZHB0ynKGBnjKNOYO3Lc1xrKveaYIDAsB86d
	5ubam2Erc1NnVHe5er4k1q7g+xy6gxaP3H7zjXPcF9ohdgfZ9JXZyuhJSJVIXW2cezmQAX
	MRK0q8RcagVy/CyYCJ32mji6zXRQbNkoCQu0osaKuaYJ8SiDzg4/YWLE/AUdto8efA9oPS
	y9MLjPD+jjQU9c+qlsNQYgnbs0LubPFW0gPOyGp2hAggs2TQygbqjFtmF4OFai70BnMZaa
	eKJqw6Sbvo5ZRjZvVPX7AkshUp+m5nH/D1ucw6ho2098sovVwSgyl/P9FPvGFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740574475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cegxWfMOnhRr75WjAoi+N2y8psFDvw8YU2/P7Mj9j40=;
	b=nA/yIeWSV8tqf5wQ5ynPR6ekmU/8jGejWD44YolUo6rCegJRHcwNF874gcwxpvT9gcFG4p
	KDFkYGFSY6PFfmAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Optimize the fineibt-bhi arity 1 case
Cc: Scott Constable <scott.d.constable@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.927885784@infradead.org>
References: <20250224124200.927885784@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057447143.10177.16018462845591323897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     dfebe7362f6f461d771cdb9ac2c5172a4721f064
Gitweb:        https://git.kernel.org/tip/dfebe7362f6f461d771cdb9ac2c5172a4721f064
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:49:11 +01:00

x86/ibt: Optimize the fineibt-bhi arity 1 case

Saves a CALL to an out-of-line thunk for the common case of 1
argument.

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.927885784@infradead.org
---
 arch/x86/include/asm/ibt.h    |  4 ++-
 arch/x86/kernel/alternative.c | 59 ++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index f0ca5c0..9423a29 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -70,6 +70,10 @@ static inline bool __is_endbr(u32 val)
 	if (val == gen_endbr_poison())
 		return true;
 
+	/* See cfi_fineibt_bhi_preamble() */
+	if (IS_ENABLED(CONFIG_FINEIBT_BHI) && val == 0x001f0ff5)
+		return true;
+
 	val &= ~0x01000000U; /* ENDBR32 -> ENDBR64 */
 	return val == gen_endbr();
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b8d65d5..32e4b80 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1311,6 +1311,53 @@ static int cfi_rand_preamble(s32 *start, s32 *end)
 	return 0;
 }
 
+static void cfi_fineibt_bhi_preamble(void *addr, int arity)
+{
+	if (!arity)
+		return;
+
+	if (!cfi_warn && arity == 1) {
+		/*
+		 * Crazy scheme to allow arity-1 inline:
+		 *
+		 * __cfi_foo:
+		 *  0: f3 0f 1e fa             endbr64
+		 *  4: 41 81 <ea> 78 56 34 12  sub     0x12345678, %r10d
+		 *  b: 49 0f 45 fa             cmovne  %r10, %rdi
+		 *  f: 75 f5                   jne     __cfi_foo+6
+		 * 11: 0f 1f 00                nopl    (%rax)
+		 *
+		 * Code that direct calls to foo()+0, decodes the tail end as:
+		 *
+		 * foo:
+		 *  0: f5                      cmc
+		 *  1: 0f 1f 00                nopl    (%rax)
+		 *
+		 * which clobbers CF, but does not affect anything ABI
+		 * wise.
+		 *
+		 * Notably, this scheme is incompatible with permissive CFI
+		 * because the CMOVcc is unconditional and RDI will have been
+		 * clobbered.
+		 */
+		const u8 magic[9] = {
+			0x49, 0x0f, 0x45, 0xfa,
+			0x75, 0xf5,
+			BYTES_NOP3,
+		};
+
+		text_poke_early(addr + fineibt_preamble_bhi, magic, 9);
+
+		return;
+	}
+
+	text_poke_early(addr + fineibt_preamble_bhi,
+			text_gen_insn(CALL_INSN_OPCODE,
+				      addr + fineibt_preamble_bhi,
+				      __bhi_args[arity]),
+			CALL_INSN_SIZE);
+}
+
 static int cfi_rewrite_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
@@ -1341,14 +1388,8 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 			  "kCFI preamble has wrong register at: %pS %*ph\n",
 			  addr, 5, addr);
 
-		if (!cfi_bhi || !arity)
-			continue;
-
-		text_poke_early(addr + fineibt_preamble_bhi,
-				text_gen_insn(CALL_INSN_OPCODE,
-					      addr + fineibt_preamble_bhi,
-					      __bhi_args[arity]),
-				CALL_INSN_SIZE);
+		if (cfi_bhi)
+			cfi_fineibt_bhi_preamble(addr, arity);
 	}
 
 	return 0;
@@ -1361,7 +1402,7 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end)
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		if (!is_endbr(addr + 16))
+		if (!exact_endbr(addr + 16))
 			continue;
 
 		poison_endbr(addr + 16);

