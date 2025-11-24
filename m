Return-Path: <linux-tip-commits+bounces-7497-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A59C7F83F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C994E428A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9202FD1B0;
	Mon, 24 Nov 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaW7FVk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rsuk5Y7q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F82FC00B;
	Mon, 24 Nov 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975517; cv=none; b=lBk1EfwUPT9pf4GCAti83n9SBPzSvZh2s0ba0Epqz9Y7nqNqzalU80v6WZYfV8wtk9z0GhU2p3eLauEUnih3WQC1aIG7dM1V4k+ztb7N9oWzeBXkVAJKoaSAxMV8S7xK5PUA2ncVEjohaVQOaWYgfyUikvr7bMPVVC/SL3kVd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975517; c=relaxed/simple;
	bh=G3Pbeea0o3wrB5AiD1+yrqcRFb6kyD1+mb9uBc8KOBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=txoqgN7DmzoNVDWjCP3M5xfR7/LN2aRXz4PPS5fsZWeZ1TqNmB4EvuoUzU/1wYAudA5rVhk3fHeuuzrX1X3g8MaWibfgphILU9TiWQ+6h8O7xgNkl7oXYL9Y4E6N4i6Vik1APSCS6kfPaU7Ta/PweyY6/jsYzrlmx8zony+rrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaW7FVk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rsuk5Y7q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8dPjCCZ8FuQkUuKBVQfRBspqBtBaKV6Q0Fd5uNCrnw=;
	b=FaW7FVk2hCsNsTcg+7d6A1vEliuUkSg41NtZw4z9T2qGxQ8T28bf/ljmwYocxzu4tjp2R/
	mivuWgr8SX+NWDB6V7mB9ddDaVc0SYnyIrl/rZbRiUiwgEMXcob7oh8pdtELRnCwmrIvek
	ovenahIhGz9gTnaW6hk/yl30zlBqWDqpGV4pFGqtR4mTchAmkuNNGgUpJYTohmr3lfMi6M
	r8MjblEH+qGlzbILY4q1C840qF6ZHMOZsh5AKmadbEZLq0tr88Qc8qR/EOPgOGJmyvu731
	vWF3iu2Eg1EDFMUF5dY4nyJhbsLSTWsnnNzxqZaG8amSY6Tow+hg2aprrYw9BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8dPjCCZ8FuQkUuKBVQfRBspqBtBaKV6Q0Fd5uNCrnw=;
	b=Rsuk5Y7qlt3PCtsu30CbhZmRSwTulpLXMbCFF2DTlnQ4eHVdo6DfSy9elkfJDvyBWvbNdH
	tRolfvVBGeeMaHBQ==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Trace instruction state changes during
 function validation
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-12-alexandre.chartre@oracle.com>
References: <20251121095340.464045-12-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551301.498.2739778938222791183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fcb268b47a2f4a497fdb40ef24bb9e06488b7213
Gitweb:        https://git.kernel.org/tip/fcb268b47a2f4a497fdb40ef24bb9e06488=
b7213
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:10 +01:00

objtool: Trace instruction state changes during function validation

During function validation, objtool maintains a per-instruction state,
in particular to track call frame information. When tracing validation,
print any instruction state changes.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-12-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c                 |   8 +-
 tools/objtool/include/objtool/trace.h |  10 ++-
 tools/objtool/trace.c                 | 132 +++++++++++++++++++++++++-
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 409dec9..a02f8db 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3677,6 +3677,8 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 			 struct instruction *prev_insn, struct instruction *next_insn,
 			 bool *dead_end)
 {
+	/* prev_state is not used if there is no disassembly support */
+	struct insn_state prev_state __maybe_unused;
 	struct alternative *alt;
 	u8 visited;
 	int ret;
@@ -3785,7 +3787,11 @@ static int validate_insn(struct objtool_file *file, st=
ruct symbol *func,
 	if (skip_alt_group(insn))
 		return 0;
=20
-	if (handle_insn_ops(insn, next_insn, statep))
+	prev_state =3D *statep;
+	ret =3D handle_insn_ops(insn, next_insn, statep);
+	TRACE_INSN_STATE(insn, &prev_state, statep);
+
+	if (ret)
 		return 1;
=20
 	switch (insn->type) {
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/ob=
jtool/trace.h
index 3f3c830..33fe9c6 100644
--- a/tools/objtool/include/objtool/trace.h
+++ b/tools/objtool/include/objtool/trace.h
@@ -30,6 +30,12 @@ extern int trace_depth;
 	}							\
 })
=20
+#define TRACE_INSN_STATE(insn, sprev, snext)			\
+({								\
+	if (trace)						\
+		trace_insn_state(insn, sprev, snext);		\
+})
+
 static inline void trace_enable(void)
 {
 	trace =3D true;
@@ -53,10 +59,14 @@ static inline void trace_depth_dec(void)
 		trace_depth--;
 }
=20
+void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
+		      struct insn_state *snext);
+
 #else /* DISAS */
=20
 #define TRACE(fmt, ...) ({})
 #define TRACE_INSN(insn, fmt, ...) ({})
+#define TRACE_INSN_STATE(insn, sprev, snext) ({})
=20
 static inline void trace_enable(void) {}
 static inline void trace_disable(void) {}
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
index 134cc33..12bbad0 100644
--- a/tools/objtool/trace.c
+++ b/tools/objtool/trace.c
@@ -7,3 +7,135 @@
=20
 bool trace;
 int trace_depth;
+
+/*
+ * Macros to trace CFI state attributes changes.
+ */
+
+#define TRACE_CFI_ATTR(attr, prev, next, fmt, ...)		\
+({								\
+	if ((prev)->attr !=3D (next)->attr)			\
+		TRACE("%s=3D" fmt " ", #attr, __VA_ARGS__);	\
+})
+
+#define TRACE_CFI_ATTR_BOOL(attr, prev, next)			\
+	TRACE_CFI_ATTR(attr, prev, next,			\
+		       "%s", (next)->attr ? "true" : "false")
+
+#define TRACE_CFI_ATTR_NUM(attr, prev, next, fmt)		\
+	TRACE_CFI_ATTR(attr, prev, next, fmt, (next)->attr)
+
+#define CFI_REG_NAME_MAXLEN   16
+
+/*
+ * Return the name of a register. Note that the same static buffer
+ * is returned if the name is dynamically generated.
+ */
+static const char *cfi_reg_name(unsigned int reg)
+{
+	static char rname_buffer[CFI_REG_NAME_MAXLEN];
+
+	switch (reg) {
+	case CFI_UNDEFINED:
+		return "<undefined>";
+	case CFI_CFA:
+		return "cfa";
+	case CFI_SP_INDIRECT:
+		return "(sp)";
+	case CFI_BP_INDIRECT:
+		return "(bp)";
+	}
+
+	if (snprintf(rname_buffer, CFI_REG_NAME_MAXLEN, "r%d", reg) =3D=3D -1)
+		return "<error>";
+
+	return (const char *)rname_buffer;
+}
+
+/*
+ * Functions and macros to trace CFI registers changes.
+ */
+
+static void trace_cfi_reg(const char *prefix, int reg, const char *fmt,
+			  int base_prev, int offset_prev,
+			  int base_next, int offset_next)
+{
+	char *rname;
+
+	if (base_prev =3D=3D base_next && offset_prev =3D=3D offset_next)
+		return;
+
+	if (prefix)
+		TRACE("%s:", prefix);
+
+	if (base_next =3D=3D CFI_UNDEFINED) {
+		TRACE("%1$s=3D<undef> ", cfi_reg_name(reg));
+	} else {
+		rname =3D strdup(cfi_reg_name(reg));
+		TRACE(fmt, rname, cfi_reg_name(base_next), offset_next);
+		free(rname);
+	}
+}
+
+static void trace_cfi_reg_val(const char *prefix, int reg,
+			      int base_prev, int offset_prev,
+			      int base_next, int offset_next)
+{
+	trace_cfi_reg(prefix, reg, "%1$s=3D%2$s%3$+d ",
+		      base_prev, offset_prev, base_next, offset_next);
+}
+
+static void trace_cfi_reg_ref(const char *prefix, int reg,
+			      int base_prev, int offset_prev,
+			      int base_next, int offset_next)
+{
+	trace_cfi_reg(prefix, reg, "%1$s=3D(%2$s%3$+d) ",
+		      base_prev, offset_prev, base_next, offset_next);
+}
+
+#define TRACE_CFI_REG_VAL(reg, prev, next)				\
+	trace_cfi_reg_val(NULL, reg, prev.base, prev.offset,		\
+			  next.base, next.offset)
+
+#define TRACE_CFI_REG_REF(reg, prev, next)				\
+	trace_cfi_reg_ref(NULL, reg, prev.base, prev.offset,		\
+			  next.base, next.offset)
+
+void trace_insn_state(struct instruction *insn, struct insn_state *sprev,
+		      struct insn_state *snext)
+{
+	struct cfi_state *cprev, *cnext;
+	int i;
+
+	if (!memcmp(sprev, snext, sizeof(struct insn_state)))
+		return;
+
+	cprev =3D &sprev->cfi;
+	cnext =3D &snext->cfi;
+
+	disas_print_insn(stderr, objtool_disas_ctx, insn,
+			 trace_depth - 1, "state: ");
+
+	/* print registers changes */
+	TRACE_CFI_REG_VAL(CFI_CFA, cprev->cfa, cnext->cfa);
+	for (i =3D 0; i < CFI_NUM_REGS; i++) {
+		TRACE_CFI_REG_VAL(i, cprev->vals[i], cnext->vals[i]);
+		TRACE_CFI_REG_REF(i, cprev->regs[i], cnext->regs[i]);
+	}
+
+	/* print attributes changes */
+	TRACE_CFI_ATTR_NUM(stack_size, cprev, cnext, "%d");
+	TRACE_CFI_ATTR_BOOL(drap, cprev, cnext);
+	if (cnext->drap) {
+		trace_cfi_reg_val("drap", cnext->drap_reg,
+				  cprev->drap_reg, cprev->drap_offset,
+				  cnext->drap_reg, cnext->drap_offset);
+	}
+	TRACE_CFI_ATTR_BOOL(bp_scratch, cprev, cnext);
+	TRACE_CFI_ATTR_NUM(instr, sprev, snext, "%d");
+	TRACE_CFI_ATTR_NUM(uaccess_stack, sprev, snext, "%u");
+
+	TRACE("\n");
+
+	insn->trace =3D 1;
+}

