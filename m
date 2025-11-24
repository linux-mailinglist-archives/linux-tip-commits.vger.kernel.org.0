Return-Path: <linux-tip-commits+bounces-7502-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFFC7F879
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22CB9349A1D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6F2FE570;
	Mon, 24 Nov 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wsF7nO7z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fa+6j/2Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AB2FDC4B;
	Mon, 24 Nov 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975523; cv=none; b=G3qGw+g3KnuVwOCpLXqkVwTnjFhWpivTlRAU0SvPBJIQ1lybFOWlR9bPti6jryoTmB3wI4BktrCk8otozK6z4S5XnthWDnHo8LvOB9VLCRPbxVWLRE5u1x2rksGBrzrP+SiLQmlk7TdxVeN4R9Z2yXht9A0aMTskk17K9t22YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975523; c=relaxed/simple;
	bh=w7Lwcc59l4I+V4B8rw3soVcaqyDSbbPoaQH9rsptAgY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=twmJz1JIanb48w6RGt2gfnelNe9n9bU0ejrNU52nhVfxFnvsIqaqkk7MrmCqfFLUp426uz/7Ke3xvPI4dV7jIE6Gh0jwkzG3bGbFS5Cr6M5UQB4a6TxCCxesP82Php6mZpmOqEFWzoByDqeHuBlzMwGYppmB7eEh+nyMD9WMx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wsF7nO7z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fa+6j/2Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVyVx0jCuYWQ2HYL50Zq0qNK1WrSM0m2ZN1Eeb/HDG8=;
	b=wsF7nO7zdWTVVrJSEatIpM9jRyLthmLNRW5uYHWKHCL+solbEDRcPAD7KpE4+mb9zBkmHz
	uwNbU4ejtHQxkPA6/eGmSU7G1z6eY2GxZoHeDJEJk/V6GYb36UW9OZsMCki010LyPYjGAY
	IlDfaFiU+i3hKNkInOFfx1C1meTiUHZ6vDRGnaeRjn0qDIPjwIz3736OBq0kjttQynkjJe
	yaFScUNTThmj4AgTmI+G7RqQJZ/4DT+L7L8WTQgeamJm0t79+VfQv4oLzkK/GtaeoTu2fm
	CLJmKwL91Z2T5Jij+iQbXcI/Xktw4/HDJsnIzCxCRf8vCL+KvdxwQgyrK3fiSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVyVx0jCuYWQ2HYL50Zq0qNK1WrSM0m2ZN1Eeb/HDG8=;
	b=Fa+6j/2QU/lFGxkJIRei5HBpsUIIy3iNvmEmt2DRR4uk6CEr7tddFD3FYIGK60PdBA+O3q
	Qvdmu+T2aTbhbqCg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Store instruction disassembly result
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-7-alexandre.chartre@oracle.com>
References: <20251121095340.464045-7-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551826.498.12418897962062741755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d4e13c21497d0cde73694163908f89d7168c1243
Gitweb:        https://git.kernel.org/tip/d4e13c21497d0cde73694163908f89d7168=
c1243
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:08 +01:00

objtool: Store instruction disassembly result

When disassembling an instruction store the result instead of directly
printing it.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-7-alexandre.chartre@orac=
le.com
---
 tools/objtool/disas.c | 77 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index dee10ab..89daa12 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -12,9 +12,16 @@
 #include <linux/string.h>
 #include <tools/dis-asm-compat.h>
=20
+/*
+ * Size of the buffer for storing the result of disassembling
+ * a single instruction.
+ */
+#define DISAS_RESULT_SIZE	1024
+
 struct disas_context {
 	struct objtool_file *file;
 	struct instruction *insn;
+	char result[DISAS_RESULT_SIZE];
 	disassembler_ftype disassembler;
 	struct disassemble_info info;
 };
@@ -34,6 +41,59 @@ static int sprint_name(char *str, const char *name, unsign=
ed long offset)
 #define DINFO_FPRINTF(dinfo, ...)	\
 	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
=20
+static int disas_result_fprintf(struct disas_context *dctx,
+				const char *fmt, va_list ap)
+{
+	char *buf =3D dctx->result;
+	int avail, len;
+
+	len =3D strlen(buf);
+	if (len >=3D DISAS_RESULT_SIZE - 1) {
+		WARN_FUNC(dctx->insn->sec, dctx->insn->offset,
+			  "disassembly buffer is full");
+		return -1;
+	}
+	avail =3D DISAS_RESULT_SIZE - len;
+
+	len =3D vsnprintf(buf + len, avail, fmt, ap);
+	if (len < 0 || len >=3D avail) {
+		WARN_FUNC(dctx->insn->sec, dctx->insn->offset,
+			  "disassembly buffer is truncated");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int disas_fprintf(void *stream, const char *fmt, ...)
+{
+	va_list arg;
+	int rv;
+
+	va_start(arg, fmt);
+	rv =3D disas_result_fprintf(stream, fmt, arg);
+	va_end(arg);
+
+	return rv;
+}
+
+/*
+ * For init_disassemble_info_compat().
+ */
+static int disas_fprintf_styled(void *stream,
+				enum disassembler_style style,
+				const char *fmt, ...)
+{
+	va_list arg;
+	int rv;
+
+	va_start(arg, fmt);
+	rv =3D disas_result_fprintf(stream, fmt, arg);
+	va_end(arg);
+
+	return rv;
+}
+
 static void disas_print_addr_sym(struct section *sec, struct symbol *sym,
 				 bfd_vma addr, struct disassemble_info *dinfo)
 {
@@ -195,9 +255,8 @@ struct disas_context *disas_context_create(struct objtool=
_file *file)
 	dctx->file =3D file;
 	dinfo =3D &dctx->info;
=20
-	init_disassemble_info_compat(dinfo, stdout,
-				     (fprintf_ftype)fprintf,
-				     fprintf_styled);
+	init_disassemble_info_compat(dinfo, dctx,
+				     disas_fprintf, disas_fprintf_styled);
=20
 	dinfo->read_memory_func =3D buffer_read_memory;
 	dinfo->print_address_func =3D disas_print_address;
@@ -244,6 +303,11 @@ void disas_context_destroy(struct disas_context *dctx)
 	free(dctx);
 }
=20
+static char *disas_result(struct disas_context *dctx)
+{
+	return dctx->result;
+}
+
 /*
  * Disassemble a single instruction. Return the size of the instruction.
  */
@@ -254,6 +318,7 @@ static size_t disas_insn(struct disas_context *dctx,
 	struct disassemble_info *dinfo =3D &dctx->info;
=20
 	dctx->insn =3D insn;
+	dctx->result[0] =3D '\0';
=20
 	if (insn->type =3D=3D INSN_NOP) {
 		DINFO_FPRINTF(dinfo, "nop%d", insn->len);
@@ -282,10 +347,10 @@ static void disas_func(struct disas_context *dctx, stru=
ct symbol *func)
 	printf("%s:\n", func->name);
 	sym_for_each_insn(dctx->file, func, insn) {
 		addr =3D insn->offset;
-		printf(" %6lx:  %s+0x%-6lx      ",
-		       addr, func->name, addr - func->offset);
 		disas_insn(dctx, insn);
-		printf("\n");
+		printf(" %6lx:  %s+0x%-6lx      %s\n",
+		       addr, func->name, addr - func->offset,
+		       disas_result(dctx));
 	}
 	printf("\n");
 }

