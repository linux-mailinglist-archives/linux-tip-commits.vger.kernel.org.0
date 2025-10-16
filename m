Return-Path: <linux-tip-commits+bounces-6824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F3CBE2696
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEEF3E190A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2A3191C5;
	Thu, 16 Oct 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0JCvYXe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UYnArAy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9F3176EF;
	Thu, 16 Oct 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607197; cv=none; b=udKARXK9HXrPdXSCvNtp/SOFZrvFDU2dCuVeII3JAADxmxykj8hVQAodmVG3FHMZWPJq90XH357Qmtji3IUB+FsMjU3n1RReK2tEF0j55nZLyOa/IF3puYTWdeIoJq2KUPg+O6jfM4n2f94f1OD4qkiwm0aXIkQ5XPYPSjTghhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607197; c=relaxed/simple;
	bh=LSmoFy7Rnhg526ab4fxA2C57il/RfdFG48ks41k7r7I=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=L6WsvxU+os2O865I4aKtuepkN8TbGEt56wXHG99qs+31B3HgkDqqooj6JUJfp+lGc6HK7Ow47r346qjUctHlYAUQjHRKaxNBNSZoVA+hrTSX53NxyMNI/crJ62WE1XLVBI2Sz4Nnn4qYD/TLLVL8M/xoY3tJkhS/5ClPMcwqSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0JCvYXe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UYnArAy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:32:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uShJOkOhi1ud6xtxozBd0NWR7Ry6n/9+N357yMOD94k=;
	b=p0JCvYXexj54U2GFlOMRlga6xleTKJThePUIXBuNWSodW0DILIjrTo8kqxqAKwRIjJsNzG
	BmqxcbJWoDFqesT4d1ape0rp3H+0jILo7rl0/mKam8XU7HHuNRKzP4byLRA+3466tI7Qqr
	GwDZJzTbqQnjPUR0SFwNbRWBqfBB5oCIwdNZpZUVOjENxAuYkZOpIdd0VUNO59fwaUQr9O
	10eOQ00SLLJuqk/+A8GiUb8ttnoz8M47C5tgVdfegKn1WL8ujWcmtOZpZDGhBgbcYHCGgD
	KrARoFG51EltToGMlEtrqV+A5+fu5ijwVE1aO0tkPS+XWplfhJjEP2sfuJS5wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uShJOkOhi1ud6xtxozBd0NWR7Ry6n/9+N357yMOD94k=;
	b=0UYnArAyZAslBILDt/DB4hG0dQOeufFkIJgeiV2yRbTZS+0zkNLBkYwRnkJSHpcOnXYCV4
	asE86R+Qfb0lleAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Simplify for_each_insn_prefix()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060714785.709179.11824506848891961011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     45e1dccc0653c50e377dae57ef086a8d0f71061d
Gitweb:        https://git.kernel.org/tip/45e1dccc0653c50e377dae57ef086a8d0f7=
1061d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Sep 2025 10:19:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:48 +02:00

x86/insn: Simplify for_each_insn_prefix()

Use the new-found freedom of allowing variable declarions inside
for() to simplify the for_each_insn_prefix() iterator to no longer
need an external temporary.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/boot/compressed/sev-handle-vc.c |  3 +--
 arch/x86/include/asm/insn.h              |  5 ++---
 arch/x86/kernel/kprobes/core.c           |  3 +--
 arch/x86/kernel/uprobes.c                |  6 ++----
 arch/x86/lib/insn-eval.c                 | 12 +++++-------
 tools/arch/x86/include/asm/insn.h        |  5 ++---
 6 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compres=
sed/sev-handle-vc.c
index 7530ad8..030001b 100644
--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -29,11 +29,10 @@
 bool insn_has_rep_prefix(struct insn *insn)
 {
 	insn_byte_t p;
-	int i;
=20
 	insn_get_prefixes(insn);
=20
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p =3D=3D 0xf2 || p =3D=3D 0xf3)
 			return true;
 	}
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 091f88c..846d21c 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -312,7 +312,6 @@ static inline int insn_offset_immediate(struct insn *insn)
 /**
  * for_each_insn_prefix() -- Iterate prefixes in the instruction
  * @insn: Pointer to struct insn.
- * @idx:  Index storage.
  * @prefix: Prefix byte.
  *
  * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
@@ -321,8 +320,8 @@ static inline int insn_offset_immediate(struct insn *insn)
  * Since prefixes.nbytes can be bigger than 4 if some prefixes
  * are repeated, it cannot be used for looping over the prefixes.
  */
-#define for_each_insn_prefix(insn, idx, prefix)	\
-	for (idx =3D 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix =3D insn-=
>prefixes.bytes[idx]) !=3D 0; idx++)
+#define for_each_insn_prefix(insn, prefix)	\
+	for (int idx =3D 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix =3D i=
nsn->prefixes.bytes[idx]) !=3D 0; idx++)
=20
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 3863d77..c1fac3a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -141,7 +141,6 @@ bool can_boost(struct insn *insn, void *addr)
 {
 	kprobe_opcode_t opcode;
 	insn_byte_t prefix;
-	int i;
=20
 	if (search_exception_tables((unsigned long)addr))
 		return false;	/* Page fault may occur on this address. */
@@ -154,7 +153,7 @@ bool can_boost(struct insn *insn, void *addr)
 	if (insn->opcode.nbytes !=3D 1)
 		return false;
=20
-	for_each_insn_prefix(insn, i, prefix) {
+	for_each_insn_prefix(insn, prefix) {
 		insn_attr_t attr;
=20
 		attr =3D inat_get_opcode_attribute(prefix);
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6318898..a563e90 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -259,9 +259,8 @@ static volatile u32 good_2byte_insns[256 / 32] =3D {
 static bool is_prefix_bad(struct insn *insn)
 {
 	insn_byte_t p;
-	int i;
=20
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		insn_attr_t attr;
=20
 		attr =3D inat_get_opcode_attribute(p);
@@ -1404,7 +1403,6 @@ static int branch_setup_xol_ops(struct arch_uprobe *aup=
robe, struct insn *insn)
 {
 	u8 opc1 =3D OPCODE1(insn);
 	insn_byte_t p;
-	int i;
=20
 	if (insn_is_nop(insn))
 		goto setup;
@@ -1437,7 +1435,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *aup=
robe, struct insn *insn)
 	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
 	 * No one uses these insns, reject any branch insns with such prefix.
 	 */
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p =3D=3D 0x66)
 			return -ENOTSUPP;
 	}
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index c991dac..e03eeec 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -63,11 +63,10 @@ static bool is_string_insn(struct insn *insn)
 bool insn_has_rep_prefix(struct insn *insn)
 {
 	insn_byte_t p;
-	int i;
=20
 	insn_get_prefixes(insn);
=20
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p =3D=3D 0xf2 || p =3D=3D 0xf3)
 			return true;
 	}
@@ -92,13 +91,13 @@ bool insn_has_rep_prefix(struct insn *insn)
 static int get_seg_reg_override_idx(struct insn *insn)
 {
 	int idx =3D INAT_SEG_REG_DEFAULT;
-	int num_overrides =3D 0, i;
+	int num_overrides =3D 0;
 	insn_byte_t p;
=20
 	insn_get_prefixes(insn);
=20
 	/* Look for any segment override prefixes. */
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		insn_attr_t attr;
=20
 		attr =3D inat_get_opcode_attribute(p);
@@ -1701,7 +1700,6 @@ bool insn_is_nop(struct insn *insn)
 	u8 sib =3D 0, sib_scale, sib_index, sib_base;
 	u8 nrex, rex;
 	u8 p, rep =3D 0;
-	int i;
=20
 	if ((nrex =3D insn->rex_prefix.nbytes)) {
 		rex =3D insn->rex_prefix.bytes[nrex-1];
@@ -1741,7 +1739,7 @@ bool insn_is_nop(struct insn *insn)
 		modrm_rm =3D sib_base;
 	}
=20
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p =3D=3D 0xf3) /* REPE */
 			rep =3D 1;
 	}
@@ -1789,7 +1787,7 @@ bool insn_is_nop(struct insn *insn)
 		if (sib && (sib_scale !=3D 0 || sib_index !=3D 4)) /* (%reg, %eiz, 1) */
 			return false;
=20
-		for_each_insn_prefix(insn, i, p) {
+		for_each_insn_prefix(insn, p) {
 			if (p !=3D 0x3e) /* DS */
 				return false;
 		}
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/i=
nsn.h
index c683d60..8f10f29 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -312,7 +312,6 @@ static inline int insn_offset_immediate(struct insn *insn)
 /**
  * for_each_insn_prefix() -- Iterate prefixes in the instruction
  * @insn: Pointer to struct insn.
- * @idx:  Index storage.
  * @prefix: Prefix byte.
  *
  * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
@@ -321,8 +320,8 @@ static inline int insn_offset_immediate(struct insn *insn)
  * Since prefixes.nbytes can be bigger than 4 if some prefixes
  * are repeated, it cannot be used for looping over the prefixes.
  */
-#define for_each_insn_prefix(insn, idx, prefix)	\
-	for (idx =3D 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix =3D insn-=
>prefixes.bytes[idx]) !=3D 0; idx++)
+#define for_each_insn_prefix(insn, prefix)	\
+	for (int idx =3D 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix =3D i=
nsn->prefixes.bytes[idx]) !=3D 0; idx++)
=20
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e

