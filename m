Return-Path: <linux-tip-commits+bounces-7494-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1108C7F857
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4833A829C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E732FBE1B;
	Mon, 24 Nov 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lARFuHCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9OL6O5Ip"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A72FB97E;
	Mon, 24 Nov 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975515; cv=none; b=cCvO5AxpOGV5EGgy41M6iLD80CscIXRFno5yXX8B8a4ijsd/sXlWqUjrsKCO3kYvd6VYWaiEyYtvh74ghP5gvrcNusAw/lsXAlMW/jKyz75MpKjZvhNaDRZtt3Lxx3cSLn6r2v4TRVFn6OF7OJvFk/+FtuIrf5PFAxmVbNBOKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975515; c=relaxed/simple;
	bh=K/BCGn+XPS7kWf/AfHdjtlLUGQsIdOyPSQe8fBdQNtA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uW5q/9nwlZq6hvoOl38igq925slBaVoBM0cKWf2MIZ5Q3oWzT09XPZcd19FZD7I8h6bzC0tWpc1Dj6gmmXK2UpRes0iGpidWpQcWT4wGUewX+0A05LmelXAfdZjpjmsAoAljSqXB7ilog6RwlAsViqGG0BeBa0GPJX+FTrLDd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lARFuHCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9OL6O5Ip; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIvUUlpialFzz3jukfzgJ/vbMrxg2WRDY4YMNNkTCe8=;
	b=lARFuHCzzfhrPWpiuASlcBqzxs/sa863x52olRT9L6FHoZg3S2bwkrs3VqyXJFAq/9Sz7t
	oFT0qAFs8Kb4YBqvpApKR82SqfUZ5ed6Jo90GD7rOJDSiADAW/VnL3+jbH3/tSv0i2PBpe
	azXFybJTSAcpY+PN4SwyHVhzyDSEFz1XJoo24GFL8tChUSTcnUJ4CPINDcmU+/GDnF3fAD
	HwUzYMiku3AavzQxGYyTXgPtzamUhKTNJzYpa0oOKWAxudbPvyeWrijknNhLLBKLeVRUqU
	g582pcLRhyqTnUqgrk8O85WfLAQC/JsiFR9HwYB1V6xfna0MGGf4bOPJLkv5Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIvUUlpialFzz3jukfzgJ/vbMrxg2WRDY4YMNNkTCe8=;
	b=9OL6O5IpLDXvANk59C72eysk59eBCpE4RM8r3ucBKbUiUtNP0jNRORlB1ehmAgr/mH7u+D
	leKTjciWpvb02KCw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Add functions to better name alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-15-alexandre.chartre@oracle.com>
References: <20251121095340.464045-15-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551002.498.4677447721640869133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9b580accac003767a461bf52d738ad1ab4e8ccfa
Gitweb:        https://git.kernel.org/tip/9b580accac003767a461bf52d738ad1ab4e=
8ccfa
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:11 +01:00

objtool: Add functions to better name alternatives

Add the disas_alt_name() and disas_alt_type_name() to provide a
name and a type name for an alternative. This will be used to
better name alternatives when tracing their execution.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-15-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c                 | 72 ++++++++++++++++++++++++++-
 tools/objtool/include/objtool/disas.h | 12 ++++-
 2 files changed, 84 insertions(+)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 0ca6e6c..b53be24 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
=20
+#define _GNU_SOURCE
+
 #include <objtool/arch.h>
 #include <objtool/check.h>
 #include <objtool/disas.h>
@@ -451,6 +453,76 @@ size_t disas_insn(struct disas_context *dctx, struct ins=
truction *insn)
 }
=20
 /*
+ * Provide a name for the type of alternatives present at the
+ * specified instruction.
+ *
+ * An instruction can have alternatives with different types, for
+ * example alternative instructions and an exception table. In that
+ * case the name for the alternative instructions type is used.
+ *
+ * Return NULL if the instruction as no alternative.
+ */
+const char *disas_alt_type_name(struct instruction *insn)
+{
+	struct alternative *alt;
+	const char *name;
+
+	name =3D NULL;
+	for (alt =3D insn->alts; alt; alt =3D alt->next) {
+		if (alt->type =3D=3D ALT_TYPE_INSTRUCTIONS) {
+			name =3D "alternative";
+			break;
+		}
+
+		switch (alt->type) {
+		case ALT_TYPE_EX_TABLE:
+			name =3D "ex_table";
+			break;
+		case ALT_TYPE_JUMP_TABLE:
+			name =3D "jump_table";
+			break;
+		default:
+			name =3D "unknown";
+			break;
+		}
+	}
+
+	return name;
+}
+
+/*
+ * Provide a name for an alternative.
+ */
+char *disas_alt_name(struct alternative *alt)
+{
+	char *str =3D NULL;
+
+	switch (alt->type) {
+
+	case ALT_TYPE_EX_TABLE:
+		str =3D strdup("EXCEPTION");
+		break;
+
+	case ALT_TYPE_JUMP_TABLE:
+		str =3D strdup("JUMP");
+		break;
+
+	case ALT_TYPE_INSTRUCTIONS:
+		/*
+		 * This is a non-default group alternative. Create a unique
+		 * name using the offset of the first original and alternative
+		 * instructions.
+		 */
+		asprintf(&str, "ALTERNATIVE %lx.%lx",
+			 alt->insn->alt_group->orig_group->first_insn->offset,
+			 alt->insn->alt_group->first_insn->offset);
+		break;
+	}
+
+	return str;
+}
+
+/*
  * Disassemble a function.
  */
 static void disas_func(struct disas_context *dctx, struct symbol *func)
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/ob=
jtool/disas.h
index 5db75d0..8959d4c 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -6,6 +6,7 @@
 #ifndef _DISAS_H
 #define _DISAS_H
=20
+struct alternative;
 struct disas_context;
 struct disassemble_info;
=20
@@ -24,6 +25,8 @@ void disas_print_info(FILE *stream, struct instruction *ins=
n, int depth,
 void disas_print_insn(FILE *stream, struct disas_context *dctx,
 		      struct instruction *insn, int depth,
 		      const char *format, ...);
+char *disas_alt_name(struct alternative *alt);
+const char *disas_alt_type_name(struct instruction *insn);
=20
 #else /* DISAS */
=20
@@ -61,6 +64,15 @@ static inline void disas_print_info(FILE *stream, struct i=
nstruction *insn,
 static inline void disas_print_insn(FILE *stream, struct disas_context *dctx,
 				    struct instruction *insn, int depth,
 				    const char *format, ...) {}
+static inline char *disas_alt_name(struct alternative *alt)
+{
+	return NULL;
+}
+
+static inline const char *disas_alt_type_name(struct instruction *insn)
+{
+	return NULL;
+}
=20
 #endif /* DISAS */
=20

