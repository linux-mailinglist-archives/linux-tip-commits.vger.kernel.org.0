Return-Path: <linux-tip-commits+bounces-7832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D09CD05CE5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 08 Jan 2026 20:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 741DD3022F1C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jan 2026 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5922E719E;
	Thu,  8 Jan 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWbTrgzE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKV/2xXb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC464347DD;
	Thu,  8 Jan 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899920; cv=none; b=MzQQL73Se8BrdAXZ5jXVPtnNtKJTLfDBEKQD3g6EeHsjbWYnUtjGXQp+fZ0SJv3zGHNONmddc+Szjva42jxJoRcI8ZMFhH5wAt5/47KnWa4fbbSqWH2YQ3bZbHu+d7ToqHRs/3kM2c3Q9DI+OZaStrEgMKuE9s959gkl+Us1TIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899920; c=relaxed/simple;
	bh=kskDvGkuMgMdj7B7mSfDtG6D2YCYjBXilopb30cKKGA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V92+BpF9wuYU8uZnKP5uAlIzFsdr9wbkgr++9GIrycxFKdXbj94Oksna0z1s5hUaVjku3sUtHTiVvc3IcohpnvWqQUVctsJhP3280hlnEg0FIHz7ueKed9zk+OzgCYZoYINBKmoXGOQRhqErOsZK59jB84N9Fi/1a8MH3If9b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWbTrgzE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKV/2xXb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Jan 2026 19:18:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767899916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWqIBntrrZAbg3Vf5FjK9lFXNEjEGrw3q3lRrrQmvto=;
	b=XWbTrgzETuXlutc+M0nKs1CRaYp9eTDb7X1ZXQ5sspvCV4lvYQPoCOMqqFdipvFujXiiUq
	HUwc9oAunc+XQk2wq/2qr8sS3Wmqu5VSOmGTfhBr4T3ld1vFYstZyr1TkVmQKr+LVt/iDB
	nkjXHtPpjRY1F+2KZpr9cmJk2dsIu3CVjREbg+zZovWzEc3bNDj/waKidVxrX0vHgWA938
	1mBcVUKQALtjt6bZGfH372VmdEQ+YMuw2OCoWx6P4gjsxNiQIJDNW4w7wMb8gLnyDkVcxt
	cSReaqg+ru0PyFQAio4PuJI/HVyTxNhLimqcJ4ogn6j8k9eWynllJbInqFZ5Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767899916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWqIBntrrZAbg3Vf5FjK9lFXNEjEGrw3q3lRrrQmvto=;
	b=pKV/2xXbOn70+QO6X88sfZ2O6aHY/3N7E3y2ovdZXBoaLUx4B15Ehkk/QxDO9YcQQhpB66
	1h835QV6ggtl7bAA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Use helper functions for
 patching alternatives
Cc: Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105080452.5064-2-jgross@suse.com>
References: <20260105080452.5064-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176789991575.510.4470067385211921028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     544b4e15ed106b0e8cd2d584f576e3fda13d8f5f
Gitweb:        https://git.kernel.org/tip/544b4e15ed106b0e8cd2d584f576e3fda13=
d8f5f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 09:04:51 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 07 Jan 2026 16:05:11 +01:00

x86/alternative: Use helper functions for patching alternatives

Tidy up apply_alternatives() by moving the main patching action of a single
alternative instance into 3 helper functions:

- analyze_patch_site() for selection whether patching should occur or not and
  to handle nested alternatives.

- prep_patch_site() for applying any needed relocations and issuing debug
  prints for the site.

- patch_site() doing the real patching action, including optimization of any
  padding NOPs.

In prep_patch_site() use __apply_relocation() instead of
text_poke_apply_relocation(), as the NOP optimization is now done in
patch_site() for all cases.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105080452.5064-2-jgross@suse.com
---
 arch/x86/kernel/alternative.c | 142 ++++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2851837..6e3eec0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -586,6 +586,88 @@ static inline u8 * instr_va(struct alt_instr *i)
 	return (u8 *)&i->instr_offset + i->instr_offset;
 }
=20
+struct patch_site {
+	u8 *instr;
+	struct alt_instr *alt;
+	u8 buff[MAX_PATCH_LEN];
+	u8 len;
+};
+
+static void __init_or_module analyze_patch_site(struct patch_site *ps,
+						struct alt_instr *start,
+						struct alt_instr *end)
+{
+	struct alt_instr *r;
+
+	ps->instr =3D instr_va(start);
+	ps->len =3D start->instrlen;
+
+	/*
+	 * In case of nested ALTERNATIVE()s the outer alternative might add
+	 * more padding. To ensure consistent patching find the max padding for
+	 * all alt_instr entries for this site (nested alternatives result in
+	 * consecutive entries).
+	 */
+	for (r =3D start+1; r < end && instr_va(r) =3D=3D ps->instr; r++) {
+		ps->len =3D max(ps->len, r->instrlen);
+		start->instrlen =3D r->instrlen =3D ps->len;
+	}
+
+	BUG_ON(ps->len > sizeof(ps->buff));
+	BUG_ON(start->cpuid >=3D (NCAPINTS + NBUGINTS) * 32);
+
+	/*
+	 * Patch if either:
+	 * - feature is present
+	 * - feature not present but ALT_FLAG_NOT is set to mean,
+	 *   patch if feature is *NOT* present.
+	 */
+	if (!boot_cpu_has(start->cpuid) =3D=3D !(start->flags & ALT_FLAG_NOT))
+		ps->alt =3D NULL;
+	else
+		ps->alt =3D start;
+}
+
+static void __init_or_module prep_patch_site(struct patch_site *ps)
+{
+	struct alt_instr *alt =3D ps->alt;
+	u8 buff_sz;
+	u8 *repl;
+
+	if (!alt) {
+		/* Nothing to patch, use original instruction. */
+		memcpy(ps->buff, ps->instr, ps->len);
+		return;
+	}
+
+	repl =3D (u8 *)&alt->repl_offset + alt->repl_offset;
+	DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d=
) flags: 0x%x",
+		alt->cpuid >> 5, alt->cpuid & 0x1f,
+		ps->instr, ps->instr, ps->len,
+		repl, alt->replacementlen, alt->flags);
+
+	memcpy(ps->buff, repl, alt->replacementlen);
+	buff_sz =3D alt->replacementlen;
+
+	if (alt->flags & ALT_FLAG_DIRECT_CALL)
+		buff_sz =3D alt_replace_call(ps->instr, ps->buff, alt);
+
+	for (; buff_sz < ps->len; buff_sz++)
+		ps->buff[buff_sz] =3D 0x90;
+
+	__apply_relocation(ps->buff, ps->instr, ps->len, repl, alt->replacementlen);
+
+	DUMP_BYTES(ALT, ps->instr, ps->len, "%px:   old_insn: ", ps->instr);
+	DUMP_BYTES(ALT, repl, alt->replacementlen, "%px:   rpl_insn: ", repl);
+	DUMP_BYTES(ALT, ps->buff, ps->len, "%px: final_insn: ", ps->instr);
+}
+
+static void __init_or_module patch_site(struct patch_site *ps)
+{
+	optimize_nops(ps->instr, ps->buff, ps->len);
+	text_poke_early(ps->instr, ps->buff, ps->len);
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -599,9 +681,7 @@ static inline u8 * instr_va(struct alt_instr *i)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	u8 insn_buff[MAX_PATCH_LEN];
-	u8 *instr, *replacement;
-	struct alt_instr *a, *b;
+	struct alt_instr *a;
=20
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
=20
@@ -625,59 +705,11 @@ void __init_or_module noinline apply_alternatives(struc=
t alt_instr *start,
 	 * order.
 	 */
 	for (a =3D start; a < end; a++) {
-		unsigned int insn_buff_sz =3D 0;
-
-		/*
-		 * In case of nested ALTERNATIVE()s the outer alternative might
-		 * add more padding. To ensure consistent patching find the max
-		 * padding for all alt_instr entries for this site (nested
-		 * alternatives result in consecutive entries).
-		 */
-		for (b =3D a+1; b < end && instr_va(b) =3D=3D instr_va(a); b++) {
-			u8 len =3D max(a->instrlen, b->instrlen);
-			a->instrlen =3D b->instrlen =3D len;
-		}
-
-		instr =3D instr_va(a);
-		replacement =3D (u8 *)&a->repl_offset + a->repl_offset;
-		BUG_ON(a->instrlen > sizeof(insn_buff));
-		BUG_ON(a->cpuid >=3D (NCAPINTS + NBUGINTS) * 32);
-
-		/*
-		 * Patch if either:
-		 * - feature is present
-		 * - feature not present but ALT_FLAG_NOT is set to mean,
-		 *   patch if feature is *NOT* present.
-		 */
-		if (!boot_cpu_has(a->cpuid) =3D=3D !(a->flags & ALT_FLAG_NOT)) {
-			memcpy(insn_buff, instr, a->instrlen);
-			optimize_nops(instr, insn_buff, a->instrlen);
-			text_poke_early(instr, insn_buff, a->instrlen);
-			continue;
-		}
-
-		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %=
d) flags: 0x%x",
-			a->cpuid >> 5,
-			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->flags);
-
-		memcpy(insn_buff, replacement, a->replacementlen);
-		insn_buff_sz =3D a->replacementlen;
-
-		if (a->flags & ALT_FLAG_DIRECT_CALL)
-			insn_buff_sz =3D alt_replace_call(instr, insn_buff, a);
-
-		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
-			insn_buff[insn_buff_sz] =3D 0x90;
-
-		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->=
replacementlen);
-
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", repla=
cement);
-		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+		struct patch_site ps;
=20
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		analyze_patch_site(&ps, a, end);
+		prep_patch_site(&ps);
+		patch_site(&ps);
 	}
=20
 	kasan_enable_current();

