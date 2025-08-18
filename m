Return-Path: <linux-tip-commits+bounces-6282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AFB2ACBD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22468168CA8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5024A049;
	Mon, 18 Aug 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfH7LY53";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQ4sewqe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9028399;
	Mon, 18 Aug 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530737; cv=none; b=Hzh7SJXwW8fQemuF4pZBusf83lk+ZqlGfadI7mjsIRurMI7aMo7hYnMKGrJzPBmYDAgvnGsucdkACyBGR4CZLalW1EfxllE7ewOPuOn0LdsncOLxuQcTUxgab+Br8UT12YDSTnGmysCIje/cA+YbW7TVYE42mySowbnzacmeKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530737; c=relaxed/simple;
	bh=v6Ahzwq6H2cnfteqWh8QQY6hNLa/hCRRfv3qyripcys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TuB4GO+LRguBZi5BAaBa87DW0fAK+ijjPADrx3v8/+ZpQJ4AMOjBaKrQvN9ykH0XvhEj94fs1C1RcJMxMeZ63Y6t7vYfVXjLX3/AIPG/9YeXefOmPW2ZSUEdm4W6I5HaLVgtPy+9RdXoB3r9xjOHGNw/fi1yYeMFp8ytiQ8WjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfH7LY53; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQ4sewqe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 15:25:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755530732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYHyeUnia0fkoF39RQPEnKezVD6xV+R336thwCTvsNk=;
	b=KfH7LY533qmiwZR4uGtl0sRAtHjpA/Jd0Z0OFdN4C9L54SeOIZM1iz4YwO0H9N5t2KChgU
	ZknM3VQleD1SmPgXmgXorf6hK+yTivQpZGiKZ4XjiV4EDENVBiNgnv0X7ti/R47E0Y1tdS
	qrgbQY9ZSrUmqHk1PzYzSZ26AhoMa3aMG59T5ntAI6qazZSfW2Dgv2FXxFli/oFjtUI8TM
	tc/ir+mf1gyyYvs7WKkAmv4j9A6Da6diFu/BpgFtYrgx/jdqSpmaD+3B2s9yAJacPqPBUE
	8eNaW1LXyc+dL8Emb4RCkosc2XFdUWarQr+UHnUfR8R2yHJuWLMTcUAsooJKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755530732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYHyeUnia0fkoF39RQPEnKezVD6xV+R336thwCTvsNk=;
	b=oQ4sewqexpOV8e4KM7bs5d8WihKaHrh9jt7niAlYSdOHyr4iMreXRXG75JawqQK19meKmO
	FoiUZHnIl8MMNUDw==
From: "tip-bot2 for Masami Hiramatsu (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Add XOP prefix instructions decoder support
Cc: "Alan J. Wylie" <alan@wylie.me.uk>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <175386161199.564247.597496379413236944.stgit@devnote2>
References: <175386161199.564247.597496379413236944.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175553073132.1420.17884410107119014076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     26178b713f2b3f5bc411ed8316d1635615896111
Gitweb:        https://git.kernel.org/tip/26178b713f2b3f5bc411ed8316d16356158=
96111
Author:        Masami Hiramatsu (Google) <mhiramat@kernel.org>
AuthorDate:    Wed, 30 Jul 2025 16:46:52 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 18 Aug 2025 17:15:02 +02:00

x86/insn: Add XOP prefix instructions decoder support

Support decoding AMD's XOP prefix encoded instructions.

These instructions are introduced for Bulldozer micro architecture, and not
supported on Intel's processors. But when compiling kernel with
CONFIG_X86_NATIVE_CPU on some AMD processor (e.g. -march=3Dbdver2), these
instructions can be used.

Closes: https://lore.kernel.org/all/871pq06728.fsf@wylie.me.uk/
Reported-by: Alan J. Wylie <alan@wylie.me.uk>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Alan J. Wylie <alan@wylie.me.uk>
Link: https://lore.kernel.org/175386161199.564247.597496379413236944.stgit@de=
vnote2
---
 arch/x86/include/asm/inat.h                              |  15 +-
 arch/x86/include/asm/insn.h                              |  51 ++-
 arch/x86/lib/inat.c                                      |  13 +-
 arch/x86/lib/insn.c                                      |  35 +-
 arch/x86/lib/x86-opcode-map.txt                          | 111 ++++++-
 arch/x86/tools/gen-insn-attr-x86.awk                     |  44 +++-
 tools/arch/x86/include/asm/inat.h                        |  15 +-
 tools/arch/x86/include/asm/insn.h                        |  51 ++-
 tools/arch/x86/lib/inat.c                                |  13 +-
 tools/arch/x86/lib/insn.c                                |  35 +-
 tools/arch/x86/lib/x86-opcode-map.txt                    | 111 ++++++-
 tools/arch/x86/tools/gen-insn-attr-x86.awk               |  44 +++-
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c |   2 +-
 13 files changed, 513 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 97f3417..1b3060a 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -37,6 +37,8 @@
 #define INAT_PFX_EVEX	15	/* EVEX prefix */
 /* x86-64 REX2 prefix */
 #define INAT_PFX_REX2	16	/* 0xD5 */
+/* AMD XOP prefix */
+#define INAT_PFX_XOP	17	/* 0x8F */
=20
 #define INAT_LSTPFX_MAX	3
 #define INAT_LGCPFX_MAX	11
@@ -77,6 +79,7 @@
 #define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
 #define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
+#define INAT_XOPOK	INAT_VEXOK
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
@@ -111,6 +114,8 @@ extern insn_attr_t inat_get_group_attribute(insn_byte_t m=
odrm,
 extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
 					  insn_byte_t vex_m,
 					  insn_byte_t vex_pp);
+extern insn_attr_t inat_get_xop_attribute(insn_byte_t opcode,
+					  insn_byte_t map_select);
=20
 /* Attribute checking functions */
 static inline int inat_is_legacy_prefix(insn_attr_t attr)
@@ -164,6 +169,11 @@ static inline int inat_is_vex3_prefix(insn_attr_t attr)
 	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_VEX3;
 }
=20
+static inline int inat_is_xop_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_XOP;
+}
+
 static inline int inat_is_escape(insn_attr_t attr)
 {
 	return attr & INAT_ESC_MASK;
@@ -229,6 +239,11 @@ static inline int inat_accept_vex(insn_attr_t attr)
 	return attr & INAT_VEXOK;
 }
=20
+static inline int inat_accept_xop(insn_attr_t attr)
+{
+	return attr & INAT_XOPOK;
+}
+
 static inline int inat_must_vex(insn_attr_t attr)
 {
 	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 7152ea8..091f88c 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -71,7 +71,10 @@ struct insn {
 					 * prefixes.bytes[3]: last prefix
 					 */
 	struct insn_field rex_prefix;	/* REX prefix */
-	struct insn_field vex_prefix;	/* VEX prefix */
+	union {
+		struct insn_field vex_prefix;	/* VEX prefix */
+		struct insn_field xop_prefix;	/* XOP prefix */
+	};
 	struct insn_field opcode;	/*
 					 * opcode.bytes[0]: opcode1
 					 * opcode.bytes[1]: opcode2
@@ -135,6 +138,17 @@ struct insn {
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+/* XOP bit fields */
+#define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
+#define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
+#define X86_XOP_B(xop)	((xop) & 0x20)	/* XOP Byte2 */
+#define X86_XOP_M(xop)	((xop) & 0x1f)	/* XOP Byte2 */
+#define X86_XOP_W(xop)	((xop) & 0x80)	/* XOP Byte3 */
+#define X86_XOP_V(xop)	((xop) & 0x78)	/* XOP Byte3 */
+#define X86_XOP_L(xop)	((xop) & 0x04)	/* XOP Byte3 */
+#define X86_XOP_P(xop)	((xop) & 0x03)	/* XOP Byte3 */
+#define X86_XOP_M_MIN	0x08	/* Min of XOP.M */
+#define X86_XOP_M_MAX	0x1f	/* Max of XOP.M */
=20
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int=
 x86_64);
 extern int insn_get_prefixes(struct insn *insn);
@@ -178,7 +192,7 @@ static inline insn_byte_t insn_rex2_m_bit(struct insn *in=
sn)
 	return X86_REX2_M(insn->rex_prefix.bytes[1]);
 }
=20
-static inline int insn_is_avx(struct insn *insn)
+static inline int insn_is_avx_or_xop(struct insn *insn)
 {
 	if (!insn->prefixes.got)
 		insn_get_prefixes(insn);
@@ -192,6 +206,22 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes =3D=3D 4);
 }
=20
+/* If we already know this is AVX/XOP encoded */
+static inline int avx_insn_is_xop(struct insn *insn)
+{
+	insn_attr_t attr =3D inat_get_opcode_attribute(insn->vex_prefix.bytes[0]);
+
+	return inat_is_xop_prefix(attr);
+}
+
+static inline int insn_is_xop(struct insn *insn)
+{
+	if (!insn_is_avx_or_xop(insn))
+		return 0;
+
+	return avx_insn_is_xop(insn);
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
@@ -222,11 +252,26 @@ static inline insn_byte_t insn_vex_w_bit(struct insn *i=
nsn)
 	return X86_VEX_W(insn->vex_prefix.bytes[2]);
 }
=20
+static inline insn_byte_t insn_xop_map_bits(struct insn *insn)
+{
+	if (insn->xop_prefix.nbytes < 3)	/* XOP is 3 bytes */
+		return 0;
+	return X86_XOP_M(insn->xop_prefix.bytes[1]);
+}
+
+static inline insn_byte_t insn_xop_p_bits(struct insn *insn)
+{
+	return X86_XOP_P(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
-	if (insn_is_avx(insn))
+	if (insn_is_avx_or_xop(insn)) {
+		if (avx_insn_is_xop(insn))
+			return insn_xop_p_bits(insn);
 		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
+	}
=20
 	if (insn->prefixes.bytes[3])
 		return inat_get_last_prefix_id(insn->prefixes.bytes[3]);
diff --git a/arch/x86/lib/inat.c b/arch/x86/lib/inat.c
index b0f3b2a..a5cafd4 100644
--- a/arch/x86/lib/inat.c
+++ b/arch/x86/lib/inat.c
@@ -81,3 +81,16 @@ insn_attr_t inat_get_avx_attribute(insn_byte_t opcode, ins=
n_byte_t vex_m,
 	return table[opcode];
 }
=20
+insn_attr_t inat_get_xop_attribute(insn_byte_t opcode, insn_byte_t map_selec=
t)
+{
+	const insn_attr_t *table;
+
+	if (map_select < X86_XOP_M_MIN || map_select > X86_XOP_M_MAX)
+		return 0;
+	map_select -=3D X86_XOP_M_MIN;
+	/* At first, this checks the master table */
+	table =3D inat_xop_tables[map_select];
+	if (!table)
+		return 0;
+	return table[opcode];
+}
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 149a57e..225af13 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -200,12 +200,15 @@ found:
 	}
 	insn->rex_prefix.got =3D 1;
=20
-	/* Decode VEX prefix */
+	/* Decode VEX/XOP prefix */
 	b =3D peek_next(insn_byte_t, insn);
-	attr =3D inat_get_opcode_attribute(b);
-	if (inat_is_vex_prefix(attr)) {
+	if (inat_is_vex_prefix(attr) || inat_is_xop_prefix(attr)) {
 		insn_byte_t b2 =3D peek_nbyte_next(insn_byte_t, insn, 1);
-		if (!insn->x86_64) {
+
+		if (inat_is_xop_prefix(attr) && X86_MODRM_REG(b2) =3D=3D 0) {
+			/* Grp1A.0 is always POP Ev */
+			goto vex_end;
+		} else if (!insn->x86_64) {
 			/*
 			 * In 32-bits mode, if the [7:6] bits (mod bits of
 			 * ModRM) on the second byte are not 11b, it is
@@ -226,13 +229,13 @@ found:
 			if (insn->x86_64 && X86_VEX_W(b2))
 				/* VEX.W overrides opnd_size */
 				insn->opnd_bytes =3D 8;
-		} else if (inat_is_vex3_prefix(attr)) {
+		} else if (inat_is_vex3_prefix(attr) || inat_is_xop_prefix(attr)) {
 			b2 =3D peek_nbyte_next(insn_byte_t, insn, 2);
 			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes =3D 3;
 			insn->next_byte +=3D 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
-				/* VEX.W overrides opnd_size */
+				/* VEX.W/XOP.W overrides opnd_size */
 				insn->opnd_bytes =3D 8;
 		} else {
 			/*
@@ -288,9 +291,22 @@ int insn_get_opcode(struct insn *insn)
 	insn_set_byte(opcode, 0, op);
 	opcode->nbytes =3D 1;
=20
-	/* Check if there is VEX prefix or not */
-	if (insn_is_avx(insn)) {
+	/* Check if there is VEX/XOP prefix or not */
+	if (insn_is_avx_or_xop(insn)) {
 		insn_byte_t m, p;
+
+		/* XOP prefix has different encoding */
+		if (unlikely(avx_insn_is_xop(insn))) {
+			m =3D insn_xop_map_bits(insn);
+			insn->attr =3D inat_get_xop_attribute(op, m);
+			if (!inat_accept_xop(insn->attr)) {
+				insn->attr =3D 0;
+				return -EINVAL;
+			}
+			/* XOP has only 1 byte for opcode */
+			goto end;
+		}
+
 		m =3D insn_vex_m_bits(insn);
 		p =3D insn_vex_p_bits(insn);
 		insn->attr =3D inat_get_avx_attribute(op, m, p);
@@ -383,7 +399,8 @@ int insn_get_modrm(struct insn *insn)
 			pfx_id =3D insn_last_prefix_id(insn);
 			insn->attr =3D inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+			if (insn_is_avx_or_xop(insn) && !inat_accept_vex(insn->attr) &&
+			    !inat_accept_xop(insn->attr)) {
 				/* Bad insn */
 				insn->attr =3D 0;
 				return -EINVAL;
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 262f7ca..2a4e69e 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -27,6 +27,11 @@
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
+#  (xop): this opcode accepts XOP prefix.
+#
+# XOP Superscripts
+#  (W=3D0): this opcode requires XOP.W =3D=3D 0
+#  (W=3D1): this opcode requires XOP.W =3D=3D 1
 #
 # Last Prefix Superscripts
 #  - (66): the last prefix is 0x66
@@ -194,7 +199,7 @@ AVXcode:
 8c: MOV Ev,Sw
 8d: LEA Gv,M
 8e: MOV Sw,Ew
-8f: Grp1A (1A) | POP Ev (d64)
+8f: Grp1A (1A) | POP Ev (d64) | XOP (Prefix)
 # 0x90 - 0x9f
 90: NOP | PAUSE (F3) | XCHG r8,rAX
 91: XCHG rCX/r9,rAX
@@ -1106,6 +1111,84 @@ AVXcode: 7
 f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
 EndTable
=20
+# From AMD64 Architecture Programmer's Manual Vol3, Appendix A.1.5
+Table: XOP map 8h
+Referrer:
+XOPcode: 0
+85: VPMACSSWW Vo,Ho,Wo,Lo
+86: VPMACSSWD Vo,Ho,Wo,Lo
+87: VPMACSSDQL Vo,Ho,Wo,Lo
+8e: VPMACSSDD Vo,Ho,Wo,Lo
+8f: VPMACSSDQH Vo,Ho,Wo,Lo
+95: VPMACSWW Vo,Ho,Wo,Lo
+96: VPMACSWD Vo,Ho,Wo,Lo
+97: VPMACSDQL Vo,Ho,Wo,Lo
+9e: VPMACSDD Vo,Ho,Wo,Lo
+9f: VPMACSDQH Vo,Ho,Wo,Lo
+a2: VPCMOV Vx,Hx,Wx,Lx (W=3D0) | VPCMOV Vx,Hx,Lx,Wx (W=3D1)
+a3: VPPERM Vo,Ho,Wo,Lo (W=3D0) | VPPERM Vo,Ho,Lo,Wo (W=3D1)
+a6: VPMADCSSWD Vo,Ho,Wo,Lo
+b6: VPMADCSWD Vo,Ho,Wo,Lo
+c0: VPROTB Vo,Wo,Ib
+c1: VPROTW Vo,Wo,Ib
+c2: VPROTD Vo,Wo,Ib
+c3: VPROTQ Vo,Wo,Ib
+cc: VPCOMccB Vo,Ho,Wo,Ib
+cd: VPCOMccW Vo,Ho,Wo,Ib
+ce: VPCOMccD Vo,Ho,Wo,Ib
+cf: VPCOMccQ Vo,Ho,Wo,Ib
+ec: VPCOMccUB Vo,Ho,Wo,Ib
+ed: VPCOMccUW Vo,Ho,Wo,Ib
+ee: VPCOMccUD Vo,Ho,Wo,Ib
+ef: VPCOMccUQ Vo,Ho,Wo,Ib
+EndTable
+
+Table: XOP map 9h
+Referrer:
+XOPcode: 1
+01: GrpXOP1
+02: GrpXOP2
+12: GrpXOP3
+80: VFRCZPS Vx,Wx
+81: VFRCZPD Vx,Wx
+82: VFRCZSS Vq,Wss
+83: VFRCZSD Vq,Wsd
+90: VPROTB Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+91: VPROTW Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+92: VPROTD Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+93: VPROTQ Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+94: VPSHLB Vo,Wo,Ho (W=3D0) | VPSHLB Vo,Ho,Wo (W=3D1)
+95: VPSHLW Vo,Wo,Ho (W=3D0) | VPSHLW Vo,Ho,Wo (W=3D1)
+96: VPSHLD Vo,Wo,Ho (W=3D0) | VPSHLD Vo,Ho,Wo (W=3D1)
+97: VPSHLQ Vo,Wo,Ho (W=3D0) | VPSHLQ Vo,Ho,Wo (W=3D1)
+98: VPSHAB Vo,Wo,Ho (W=3D0) | VPSHAB Vo,Ho,Wo (W=3D1)
+99: VPSHAW Vo,Wo,Ho (W=3D0) | VPSHAW Vo,Ho,Wo (W=3D1)
+9a: VPSHAD Vo,Wo,Ho (W=3D0) | VPSHAD Vo,Ho,Wo (W=3D1)
+9b: VPSHAQ Vo,Wo,Ho (W=3D0) | VPSHAQ Vo,Ho,Wo (W=3D1)
+c1: VPHADDBW Vo,Wo
+c2: VPHADDBD Vo,Wo
+c3: VPHADDBQ Vo,Wo
+c6: VPHADDWD Vo,Wo
+c7: VPHADDWQ Vo,Wo
+cb: VPHADDDQ Vo,Wo
+d1: VPHADDUBWD Vo,Wo
+d2: VPHADDUBD Vo,Wo
+d3: VPHADDUBQ Vo,Wo
+d6: VPHADDUWD Vo,Wo
+d7: VPHADDUWQ Vo,Wo
+db: VPHADDUDQ Vo,Wo
+e1: VPHSUBBW Vo,Wo
+e2: VPHSUBWD Vo,Wo
+e3: VPHSUBDQ Vo,Wo
+EndTable
+
+Table: XOP map Ah
+Referrer:
+XOPcode: 2
+10: BEXTR Gy,Ey,Id
+12: GrpXOP4
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
@@ -1320,3 +1403,29 @@ GrpTable: GrpRNG
 4: xcrypt-cfb
 5: xcrypt-ofb
 EndTable
+
+# GrpXOP1-4 is shown in AMD APM Vol.3 Appendix A as XOP group #1-4
+GrpTable: GrpXOP1
+1: BLCFILL By,Ey (xop)
+2: BLSFILL By,Ey (xop)
+3: BLCS By,Ey (xop)
+4: TZMSK By,Ey (xop)
+5: BLCIC By,Ey (xop)
+6: BLSIC By,Ey (xop)
+7: T1MSKC By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP2
+1: BLCMSK By,Ey (xop)
+6: BLCI By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP3
+0: LLWPCB Ry (xop)
+1: SLWPCB Ry (xop)
+EndTable
+
+GrpTable: GrpXOP4
+0: LWPINS By,Ed,Id (xop)
+1: LWPVAL By,Ed,Id (xop)
+EndTable
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-a=
ttr-x86.awk
index 2c19d7f..7ea1b75 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -21,6 +21,7 @@ function clear_vars() {
 	eid =3D -1 # escape id
 	gid =3D -1 # group id
 	aid =3D -1 # AVX id
+	xopid =3D -1 # XOP id
 	tname =3D ""
 }
=20
@@ -39,9 +40,11 @@ BEGIN {
 	ggid =3D 1
 	geid =3D 1
 	gaid =3D 0
+	gxopid =3D 0
 	delete etable
 	delete gtable
 	delete atable
+	delete xoptable
=20
 	opnd_expr =3D "^[A-Za-z/]"
 	ext_expr =3D "^\\("
@@ -61,6 +64,7 @@ BEGIN {
 	imm_flag["Ob"] =3D "INAT_MOFFSET"
 	imm_flag["Ov"] =3D "INAT_MOFFSET"
 	imm_flag["Lx"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+	imm_flag["Lo"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
=20
 	modrm_expr =3D "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr =3D "\\([df]64\\)"
@@ -87,6 +91,8 @@ BEGIN {
 	evexonly_expr =3D "\\(ev\\)"
 	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine oper=
and size
 	evex_scalable_expr =3D "\\(es\\)"
+	# All opcodes in XOP table or with (xop) superscript accept XOP prefix
+	xopok_expr =3D "\\(xop\\)"
=20
 	prefix_expr =3D "\\(Prefix\\)"
 	prefix_num["Operand-Size"] =3D "INAT_PFX_OPNDSZ"
@@ -106,6 +112,7 @@ BEGIN {
 	prefix_num["VEX+2byte"] =3D "INAT_PFX_VEX3"
 	prefix_num["EVEX"] =3D "INAT_PFX_EVEX"
 	prefix_num["REX2"] =3D "INAT_PFX_REX2"
+	prefix_num["XOP"] =3D "INAT_PFX_XOP"
=20
 	clear_vars()
 }
@@ -147,6 +154,7 @@ function array_size(arr,   i,c) {
 	if (NF !=3D 1) {
 		# AVX/escape opcode table
 		aid =3D $2
+		xopid =3D -1
 		if (gaid <=3D aid)
 			gaid =3D aid + 1
 		if (tname =3D=3D "")	# AVX only opcode table
@@ -156,6 +164,20 @@ function array_size(arr,   i,c) {
 		tname =3D "inat_primary_table"
 }
=20
+/^XOPcode:/ {
+	if (NF !=3D 1) {
+		# XOP opcode table
+		xopid =3D $2
+		aid =3D -1
+		if (gxopid <=3D xopid)
+			gxopid =3D xopid + 1
+		if (tname =3D=3D "")	# XOP only opcode table
+			tname =3D sprintf("inat_xop_table_%d", $2)
+	}
+	if (xopid =3D=3D -1 && eid =3D=3D -1)	# primary opcode table
+		tname =3D "inat_primary_table"
+}
+
 /^GrpTable:/ {
 	print "/* " $0 " */"
 	if (!($2 in group))
@@ -206,6 +228,8 @@ function print_table(tbl,name,fmt,n)
 			etable[eid,0] =3D tname
 			if (aid >=3D 0)
 				atable[aid,0] =3D tname
+			else if (xopid >=3D 0)
+				xoptable[xopid] =3D tname
 		}
 		if (array_size(lptable1) !=3D 0) {
 			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
@@ -347,6 +371,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			flags =3D add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
 			flags =3D add_flags(flags, "INAT_VEXOK")
+		else if (match(ext, xopok_expr) || xopid >=3D 0)
+			flags =3D add_flags(flags, "INAT_XOPOK")
=20
 		# check prefixes
 		if (match(ext, prefix_expr)) {
@@ -413,6 +439,14 @@ END {
 				print "	["i"]["j"] =3D "atable[i,j]","
 	print "};\n"
=20
+	print "/* XOP opcode map array */"
+	print "const insn_attr_t * const inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_=
MIN + 1]" \
+	      " =3D {"
+	for (i =3D 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "	["i"] =3D "xoptable[i]","
+	print "};"
+
 	print "#else /* !__BOOT_COMPRESSED */\n"
=20
 	print "/* Escape opcode map array */"
@@ -430,6 +464,10 @@ END {
 	      "[INAT_LSTPFX_MAX + 1];"
 	print ""
=20
+	print "/* XOP opcode map array */"
+	print "static const insn_attr_t *inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_=
MIN + 1];"
+	print ""
+
 	print "static void inat_init_tables(void)"
 	print "{"
=20
@@ -455,6 +493,12 @@ END {
 			if (atable[i,j])
 				print "\tinat_avx_tables["i"]["j"] =3D "atable[i,j]";"
=20
+	print ""
+	print "\t/* Print XOP opcode map array */"
+	for (i =3D 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "\tinat_xop_tables["i"] =3D "xoptable[i]";"
+
 	print "}"
 	print "#endif"
 }
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/i=
nat.h
index 183aa66..099e926 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -37,6 +37,8 @@
 #define INAT_PFX_EVEX	15	/* EVEX prefix */
 /* x86-64 REX2 prefix */
 #define INAT_PFX_REX2	16	/* 0xD5 */
+/* AMD XOP prefix */
+#define INAT_PFX_XOP	17	/* 0x8F */
=20
 #define INAT_LSTPFX_MAX	3
 #define INAT_LGCPFX_MAX	11
@@ -77,6 +79,7 @@
 #define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
 #define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
+#define INAT_XOPOK	INAT_VEXOK
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
@@ -111,6 +114,8 @@ extern insn_attr_t inat_get_group_attribute(insn_byte_t m=
odrm,
 extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
 					  insn_byte_t vex_m,
 					  insn_byte_t vex_pp);
+extern insn_attr_t inat_get_xop_attribute(insn_byte_t opcode,
+					  insn_byte_t map_select);
=20
 /* Attribute checking functions */
 static inline int inat_is_legacy_prefix(insn_attr_t attr)
@@ -164,6 +169,11 @@ static inline int inat_is_vex3_prefix(insn_attr_t attr)
 	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_VEX3;
 }
=20
+static inline int inat_is_xop_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_XOP;
+}
+
 static inline int inat_is_escape(insn_attr_t attr)
 {
 	return attr & INAT_ESC_MASK;
@@ -229,6 +239,11 @@ static inline int inat_accept_vex(insn_attr_t attr)
 	return attr & INAT_VEXOK;
 }
=20
+static inline int inat_accept_xop(insn_attr_t attr)
+{
+	return attr & INAT_XOPOK;
+}
+
 static inline int inat_must_vex(insn_attr_t attr)
 {
 	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/i=
nsn.h
index 0e5abd8..c683d60 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -71,7 +71,10 @@ struct insn {
 					 * prefixes.bytes[3]: last prefix
 					 */
 	struct insn_field rex_prefix;	/* REX prefix */
-	struct insn_field vex_prefix;	/* VEX prefix */
+	union {
+		struct insn_field vex_prefix;	/* VEX prefix */
+		struct insn_field xop_prefix;	/* XOP prefix */
+	};
 	struct insn_field opcode;	/*
 					 * opcode.bytes[0]: opcode1
 					 * opcode.bytes[1]: opcode2
@@ -135,6 +138,17 @@ struct insn {
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+/* XOP bit fields */
+#define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
+#define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
+#define X86_XOP_B(xop)	((xop) & 0x20)	/* XOP Byte2 */
+#define X86_XOP_M(xop)	((xop) & 0x1f)	/* XOP Byte2 */
+#define X86_XOP_W(xop)	((xop) & 0x80)	/* XOP Byte3 */
+#define X86_XOP_V(xop)	((xop) & 0x78)	/* XOP Byte3 */
+#define X86_XOP_L(xop)	((xop) & 0x04)	/* XOP Byte3 */
+#define X86_XOP_P(xop)	((xop) & 0x03)	/* XOP Byte3 */
+#define X86_XOP_M_MIN	0x08	/* Min of XOP.M */
+#define X86_XOP_M_MAX	0x1f	/* Max of XOP.M */
=20
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int=
 x86_64);
 extern int insn_get_prefixes(struct insn *insn);
@@ -178,7 +192,7 @@ static inline insn_byte_t insn_rex2_m_bit(struct insn *in=
sn)
 	return X86_REX2_M(insn->rex_prefix.bytes[1]);
 }
=20
-static inline int insn_is_avx(struct insn *insn)
+static inline int insn_is_avx_or_xop(struct insn *insn)
 {
 	if (!insn->prefixes.got)
 		insn_get_prefixes(insn);
@@ -192,6 +206,22 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes =3D=3D 4);
 }
=20
+/* If we already know this is AVX/XOP encoded */
+static inline int avx_insn_is_xop(struct insn *insn)
+{
+	insn_attr_t attr =3D inat_get_opcode_attribute(insn->vex_prefix.bytes[0]);
+
+	return inat_is_xop_prefix(attr);
+}
+
+static inline int insn_is_xop(struct insn *insn)
+{
+	if (!insn_is_avx_or_xop(insn))
+		return 0;
+
+	return avx_insn_is_xop(insn);
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
@@ -222,11 +252,26 @@ static inline insn_byte_t insn_vex_w_bit(struct insn *i=
nsn)
 	return X86_VEX_W(insn->vex_prefix.bytes[2]);
 }
=20
+static inline insn_byte_t insn_xop_map_bits(struct insn *insn)
+{
+	if (insn->xop_prefix.nbytes < 3)	/* XOP is 3 bytes */
+		return 0;
+	return X86_XOP_M(insn->xop_prefix.bytes[1]);
+}
+
+static inline insn_byte_t insn_xop_p_bits(struct insn *insn)
+{
+	return X86_XOP_P(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
-	if (insn_is_avx(insn))
+	if (insn_is_avx_or_xop(insn)) {
+		if (avx_insn_is_xop(insn))
+			return insn_xop_p_bits(insn);
 		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
+	}
=20
 	if (insn->prefixes.bytes[3])
 		return inat_get_last_prefix_id(insn->prefixes.bytes[3]);
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
index dfbcc64..ffcb0e2 100644
--- a/tools/arch/x86/lib/inat.c
+++ b/tools/arch/x86/lib/inat.c
@@ -81,3 +81,16 @@ insn_attr_t inat_get_avx_attribute(insn_byte_t opcode, ins=
n_byte_t vex_m,
 	return table[opcode];
 }
=20
+insn_attr_t inat_get_xop_attribute(insn_byte_t opcode, insn_byte_t map_selec=
t)
+{
+	const insn_attr_t *table;
+
+	if (map_select < X86_XOP_M_MIN || map_select > X86_XOP_M_MAX)
+		return 0;
+	map_select -=3D X86_XOP_M_MIN;
+	/* At first, this checks the master table */
+	table =3D inat_xop_tables[map_select];
+	if (!table)
+		return 0;
+	return table[opcode];
+}
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index bce69c6..1d1c57c 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -200,12 +200,15 @@ found:
 	}
 	insn->rex_prefix.got =3D 1;
=20
-	/* Decode VEX prefix */
+	/* Decode VEX/XOP prefix */
 	b =3D peek_next(insn_byte_t, insn);
-	attr =3D inat_get_opcode_attribute(b);
-	if (inat_is_vex_prefix(attr)) {
+	if (inat_is_vex_prefix(attr) || inat_is_xop_prefix(attr)) {
 		insn_byte_t b2 =3D peek_nbyte_next(insn_byte_t, insn, 1);
-		if (!insn->x86_64) {
+
+		if (inat_is_xop_prefix(attr) && X86_MODRM_REG(b2) =3D=3D 0) {
+			/* Grp1A.0 is always POP Ev */
+			goto vex_end;
+		} else if (!insn->x86_64) {
 			/*
 			 * In 32-bits mode, if the [7:6] bits (mod bits of
 			 * ModRM) on the second byte are not 11b, it is
@@ -226,13 +229,13 @@ found:
 			if (insn->x86_64 && X86_VEX_W(b2))
 				/* VEX.W overrides opnd_size */
 				insn->opnd_bytes =3D 8;
-		} else if (inat_is_vex3_prefix(attr)) {
+		} else if (inat_is_vex3_prefix(attr) || inat_is_xop_prefix(attr)) {
 			b2 =3D peek_nbyte_next(insn_byte_t, insn, 2);
 			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes =3D 3;
 			insn->next_byte +=3D 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
-				/* VEX.W overrides opnd_size */
+				/* VEX.W/XOP.W overrides opnd_size */
 				insn->opnd_bytes =3D 8;
 		} else {
 			/*
@@ -288,9 +291,22 @@ int insn_get_opcode(struct insn *insn)
 	insn_set_byte(opcode, 0, op);
 	opcode->nbytes =3D 1;
=20
-	/* Check if there is VEX prefix or not */
-	if (insn_is_avx(insn)) {
+	/* Check if there is VEX/XOP prefix or not */
+	if (insn_is_avx_or_xop(insn)) {
 		insn_byte_t m, p;
+
+		/* XOP prefix has different encoding */
+		if (unlikely(avx_insn_is_xop(insn))) {
+			m =3D insn_xop_map_bits(insn);
+			insn->attr =3D inat_get_xop_attribute(op, m);
+			if (!inat_accept_xop(insn->attr)) {
+				insn->attr =3D 0;
+				return -EINVAL;
+			}
+			/* XOP has only 1 byte for opcode */
+			goto end;
+		}
+
 		m =3D insn_vex_m_bits(insn);
 		p =3D insn_vex_p_bits(insn);
 		insn->attr =3D inat_get_avx_attribute(op, m, p);
@@ -383,7 +399,8 @@ int insn_get_modrm(struct insn *insn)
 			pfx_id =3D insn_last_prefix_id(insn);
 			insn->attr =3D inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+			if (insn_is_avx_or_xop(insn) && !inat_accept_vex(insn->attr) &&
+			    !inat_accept_xop(insn->attr)) {
 				/* Bad insn */
 				insn->attr =3D 0;
 				return -EINVAL;
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-o=
pcode-map.txt
index 262f7ca..2a4e69e 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -27,6 +27,11 @@
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
+#  (xop): this opcode accepts XOP prefix.
+#
+# XOP Superscripts
+#  (W=3D0): this opcode requires XOP.W =3D=3D 0
+#  (W=3D1): this opcode requires XOP.W =3D=3D 1
 #
 # Last Prefix Superscripts
 #  - (66): the last prefix is 0x66
@@ -194,7 +199,7 @@ AVXcode:
 8c: MOV Ev,Sw
 8d: LEA Gv,M
 8e: MOV Sw,Ew
-8f: Grp1A (1A) | POP Ev (d64)
+8f: Grp1A (1A) | POP Ev (d64) | XOP (Prefix)
 # 0x90 - 0x9f
 90: NOP | PAUSE (F3) | XCHG r8,rAX
 91: XCHG rCX/r9,rAX
@@ -1106,6 +1111,84 @@ AVXcode: 7
 f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
 EndTable
=20
+# From AMD64 Architecture Programmer's Manual Vol3, Appendix A.1.5
+Table: XOP map 8h
+Referrer:
+XOPcode: 0
+85: VPMACSSWW Vo,Ho,Wo,Lo
+86: VPMACSSWD Vo,Ho,Wo,Lo
+87: VPMACSSDQL Vo,Ho,Wo,Lo
+8e: VPMACSSDD Vo,Ho,Wo,Lo
+8f: VPMACSSDQH Vo,Ho,Wo,Lo
+95: VPMACSWW Vo,Ho,Wo,Lo
+96: VPMACSWD Vo,Ho,Wo,Lo
+97: VPMACSDQL Vo,Ho,Wo,Lo
+9e: VPMACSDD Vo,Ho,Wo,Lo
+9f: VPMACSDQH Vo,Ho,Wo,Lo
+a2: VPCMOV Vx,Hx,Wx,Lx (W=3D0) | VPCMOV Vx,Hx,Lx,Wx (W=3D1)
+a3: VPPERM Vo,Ho,Wo,Lo (W=3D0) | VPPERM Vo,Ho,Lo,Wo (W=3D1)
+a6: VPMADCSSWD Vo,Ho,Wo,Lo
+b6: VPMADCSWD Vo,Ho,Wo,Lo
+c0: VPROTB Vo,Wo,Ib
+c1: VPROTW Vo,Wo,Ib
+c2: VPROTD Vo,Wo,Ib
+c3: VPROTQ Vo,Wo,Ib
+cc: VPCOMccB Vo,Ho,Wo,Ib
+cd: VPCOMccW Vo,Ho,Wo,Ib
+ce: VPCOMccD Vo,Ho,Wo,Ib
+cf: VPCOMccQ Vo,Ho,Wo,Ib
+ec: VPCOMccUB Vo,Ho,Wo,Ib
+ed: VPCOMccUW Vo,Ho,Wo,Ib
+ee: VPCOMccUD Vo,Ho,Wo,Ib
+ef: VPCOMccUQ Vo,Ho,Wo,Ib
+EndTable
+
+Table: XOP map 9h
+Referrer:
+XOPcode: 1
+01: GrpXOP1
+02: GrpXOP2
+12: GrpXOP3
+80: VFRCZPS Vx,Wx
+81: VFRCZPD Vx,Wx
+82: VFRCZSS Vq,Wss
+83: VFRCZSD Vq,Wsd
+90: VPROTB Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+91: VPROTW Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+92: VPROTD Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+93: VPROTQ Vo,Wo,Ho (W=3D0) | VPROTB Vo,Ho,Wo (W=3D1)
+94: VPSHLB Vo,Wo,Ho (W=3D0) | VPSHLB Vo,Ho,Wo (W=3D1)
+95: VPSHLW Vo,Wo,Ho (W=3D0) | VPSHLW Vo,Ho,Wo (W=3D1)
+96: VPSHLD Vo,Wo,Ho (W=3D0) | VPSHLD Vo,Ho,Wo (W=3D1)
+97: VPSHLQ Vo,Wo,Ho (W=3D0) | VPSHLQ Vo,Ho,Wo (W=3D1)
+98: VPSHAB Vo,Wo,Ho (W=3D0) | VPSHAB Vo,Ho,Wo (W=3D1)
+99: VPSHAW Vo,Wo,Ho (W=3D0) | VPSHAW Vo,Ho,Wo (W=3D1)
+9a: VPSHAD Vo,Wo,Ho (W=3D0) | VPSHAD Vo,Ho,Wo (W=3D1)
+9b: VPSHAQ Vo,Wo,Ho (W=3D0) | VPSHAQ Vo,Ho,Wo (W=3D1)
+c1: VPHADDBW Vo,Wo
+c2: VPHADDBD Vo,Wo
+c3: VPHADDBQ Vo,Wo
+c6: VPHADDWD Vo,Wo
+c7: VPHADDWQ Vo,Wo
+cb: VPHADDDQ Vo,Wo
+d1: VPHADDUBWD Vo,Wo
+d2: VPHADDUBD Vo,Wo
+d3: VPHADDUBQ Vo,Wo
+d6: VPHADDUWD Vo,Wo
+d7: VPHADDUWQ Vo,Wo
+db: VPHADDUDQ Vo,Wo
+e1: VPHSUBBW Vo,Wo
+e2: VPHSUBWD Vo,Wo
+e3: VPHSUBDQ Vo,Wo
+EndTable
+
+Table: XOP map Ah
+Referrer:
+XOPcode: 2
+10: BEXTR Gy,Ey,Id
+12: GrpXOP4
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
@@ -1320,3 +1403,29 @@ GrpTable: GrpRNG
 4: xcrypt-cfb
 5: xcrypt-ofb
 EndTable
+
+# GrpXOP1-4 is shown in AMD APM Vol.3 Appendix A as XOP group #1-4
+GrpTable: GrpXOP1
+1: BLCFILL By,Ey (xop)
+2: BLSFILL By,Ey (xop)
+3: BLCS By,Ey (xop)
+4: TZMSK By,Ey (xop)
+5: BLCIC By,Ey (xop)
+6: BLSIC By,Ey (xop)
+7: T1MSKC By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP2
+1: BLCMSK By,Ey (xop)
+6: BLCI By,Ey (xop)
+EndTable
+
+GrpTable: GrpXOP3
+0: LLWPCB Ry (xop)
+1: SLWPCB Ry (xop)
+EndTable
+
+GrpTable: GrpXOP4
+0: LWPINS By,Ed,Id (xop)
+1: LWPVAL By,Ed,Id (xop)
+EndTable
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tool=
s/gen-insn-attr-x86.awk
index 2c19d7f..7ea1b75 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -21,6 +21,7 @@ function clear_vars() {
 	eid =3D -1 # escape id
 	gid =3D -1 # group id
 	aid =3D -1 # AVX id
+	xopid =3D -1 # XOP id
 	tname =3D ""
 }
=20
@@ -39,9 +40,11 @@ BEGIN {
 	ggid =3D 1
 	geid =3D 1
 	gaid =3D 0
+	gxopid =3D 0
 	delete etable
 	delete gtable
 	delete atable
+	delete xoptable
=20
 	opnd_expr =3D "^[A-Za-z/]"
 	ext_expr =3D "^\\("
@@ -61,6 +64,7 @@ BEGIN {
 	imm_flag["Ob"] =3D "INAT_MOFFSET"
 	imm_flag["Ov"] =3D "INAT_MOFFSET"
 	imm_flag["Lx"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+	imm_flag["Lo"] =3D "INAT_MAKE_IMM(INAT_IMM_BYTE)"
=20
 	modrm_expr =3D "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr =3D "\\([df]64\\)"
@@ -87,6 +91,8 @@ BEGIN {
 	evexonly_expr =3D "\\(ev\\)"
 	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine oper=
and size
 	evex_scalable_expr =3D "\\(es\\)"
+	# All opcodes in XOP table or with (xop) superscript accept XOP prefix
+	xopok_expr =3D "\\(xop\\)"
=20
 	prefix_expr =3D "\\(Prefix\\)"
 	prefix_num["Operand-Size"] =3D "INAT_PFX_OPNDSZ"
@@ -106,6 +112,7 @@ BEGIN {
 	prefix_num["VEX+2byte"] =3D "INAT_PFX_VEX3"
 	prefix_num["EVEX"] =3D "INAT_PFX_EVEX"
 	prefix_num["REX2"] =3D "INAT_PFX_REX2"
+	prefix_num["XOP"] =3D "INAT_PFX_XOP"
=20
 	clear_vars()
 }
@@ -147,6 +154,7 @@ function array_size(arr,   i,c) {
 	if (NF !=3D 1) {
 		# AVX/escape opcode table
 		aid =3D $2
+		xopid =3D -1
 		if (gaid <=3D aid)
 			gaid =3D aid + 1
 		if (tname =3D=3D "")	# AVX only opcode table
@@ -156,6 +164,20 @@ function array_size(arr,   i,c) {
 		tname =3D "inat_primary_table"
 }
=20
+/^XOPcode:/ {
+	if (NF !=3D 1) {
+		# XOP opcode table
+		xopid =3D $2
+		aid =3D -1
+		if (gxopid <=3D xopid)
+			gxopid =3D xopid + 1
+		if (tname =3D=3D "")	# XOP only opcode table
+			tname =3D sprintf("inat_xop_table_%d", $2)
+	}
+	if (xopid =3D=3D -1 && eid =3D=3D -1)	# primary opcode table
+		tname =3D "inat_primary_table"
+}
+
 /^GrpTable:/ {
 	print "/* " $0 " */"
 	if (!($2 in group))
@@ -206,6 +228,8 @@ function print_table(tbl,name,fmt,n)
 			etable[eid,0] =3D tname
 			if (aid >=3D 0)
 				atable[aid,0] =3D tname
+			else if (xopid >=3D 0)
+				xoptable[xopid] =3D tname
 		}
 		if (array_size(lptable1) !=3D 0) {
 			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
@@ -347,6 +371,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			flags =3D add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
 			flags =3D add_flags(flags, "INAT_VEXOK")
+		else if (match(ext, xopok_expr) || xopid >=3D 0)
+			flags =3D add_flags(flags, "INAT_XOPOK")
=20
 		# check prefixes
 		if (match(ext, prefix_expr)) {
@@ -413,6 +439,14 @@ END {
 				print "	["i"]["j"] =3D "atable[i,j]","
 	print "};\n"
=20
+	print "/* XOP opcode map array */"
+	print "const insn_attr_t * const inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_=
MIN + 1]" \
+	      " =3D {"
+	for (i =3D 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "	["i"] =3D "xoptable[i]","
+	print "};"
+
 	print "#else /* !__BOOT_COMPRESSED */\n"
=20
 	print "/* Escape opcode map array */"
@@ -430,6 +464,10 @@ END {
 	      "[INAT_LSTPFX_MAX + 1];"
 	print ""
=20
+	print "/* XOP opcode map array */"
+	print "static const insn_attr_t *inat_xop_tables[X86_XOP_M_MAX - X86_XOP_M_=
MIN + 1];"
+	print ""
+
 	print "static void inat_init_tables(void)"
 	print "{"
=20
@@ -455,6 +493,12 @@ END {
 			if (atable[i,j])
 				print "\tinat_avx_tables["i"]["j"] =3D "atable[i,j]";"
=20
+	print ""
+	print "\t/* Print XOP opcode map array */"
+	for (i =3D 0; i < gxopid; i++)
+		if (xoptable[i])
+			print "\tinat_xop_tables["i"] =3D "xoptable[i]";"
+
 	print "}"
 	print "#endif"
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools=
/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 8fabddc..72c7a4e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -32,7 +32,7 @@ static void intel_pt_insn_decoder(struct insn *insn,
 	intel_pt_insn->rel =3D 0;
 	intel_pt_insn->emulated_ptwrite =3D false;
=20
-	if (insn_is_avx(insn)) {
+	if (insn_is_avx_or_xop(insn)) {
 		intel_pt_insn->op =3D INTEL_PT_OP_OTHER;
 		intel_pt_insn->branch =3D INTEL_PT_BR_NO_BRANCH;
 		intel_pt_insn->length =3D insn->length;

