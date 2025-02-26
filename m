Return-Path: <linux-tip-commits+bounces-3635-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FDEA45C33
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67993A5B50
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1124E010;
	Wed, 26 Feb 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZcjmPvp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNYDaHj0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626D20E70A;
	Wed, 26 Feb 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567256; cv=none; b=XSO6Pei8AoQNP3LV4g64AAfTpe6o4jrohr0Xignwtzvvxsp7mJ6Fl/qtAI81Cu3Xi1JzvteqRlid/Xy7t3ii1Skw/7Ow8dkiD3Pe1MxSH5Du+MFNIcDxVfP2Ui9F8GV5+KFecXmzCjeeDymMjQhrTokwSaZkUW/KIgUfB/LTKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567256; c=relaxed/simple;
	bh=oba1Zw2GKIAv2+xd4YeaYs+D7LWFUlq2X+TDom7gFVo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vb5QMMolzOzkp+fP/9jDT6BAYmSIo/ZMA2s5YCxuC4c+Po/2M3dTpKExKi14jaa+hfdNOx03usr0Kq9ZKi+YzydrpbVXSg6eXffIc8sRQnnXW2UtTyAgRpDTd/cQfHdIjOooMRc2/AKHszLmYXcD+q/nvXpecIdC0TVgBG3VHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZcjmPvp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNYDaHj0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJCW4a844tt56pwFX89d/F0xj40X9Qz/+OPlGjNZA4Q=;
	b=qZcjmPvpgbsiXpn35WKkIdAQa/q1gOY+kZ8en742/ammx2Wm0uBkYOFaLzPsrnuEnnpesL
	c/cmzDq5PXEI616UQK95Fy5wsOGGge6mZOQKsbs1fJ1mLLTI+AhB8ImTM/qwvIbYpsyPnJ
	oCf4TJQC0JsD/e3F85hnN53OVdYSws9cKQJrx6aO7XaoEquyh0Uy2O2Rzt4JosQwtdnK2b
	zymOUcjajjSwLAof/JYOJ2vc/T1ZvRWWYUQPDvZecRGKGMHf+h/XOcPHsOCXSbE8kdlcWN
	T8GtlYvu3lhMNHV+s6WlWAqfb7VmgCvQOhxyDroUzdzHZEkMiUyo0BN8nxZXtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJCW4a844tt56pwFX89d/F0xj40X9Qz/+OPlGjNZA4Q=;
	b=cNYDaHj0utGod6xQSVo+E1k77IhOsodAcx26AAEfU7crKEmISKhLVQtj38IJAcNDuDe2Cl
	gtv73mrBOtbrKxBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Optimize fineibt-bhi arity 1 case
Cc: Scott Constable <scott.d.constable@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.927885784@infradead.org>
References: <20250224124200.927885784@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056725018.10177.4597725285165049417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     af908171aed7b0a7f6376f3ee6c53f40c84ae494
Gitweb:        https://git.kernel.org/tip/af908171aed7b0a7f6376f3ee6c53f40c84ae494
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:56 +01:00

x86/ibt: Optimize fineibt-bhi arity 1 case

Saves a CALL to an out-of-line thunk for the common case of 1
argument.

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 93dccb2..8d8871a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1307,6 +1307,53 @@ static int cfi_rand_preamble(s32 *start, s32 *end)
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
@@ -1337,14 +1384,8 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
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
@@ -1357,7 +1398,7 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end)
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		if (!is_endbr(addr + 16))
+		if (!exact_endbr(addr + 16))
 			continue;
 
 		poison_endbr(addr + 16);

