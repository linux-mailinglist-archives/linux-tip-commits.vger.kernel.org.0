Return-Path: <linux-tip-commits+bounces-7493-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D644C7F854
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02D23A69A8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D72FBDFD;
	Mon, 24 Nov 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehuU38XM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBvPgaYa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CE2FB625;
	Mon, 24 Nov 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975514; cv=none; b=cDJodCbnoiOScJFZc28yxCMs81kFeNBqo93Zx94QSPvNpSAqrZkUi5ij+WP2G7L6+LkTBHNihd7XjM2i/ilCBngiomTB3ArKiIb5L3R1FluFjlAEgZjUTcOcZTf6I1dlaJ+5LGP17y8Trvv8yA+VNfBjU7lo6KuAdFsL8CKZgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975514; c=relaxed/simple;
	bh=jONyEBn7+6NrdWN4c/6crSf78vGOibNA1nLbVihmWEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tx5luK1tflbHmIvGa90+xtYcVhmwDVemD2u6v2Hxqd2DYBAAYKLpc+1LD366fQN4W0Zr2f/PSfy9NGjQin0lrN6KYzz+JTo8AvxDev8e3A6UVKeOb4VpLlERfW0uGRNXQFSpJsSknGY2zAXrorgYoUfPT1y2vv56BVjjXfOpmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehuU38XM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBvPgaYa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6x7z7ogNWhjOqabpGjGccwSOgcC9HJb8oyPM0w3Yl0=;
	b=ehuU38XMbdwiwMC1k6g8f5RaLlmHXfxNVQw8Vv6AWAo//2+09j8lVCYaNyrx3d1cxM2AZK
	XDhU4MG8SqD5Z9mctntNB/yjP36JiMX+wdOqmxRhlbBd+ZoEUD35Wcxw7+JT/Q4LzX0Hdd
	XEtiJq+MoMrijLMSF+3buFHYxVXiWSar4dwqZ4vJDKmNMKrbgFHuciSfRmG5+AE0VzIxwb
	n5CGmD96H6tW/A5TN69oiJMhH/2T786Q7LgNXT0rqmJr+A5iDXhs5gAGF2jLZwhQl/q9ym
	lUweeQN85p1BGgCozvFmMz2BeWwCJprjVjaPs32MNgjT4gpentJi1e7hff1hmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6x7z7ogNWhjOqabpGjGccwSOgcC9HJb8oyPM0w3Yl0=;
	b=xBvPgaYaBRlTB2nkEiY78Af0w8JoUVcMTnBLINaHIcZG5UO3JKJLvb7o980qctOiCDpknu
	eH53c11+Ws+v8VDw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Improve tracing of alternative instructions
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-16-alexandre.chartre@oracle.com>
References: <20251121095340.464045-16-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550898.498.12685492922627906275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     350c7ab8577a32c101a097f4c072220d9ce64f3b
Gitweb:        https://git.kernel.org/tip/350c7ab8577a32c101a097f4c072220d9ce=
64f3b
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:11 +01:00

objtool: Improve tracing of alternative instructions

When tracing function validation, improve the reporting of
alternative instruction by more clearly showing the different
alternatives beginning and end.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-16-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c                 | 18 ++-----
 tools/objtool/include/objtool/trace.h | 65 +++++++++++++++++++++++++-
 tools/objtool/trace.c                 | 55 ++++++++++++++++++++++-
 3 files changed, 125 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 93aaa4b..442b655 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3564,7 +3564,7 @@ static bool skip_alt_group(struct instruction *insn)
=20
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
 	if (insn->alt_group->ignore) {
-		TRACE_INSN(insn, "alt group ignored");
+		TRACE_ALT(insn, "alt group ignored");
 		return true;
 	}
=20
@@ -3680,8 +3680,9 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 			 struct instruction *prev_insn, struct instruction *next_insn,
 			 bool *dead_end)
 {
-	/* prev_state is not used if there is no disassembly support */
+	/* prev_state and alt_name are not used if there is no disassembly support =
*/
 	struct insn_state prev_state __maybe_unused;
+	char *alt_name __maybe_unused =3D NULL;
 	struct alternative *alt;
 	u8 visited;
 	int ret;
@@ -3768,23 +3769,16 @@ static int validate_insn(struct objtool_file *file, s=
truct symbol *func,
 		return 1;
=20
 	if (insn->alts) {
-		int i, num_alts;
-
-		num_alts =3D 0;
-		for (alt =3D insn->alts; alt; alt =3D alt->next)
-			num_alts++;
-
-		i =3D 1;
 		for (alt =3D insn->alts; alt; alt =3D alt->next) {
-			TRACE_INSN(insn, "alternative %d/%d", i, num_alts);
+			TRACE_ALT_BEGIN(insn, alt, alt_name);
 			ret =3D validate_branch(file, func, alt->insn, *statep);
+			TRACE_ALT_END(insn, alt, alt_name);
 			if (ret) {
 				BT_INSN(insn, "(alt)");
 				return ret;
 			}
-			i++;
 		}
-		TRACE_INSN(insn, "alternative DEFAULT");
+		TRACE_ALT_INFO_NOADDR(insn, "/ ", "DEFAULT");
 	}
=20
 	if (skip_alt_group(insn))
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/ob=
jtool/trace.h
index 33fe9c6..70b5743 100644
--- a/tools/objtool/include/objtool/trace.h
+++ b/tools/objtool/include/objtool/trace.h
@@ -19,11 +19,26 @@ extern int trace_depth;
 		fprintf(stderr, fmt, ##__VA_ARGS__);		\
 })
=20
+/*
+ * Print the instruction address and a message. The instruction
+ * itself is not printed.
+ */
+#define TRACE_ADDR(insn, fmt, ...)				\
+({								\
+	if (trace) {						\
+		disas_print_info(stderr, insn, trace_depth - 1, \
+				 fmt "\n", ##__VA_ARGS__);	\
+	}							\
+})
+
+/*
+ * Print the instruction address, the instruction and a message.
+ */
 #define TRACE_INSN(insn, fmt, ...)				\
 ({								\
 	if (trace) {						\
 		disas_print_insn(stderr, objtool_disas_ctx,	\
-				 insn, trace_depth - 1,	\
+				 insn, trace_depth - 1,		\
 				 fmt, ##__VA_ARGS__);		\
 		fprintf(stderr, "\n");				\
 		insn->trace =3D 1;				\
@@ -36,6 +51,37 @@ extern int trace_depth;
 		trace_insn_state(insn, sprev, snext);		\
 })
=20
+#define TRACE_ALT_FMT(pfx, fmt) pfx "<%s.%lx> " fmt
+#define TRACE_ALT_ARG(insn) disas_alt_type_name(insn), (insn)->offset
+
+#define TRACE_ALT(insn, fmt, ...)				\
+	TRACE_INSN(insn, TRACE_ALT_FMT("", fmt),		\
+		   TRACE_ALT_ARG(insn), ##__VA_ARGS__)
+
+#define TRACE_ALT_INFO(insn, pfx, fmt, ...)			\
+	TRACE_ADDR(insn, TRACE_ALT_FMT(pfx, fmt),		\
+		   TRACE_ALT_ARG(insn), ##__VA_ARGS__)
+
+#define TRACE_ALT_INFO_NOADDR(insn, pfx, fmt, ...)		\
+	TRACE_ADDR(NULL, TRACE_ALT_FMT(pfx, fmt),		\
+		   TRACE_ALT_ARG(insn), ##__VA_ARGS__)
+
+#define TRACE_ALT_BEGIN(insn, alt, alt_name)			\
+({								\
+	if (trace) {						\
+		alt_name =3D disas_alt_name(alt);			\
+		trace_alt_begin(insn, alt, alt_name);		\
+	}							\
+})
+
+#define TRACE_ALT_END(insn, alt, alt_name)			\
+({								\
+	if (trace) {						\
+		trace_alt_end(insn, alt, alt_name);		\
+		free(alt_name);					\
+	}							\
+})
+
 static inline void trace_enable(void)
 {
 	trace =3D true;
@@ -61,17 +107,34 @@ static inline void trace_depth_dec(void)
=20
 void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
 		      struct insn_state *snext);
+void trace_alt_begin(struct instruction *orig_insn, struct alternative *alt,
+		     char *alt_name);
+void trace_alt_end(struct instruction *orig_insn, struct alternative *alt,
+		   char *alt_name);
=20
 #else /* DISAS */
=20
 #define TRACE(fmt, ...) ({})
+#define TRACE_ADDR(insn, fmt, ...) ({})
 #define TRACE_INSN(insn, fmt, ...) ({})
 #define TRACE_INSN_STATE(insn, sprev, snext) ({})
+#define TRACE_ALT(insn, fmt, ...) ({})
+#define TRACE_ALT_INFO(insn, fmt, ...) ({})
+#define TRACE_ALT_INFO_NOADDR(insn, fmt, ...) ({})
+#define TRACE_ALT_BEGIN(insn, alt, alt_name) ({})
+#define TRACE_ALT_END(insn, alt, alt_name) ({})
+
=20
 static inline void trace_enable(void) {}
 static inline void trace_disable(void) {}
 static inline void trace_depth_inc(void) {}
 static inline void trace_depth_dec(void) {}
+static inline void trace_alt_begin(struct instruction *orig_insn,
+				   struct alternative *alt,
+				   char *alt_name) {};
+static inline void trace_alt_end(struct instruction *orig_insn,
+				 struct alternative *alt,
+				 char *alt_name) {};
=20
 #endif
=20
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
index d70d470..5dec44d 100644
--- a/tools/objtool/trace.c
+++ b/tools/objtool/trace.c
@@ -146,3 +146,58 @@ void trace_insn_state(struct instruction *insn, struct i=
nsn_state *sprev,
=20
 	insn->trace =3D 1;
 }
+
+void trace_alt_begin(struct instruction *orig_insn, struct alternative *alt,
+		     char *alt_name)
+{
+	struct instruction *alt_insn;
+	char suffix[2];
+
+	alt_insn =3D alt->insn;
+
+	if (alt->type =3D=3D ALT_TYPE_EX_TABLE) {
+		/*
+		 * When there is an exception table then the instruction
+		 * at the original location is executed but it can cause
+		 * an exception. In that case, the execution will be
+		 * redirected to the alternative instruction.
+		 *
+		 * The instruction at the original location can have
+		 * instruction alternatives, so we just print the location
+		 * of the instruction that can cause the exception and
+		 * not the instruction itself.
+		 */
+		TRACE_ALT_INFO_NOADDR(orig_insn, "/ ", "%s for instruction at 0x%lx <%s+0x=
%lx>",
+				      alt_name,
+				      orig_insn->offset, orig_insn->sym->name,
+				      orig_insn->offset - orig_insn->sym->offset);
+	} else {
+		TRACE_ALT_INFO_NOADDR(orig_insn, "/ ", "%s", alt_name);
+	}
+
+	if (alt->type =3D=3D ALT_TYPE_JUMP_TABLE) {
+		/*
+		 * For a jump alternative, if the default instruction is
+		 * a NOP then it is replaced with the jmp instruction,
+		 * otherwise it is replaced with a NOP instruction.
+		 */
+		trace_depth++;
+		if (orig_insn->type =3D=3D INSN_NOP) {
+			suffix[0] =3D (orig_insn->len =3D=3D 5) ? 'q' : '\0';
+			TRACE_ADDR(orig_insn, "jmp%-3s %lx <%s+0x%lx>", suffix,
+				   alt_insn->offset, alt_insn->sym->name,
+				   alt_insn->offset - alt_insn->sym->offset);
+		} else {
+			TRACE_ADDR(orig_insn, "nop%d", orig_insn->len);
+			trace_depth--;
+		}
+	}
+}
+
+void trace_alt_end(struct instruction *orig_insn, struct alternative *alt,
+		   char *alt_name)
+{
+	if (alt->type =3D=3D ALT_TYPE_JUMP_TABLE && orig_insn->type =3D=3D INSN_NOP)
+		trace_depth--;
+	TRACE_ALT_INFO_NOADDR(orig_insn, "\\ ", "%s", alt_name);
+}

