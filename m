Return-Path: <linux-tip-commits+bounces-3659-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDFA45E52
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CCC3B65BA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA972222BD;
	Wed, 26 Feb 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fXNimqx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQfhV9k2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069F2222B0;
	Wed, 26 Feb 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571487; cv=none; b=uuk78XQexWngGcaKyx0HZ030o6vBVMPtMV+QcK/ret6uAe8KnrILagiNBNYtzcv1xe0kFodcbzcBMJzqT27Cm7bgGKS8Ro7hm9yINGKMqW2vSFK8GSZmWXKTC2i7vH95oVbqmaUIyI0G1lF3LUwihRHTJ7j2RoXDigbK35FU/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571487; c=relaxed/simple;
	bh=jbYDntIKXa6XX2JecSB3Db1n5RG0EaouuAfqUVulmek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BY3GT9wcVLiP48u9zrmPNL+f2GNS8+NWTJgT5qPQnTVK9sxAoYjB/nR3eQp2RD7JMg40Hc+3KZ3E0T1ORyR3oKRRv664FViPVWsCv8KqobFZz4JoolCW/jIHkFV8TTSq8sakIU+pyT8WEd9ByFlq01JZhjIJyNfnTZT8rCdmAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fXNimqx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQfhV9k2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33XhlqTrL/8j/uqPMgXSk0smJ9dGfKCnp6c79XyuDWs=;
	b=2fXNimqxyIoxbuinFKMst4jGT25LE5TsQPBQr17YuuwNKMLAzUm4VxHT6Gh26T78cW/sI5
	kGgsU/BtzNr06+t3q7vbhbUsHlAcvhL50H5qHEIUuTUgnOvRwfFWr3di/69KjuGGlJvdMM
	Ll41fcOwNXnYlFvxy/kGkqIJ313tQWn0oXXHSIvqI4UDyLaG1/lQ8DSWeDZ+n1aVQkDSXb
	OLRUPCtK2bjrBBp9SqnDxhPuf0B+uss9LqLT8nP7Cm0aEE1R3bQFhvYSSNE92mOh7hHBCT
	NJ2dW97dmZExHjenk7bK/iagGZWlVixJks7dE12DCZn5mGhjnPJ+rlYVTSP0IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33XhlqTrL/8j/uqPMgXSk0smJ9dGfKCnp6c79XyuDWs=;
	b=iQfhV9k2WFIMp0JskXha3oTuyqsMQAY1dMdFxXIHvDHAaQEwyitMbPZb+DIbFleYBMBHdk
	4exa9F2KtpmRBOCw==
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
Message-ID: <174057148042.10177.15600094775489227176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     496ce4741ccbc91838df4bf9e137eda99c61f500
Gitweb:        https://git.kernel.org/tip/496ce4741ccbc91838df4bf9e137eda99c61f500
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:30:52 +01:00

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

