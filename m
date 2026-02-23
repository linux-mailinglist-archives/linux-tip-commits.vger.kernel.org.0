Return-Path: <linux-tip-commits+bounces-8230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNoDJygsnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:30:00 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8586174E68
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B318304B07D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CCF3624C2;
	Mon, 23 Feb 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUijRS6m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJhkkr4u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F7361DB5;
	Mon, 23 Feb 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842332; cv=none; b=fchL8pf1n/mDW+wDQIujZd+D7IMdCKe3rhyCXMBlFXyEggRPgGGSA7/6ykOkcAmGkBi0WAItT9YXauRUaJ0bN+ITZt2Xuu81ielurPbyM5jVCe84G33ShQC21zud142Kjp7LnH0ygE/Dby1PI9tGL8TbymBf2IMXleZTzT30P4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842332; c=relaxed/simple;
	bh=33UyJys8Wv4iN1pWtuoyj1IGsKogSWyjXrrZQgUir1w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RU3YJWRfXgZgdfDePoEalMTRnU4KAtbtWBlzMK2jxEY4vz4k5rXGVsnqmY81WPpd5BUCn1VBr91nP6LFe1o7sFrYh60ltD7OrTsvFFGflnNIBo4B7vIS5sGAhzK3/b5zSDBBA2LJlpX/qCPtv82d+cG9CrkttZVnZkqhg24gYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUijRS6m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJhkkr4u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WBhONSPXr9VMllp8NfkOLMP/v04rHm0I0EQr3BhvIII=;
	b=wUijRS6mhbZY6pzu43lFNmPzNVAh7RWHVFfvmPR8ZpPbqjG06GadRC/h65y+BeadV9t1XP
	Zmdts3DbPp7fz41QTh8Pqwj+Osa819ZDEKFpmCm5J3dA2oxRkawznUeocFr5bw2Kd9EMzO
	A08kjtUaraznoHGkURPoCTF4JR3oe2XzfxDF09fvDUf/BSVHdHUg9VAAEjovSAAiMjnNII
	puYsd1kmtom/XB0OkoM5aBKmvsS9QgJQMgQ6L3+z6UgSdvJqf1Qv+0V+EvwwgaphED9WV2
	ck3cqpm8LaTKkfTjd2jALf8/JzdB9LDgqEXnXUQpvuyltIVhF+wvl/Tdr6iULw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WBhONSPXr9VMllp8NfkOLMP/v04rHm0I0EQr3BhvIII=;
	b=OJhkkr4uq2zpGz4KooHwbJsKseVPyi0JHUdQebCqkYNhj4hKL/Qgz2SK6LBGZNuo2VEmk3
	0VJlRSuVpQ9shmAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cfi: Fix CFI rewrite for odd alignments
Cc: Rustam Kovhaev <rkovhaev@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232831.1647592.1792161215530369424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8230-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,linutronix.de:dkim];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B8586174E68
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     24c8147abb39618d74fcc36e325765e8fe7bdd7a
Gitweb:        https://git.kernel.org/tip/24c8147abb39618d74fcc36e325765e8fe7=
bdd7a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 Feb 2026 13:59:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:11 +01:00

x86/cfi: Fix CFI rewrite for odd alignments

Rustam reported his clang builds did not boot properly; turns out his
.config has: CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=3Dy set.

Fix up the FineIBT code to deal with this unusual alignment.

Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
Reported-by: Rustam Kovhaev <rkovhaev@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 arch/x86/include/asm/cfi.h     | 12 ++++++++----
 arch/x86/include/asm/linkage.h |  4 ++--
 arch/x86/kernel/alternative.c  | 29 ++++++++++++++++++++++-------
 arch/x86/net/bpf_jit_comp.c    | 13 ++-----------
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index c40b9eb..ab3fbbd 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -111,6 +111,12 @@ extern bhi_thunk __bhi_args_end[];
=20
 struct pt_regs;
=20
+#ifdef CONFIG_CALL_PADDING
+#define CFI_OFFSET (CONFIG_FUNCTION_PADDING_CFI+5)
+#else
+#define CFI_OFFSET 5
+#endif
+
 #ifdef CONFIG_CFI
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
@@ -119,11 +125,9 @@ static inline int cfi_get_offset(void)
 {
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		return 16;
+		return /* fineibt_prefix_size */ 16;
 	case CFI_KCFI:
-		if (IS_ENABLED(CONFIG_CALL_PADDING))
-			return 16;
-		return 5;
+		return CFI_OFFSET;
 	default:
 		return 0;
 	}
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 9d38ae7..a729465 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -68,7 +68,7 @@
  * Depending on -fpatchable-function-entry=3DN,N usage (CONFIG_CALL_PADDING)=
 the
  * CFI symbol layout changes.
  *
- * Without CALL_THUNKS:
+ * Without CALL_PADDING:
  *
  * 	.align	FUNCTION_ALIGNMENT
  * __cfi_##name:
@@ -77,7 +77,7 @@
  * 	.long	__kcfi_typeid_##name
  * name:
  *
- * With CALL_THUNKS:
+ * With CALL_PADDING:
  *
  * 	.align FUNCTION_ALIGNMENT
  * __cfi_##name:
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a888ae0..e87da25 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1182,7 +1182,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *st=
art, s32 *end)
=20
 		poison_endbr(addr);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_cfi(addr - 16);
+			poison_cfi(addr - CFI_OFFSET);
 	}
 }
=20
@@ -1389,6 +1389,8 @@ extern u8 fineibt_preamble_end[];
 #define fineibt_preamble_ud   0x13
 #define fineibt_preamble_hash 5
=20
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+
 /*
  * <fineibt_caller_start>:
  *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
@@ -1634,7 +1636,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 		 * have determined there are no indirect calls to it and we
 		 * don't need no CFI either.
 		 */
-		if (!is_endbr(addr + 16))
+		if (!is_endbr(addr + CFI_OFFSET))
 			continue;
=20
 		hash =3D decode_preamble_hash(addr, &arity);
@@ -1642,6 +1644,15 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 			 addr, addr, 5, addr))
 			return -EINVAL;
=20
+		/*
+		 * FineIBT relies on being at func-16, so if the preamble is
+		 * actually larger than that, place it the tail end.
+		 *
+		 * NOTE: this is possible with things like DEBUG_CALL_THUNKS
+		 * and DEBUG_FORCE_FUNCTION_ALIGN_64B.
+		 */
+		addr +=3D CFI_OFFSET - fineibt_prefix_size;
+
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) !=3D 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
@@ -1664,10 +1675,10 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end)
 	for (s =3D start; s < end; s++) {
 		void *addr =3D (void *)s + *s;
=20
-		if (!exact_endbr(addr + 16))
+		if (!exact_endbr(addr + CFI_OFFSET))
 			continue;
=20
-		poison_endbr(addr + 16);
+		poison_endbr(addr + CFI_OFFSET);
 	}
 }
=20
@@ -1772,7 +1783,8 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *=
end_retpoline,
 	if (FINEIBT_WARN(fineibt_preamble_size, 20)			||
 	    FINEIBT_WARN(fineibt_preamble_bhi + fineibt_bhi1_size, 20)	||
 	    FINEIBT_WARN(fineibt_caller_size, 14)			||
-	    FINEIBT_WARN(fineibt_paranoid_size, 20))
+	    FINEIBT_WARN(fineibt_paranoid_size, 20)			||
+	    WARN_ON_ONCE(CFI_OFFSET < fineibt_prefix_size))
 		return;
=20
 	if (cfi_mode =3D=3D CFI_AUTO) {
@@ -1886,6 +1898,11 @@ static void poison_cfi(void *addr)
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
 		/*
+		 * FineIBT preamble is at func-16.
+		 */
+		addr +=3D CFI_OFFSET - fineibt_prefix_size;
+
+		/*
 		 * FineIBT prefix should start with an ENDBR.
 		 */
 		if (!is_endbr(addr))
@@ -1923,8 +1940,6 @@ static void poison_cfi(void *addr)
 	}
 }
=20
-#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
-
 /*
  * When regs->ip points to a 0xD6 byte in the FineIBT preamble,
  * return true and fill out target and type.
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8f10080..e9b7804 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -438,17 +438,8 @@ static void emit_kcfi(u8 **pprog, u32 hash)
=20
 	EMIT1_off32(0xb8, hash);			/* movl $hash, %eax	*/
 #ifdef CONFIG_CALL_PADDING
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
+	for (int i =3D 0; i < CONFIG_FUNCTION_PADDING_CFI; i++)
+		EMIT1(0x90);
 #endif
 	EMIT_ENDBR();
=20

