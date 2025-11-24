Return-Path: <linux-tip-commits+bounces-7500-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4426C7F88E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC303A6D1D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7112FE078;
	Mon, 24 Nov 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aL6latIT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7n8sW7xR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF52FDC2F;
	Mon, 24 Nov 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975522; cv=none; b=lLAMEpsEUgf9zfYe3NBd0sYzzv74iFpaFtoECr4YKEJ2HT6PFravKlGijIl2bcjFReTx4WGtIf4r+jAAtqrGTYtdwVJkOnOgIhqTEHoC6Gw6J9fxAJ+0kB3a01W3wv6uyMzSjCUNfPukbDnJfKnOlmgeehpLd8NJ6ZYSE/K5E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975522; c=relaxed/simple;
	bh=bbnli9lEnqAVIlO3ni5NdmIxOWKOFooze2Af4S7QE0A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TOFEHxJ3Q+A2ybE9ipOZASKnfEg9eitZcshmpcPtqBXOGHMTdf9iHkrlStdoeu5veFun0CMX8Gqw95cSDRLGcoOMbQnu7iDd4wKbW8UHQT0ELr/S4BhRGylyoJMrSWoB+TVMKZ7O4FYcQ/+kmJpLwgpKMrzXAFj6TGfnIcrrVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aL6latIT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7n8sW7xR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2Z3xO6iNewSbFR+EjibFvb9NFOI5bt7JNP51sNkjw4=;
	b=aL6latITbULbL0j/jeVUBvyzGrWF80ZLQHdyTqpoLDEyWcVH5HeHj+jOuoyseG02naAx4o
	iav3jbC9EC+yeFn2eqkiRP3QXUDQWSyaysbX+iXbyjJGWY5YY8aujBLxZVK2dv1IHvIE9S
	Nep/LYuOwQme3bz01T1fYisLGZDQ+ckGQCa1Vbd/ow+BjcDboa8KVakYpTmem+/azTwjlO
	AHIIdzUAOM0pCq622TOfWAONFq3+OE1YmfPAQkspwT0FQHEYvll9wiNn5Lqki6qM0uBULP
	n8suvnbvQlCmoTjvWaEUxqdIVnCm++WWvKSjVV4MgtL/R6xKZ3K5LlBZKtQScA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2Z3xO6iNewSbFR+EjibFvb9NFOI5bt7JNP51sNkjw4=;
	b=7n8sW7xRlSQPGrwDQ/jsDpCMDyB+FioIN+rZ8Jsq5N74sj8OI3eXnYp8t+7ebx5XZFe3Z5
	pDyg0nip9bQp96AA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Disassemble instruction on warning or backtrace
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-8-alexandre.chartre@oracle.com>
References: <20251121095340.464045-8-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551726.498.18421612084146668299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0bb080ba6469a573bc85122153d931334d10a173
Gitweb:        https://git.kernel.org/tip/0bb080ba6469a573bc85122153d931334d1=
0a173
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:08 +01:00

objtool: Disassemble instruction on warning or backtrace

When an instruction warning (WARN_INSN) or backtrace (BT_INSN) is issued,
disassemble the instruction to provide more context.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-8-alexandre.chartre@orac=
le.com
---
 tools/objtool/check.c                 | 36 +++++++++++++++++++++-----
 tools/objtool/disas.c                 |  5 +---
 tools/objtool/include/objtool/check.h |  2 +-
 tools/objtool/include/objtool/disas.h | 13 +++++++++-
 tools/objtool/include/objtool/warn.h  | 16 ++++++++----
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0999717..4da1f07 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4792,11 +4792,34 @@ static void free_insns(struct objtool_file *file)
 		free(chunk->addr);
 }
=20
+static struct disas_context *objtool_disas_ctx;
+
+const char *objtool_disas_insn(struct instruction *insn)
+{
+	struct disas_context *dctx =3D objtool_disas_ctx;
+
+	if (!dctx)
+		return "";
+
+	disas_insn(dctx, insn);
+	return disas_result(dctx);
+}
+
 int check(struct objtool_file *file)
 {
-	struct disas_context *disas_ctx;
+	struct disas_context *disas_ctx =3D NULL;
 	int ret =3D 0, warnings =3D 0;
=20
+	/*
+	 * If the verbose or backtrace option is used then we need a
+	 * disassembly context to disassemble instruction or function
+	 * on warning or backtrace.
+	 */
+	if (opts.verbose || opts.backtrace) {
+		disas_ctx =3D disas_context_create(file);
+		objtool_disas_ctx =3D disas_ctx;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -4936,11 +4959,12 @@ out:
 	if (opts.verbose) {
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
-		disas_ctx =3D disas_context_create(file);
-		if (disas_ctx) {
-			disas_warned_funcs(disas_ctx);
-			disas_context_destroy(disas_ctx);
-		}
+		disas_warned_funcs(disas_ctx);
+	}
+
+	if (disas_ctx) {
+		disas_context_destroy(disas_ctx);
+		objtool_disas_ctx =3D NULL;
 	}
=20
 	free_insns(file);
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 89daa12..a030b06 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -303,7 +303,7 @@ void disas_context_destroy(struct disas_context *dctx)
 	free(dctx);
 }
=20
-static char *disas_result(struct disas_context *dctx)
+char *disas_result(struct disas_context *dctx)
 {
 	return dctx->result;
 }
@@ -311,8 +311,7 @@ static char *disas_result(struct disas_context *dctx)
 /*
  * Disassemble a single instruction. Return the size of the instruction.
  */
-static size_t disas_insn(struct disas_context *dctx,
-			 struct instruction *insn)
+size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 {
 	disassembler_ftype disasm =3D dctx->disassembler;
 	struct disassemble_info *dinfo =3D &dctx->info;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index ad9c735..f96aabd 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -141,4 +141,6 @@ struct instruction *next_insn_same_sec(struct objtool_fil=
e *file, struct instruc
 	     insn && insn->offset < sym->offset + sym->len;		\
 	     insn =3D next_insn_same_sec(file, insn))
=20
+const char *objtool_disas_insn(struct instruction *insn);
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/ob=
jtool/disas.h
index 3ec3ce2..1aee1fb 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -17,6 +17,8 @@ void disas_warned_funcs(struct disas_context *dctx);
 int disas_info_init(struct disassemble_info *dinfo,
 		    int arch, int mach32, int mach64,
 		    const char *options);
+size_t disas_insn(struct disas_context *dctx, struct instruction *insn);
+char *disas_result(struct disas_context *dctx);
=20
 #else /* DISAS */
=20
@@ -38,6 +40,17 @@ static inline int disas_info_init(struct disassemble_info =
*dinfo,
 	return -1;
 }
=20
+static inline size_t disas_insn(struct disas_context *dctx,
+				struct instruction *insn)
+{
+	return -1;
+}
+
+static inline char *disas_result(struct disas_context *dctx)
+{
+	return NULL;
+}
+
 #endif /* DISAS */
=20
 #endif /* _DISAS_H */
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index a1e3927..f32abc7 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -77,9 +77,11 @@ static inline char *offstr(struct section *sec, unsigned l=
ong offset)
 #define WARN_INSN(insn, format, ...)					\
 ({									\
 	struct instruction *_insn =3D (insn);				\
-	if (!_insn->sym || !_insn->sym->warned)				\
+	if (!_insn->sym || !_insn->sym->warned)	{			\
 		WARN_FUNC(_insn->sec, _insn->offset, format,		\
 			  ##__VA_ARGS__);				\
+		BT_INSN(_insn, "");					\
+	}								\
 	if (_insn->sym)							\
 		_insn->sym->warned =3D 1;					\
 })
@@ -87,10 +89,14 @@ static inline char *offstr(struct section *sec, unsigned =
long offset)
 #define BT_INSN(insn, format, ...)				\
 ({								\
 	if (opts.verbose || opts.backtrace) {			\
-		struct instruction *_insn =3D (insn);		\
-		char *_str =3D offstr(_insn->sec, _insn->offset); \
-		WARN("  %s: " format, _str, ##__VA_ARGS__);	\
-		free(_str);					\
+		struct instruction *__insn =3D (insn);		\
+		char *_str =3D offstr(__insn->sec, __insn->offset); \
+		const char *_istr =3D objtool_disas_insn(__insn);	\
+		int _len;					\
+		_len =3D snprintf(NULL, 0, "  %s: " format,  _str, ##__VA_ARGS__);	\
+		_len =3D (_len < 50) ? 50 - _len : 0;		\
+		WARN("  %s: " format "  %*s%s", _str, ##__VA_ARGS__, _len, "", _istr); \
+		free(_str);						\
 	}							\
 })
=20

