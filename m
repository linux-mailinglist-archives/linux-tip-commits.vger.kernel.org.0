Return-Path: <linux-tip-commits+bounces-5261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFBAAC174
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 12:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507077A3031
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B612727814C;
	Tue,  6 May 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHMKUvCn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUgfuk6q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5D21B91D;
	Tue,  6 May 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527737; cv=none; b=d8vLptoKhcvuc07AZod+Vz/A+ni5pwgNvIIieBeu/BV7lyXbrOYLW/3jM4iuL2MlAx/itHS3fWoS6fM1IoH++SSE7cnI2WGPZQctqJ3Wa9zPQIJGze/eazDToSbM0M0ZWq39CyQpmNtJqvkWd+kGybdsEv4//kQX7GIL7/ZiXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527737; c=relaxed/simple;
	bh=TQtzQdiqCeD3RSHHP/jQ5+cE/iF+3v7oNj3O5aqa6e0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lnZWN1pJAfnkpP+0xU4/IMr/S4//MRv+vxFqKxAp/DXV6L7yUH3+f9EqKb/co5sKbtGgc20XvcNDbS/fuc0AHVuBMOhst59oImFkkGvTvwlj0y7EG0e9GQPa0fo6VL99hpCyuEuet80tDE/PXSoAwtkhg6j0PdDozAHbDfE2ZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHMKUvCn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUgfuk6q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 10:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746527732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOKgJjvhlTs9nJg0Fm6lf7lNJASwwWQ8mrHv70dov6s=;
	b=YHMKUvCncN/ghPbhl1MUGQnsBhIB785aB0GpfDGgZ8Ck4b7uUeA/QIj7tITKLcWy+UTDZh
	WRHFmUOlnOBKLTjRVWK7rZEZ6Zoy8++RvCeWUVLxB+o8mIJInQCPwX9fSG9AtDZ8KV468x
	JwhM5j5TCozqAZ7iJSLSznqzu1cb/Y8hDOXk8HobIr7HuYlY8gAwsarPecn8AeI5ynjazB
	2QUJry3MLH5qylz8IpJTswAWOp5Ah9IOJuwLp0kUhArUCit+vQYtJd6W7ceV4uGS4aaHYJ
	I4QlO1hvwMthDpzOwctNuyowctgwkx3cv1bDV3XSMLsffxecAIj05/CSq9SKGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746527732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOKgJjvhlTs9nJg0Fm6lf7lNJASwwWQ8mrHv70dov6s=;
	b=MUgfuk6qc0bSJPk1pikp5thfAXb/nlAXAVck1R927vwBZDtMwpIsQLrFVQ+m8tacX5cuNr
	Pc8dSioCnwskgPDw==
From: "tip-bot2 for Masami Hiramatsu (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/insn: Stop decoding i64 instructions in x86-64
 mode at opcode
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <174580490000.388420.5225447607417115496.stgit@devnote2>
References: <174580490000.388420.5225447607417115496.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174652773170.406.15067062455529942136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4b626015e1bf119cd31d7e62f9bd9eb1412fce7b
Gitweb:        https://git.kernel.org/tip/4b626015e1bf119cd31d7e62f9bd9eb1412fce7b
Author:        Masami Hiramatsu (Google) <mhiramat@kernel.org>
AuthorDate:    Mon, 28 Apr 2025 10:48:20 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 12:03:16 +02:00

x86/insn: Stop decoding i64 instructions in x86-64 mode at opcode

In commit 2e044911be75 ("x86/traps: Decode 0xEA instructions as #UD")
FineIBT starts using 0xEA as an invalid instruction like UD2. But
insn decoder always returns the length of "0xea" instruction as 7
because it does not check the (i64) superscript.

The x86 instruction decoder should also decode 0xEA on x86-64 as
a one-byte invalid instruction by decoding the "(i64)" superscript tag.

This stops decoding instruction which has (i64) but does not have (o64)
superscript in 64-bit mode at opcode and skips other fields.

With this change, insn_decoder_test says 0xea is 1 byte length if
x86-64 (-y option means 64-bit):

   $ printf "0:\tea\t\n" | insn_decoder_test -y -v
   insn_decoder_test: success: Decoded and checked 1 instructions

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/174580490000.388420.5225447607417115496.stgit@devnote2
---
 arch/x86/include/asm/inat.h                | 6 ++++++
 arch/x86/lib/insn.c                        | 7 ++++++-
 arch/x86/lib/x86-opcode-map.txt            | 6 +++---
 arch/x86/tools/gen-insn-attr-x86.awk       | 7 +++++++
 tools/arch/x86/include/asm/inat.h          | 6 ++++++
 tools/arch/x86/lib/insn.c                  | 7 ++++++-
 tools/arch/x86/lib/x86-opcode-map.txt      | 6 +++---
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 7 +++++++
 8 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 53e4015..97f3417 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -82,6 +82,7 @@
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
 #define INAT_EVEX_SCALABLE	(1 << (INAT_FLAG_OFFS + 10))
+#define INAT_INV64	(1 << (INAT_FLAG_OFFS + 11))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -242,4 +243,9 @@ static inline int inat_evex_scalable(insn_attr_t attr)
 {
 	return attr & INAT_EVEX_SCALABLE;
 }
+
+static inline int inat_is_invalid64(insn_attr_t attr)
+{
+	return attr & INAT_INV64;
+}
 #endif
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 6ffb931..149a57e 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -324,6 +324,11 @@ int insn_get_opcode(struct insn *insn)
 	}
 
 	insn->attr = inat_get_opcode_attribute(op);
+	if (insn->x86_64 && inat_is_invalid64(insn->attr)) {
+		/* This instruction is invalid, like UD2. Stop decoding. */
+		insn->attr &= INAT_INV64;
+	}
+
 	while (inat_is_escape(insn->attr)) {
 		/* Get escaped opcode */
 		op = get_next(insn_byte_t, insn);
@@ -337,6 +342,7 @@ int insn_get_opcode(struct insn *insn)
 		insn->attr = 0;
 		return -EINVAL;
 	}
+
 end:
 	opcode->got = 1;
 	return 0;
@@ -658,7 +664,6 @@ int insn_get_immediate(struct insn *insn)
 	}
 
 	if (!inat_has_immediate(insn->attr))
-		/* no immediates */
 		goto done;
 
 	switch (inat_immediate_size(insn->attr)) {
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index cd3fd51..262f7ca 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -147,7 +147,7 @@ AVXcode:
 # 0x60 - 0x6f
 60: PUSHA/PUSHAD (i64)
 61: POPA/POPAD (i64)
-62: BOUND Gv,Ma (i64) | EVEX (Prefix)
+62: BOUND Gv,Ma (i64) | EVEX (Prefix),(o64)
 63: ARPL Ew,Gw (i64) | MOVSXD Gv,Ev (o64)
 64: SEG=FS (Prefix)
 65: SEG=GS (Prefix)
@@ -253,8 +253,8 @@ c0: Grp2 Eb,Ib (1A)
 c1: Grp2 Ev,Ib (1A)
 c2: RETN Iw (f64)
 c3: RETN
-c4: LES Gz,Mp (i64) | VEX+2byte (Prefix)
-c5: LDS Gz,Mp (i64) | VEX+1byte (Prefix)
+c4: LES Gz,Mp (i64) | VEX+2byte (Prefix),(o64)
+c5: LDS Gz,Mp (i64) | VEX+1byte (Prefix),(o64)
 c6: Grp11A Eb,Ib (1A)
 c7: Grp11B Ev,Iz (1A)
 c8: ENTER Iw,Ib
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index 5770c80..2c19d7f 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -64,6 +64,8 @@ BEGIN {
 
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
+	invalid64_expr = "\\(i64\\)"
+	only64_expr = "\\(o64\\)"
 	rex_expr = "^((REX(\\.[XRWB]+)+)|(REX$))"
 	rex2_expr = "\\(REX2\\)"
 	no_rex2_expr = "\\(!REX2\\)"
@@ -319,6 +321,11 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(ext, force64_expr))
 			flags = add_flags(flags, "INAT_FORCE64")
 
+		# check invalid in 64-bit (and no only64)
+		if (match(ext, invalid64_expr) &&
+		    !match($0, only64_expr))
+			flags = add_flags(flags, "INAT_INV64")
+
 		# check REX2 not allowed
 		if (match(ext, no_rex2_expr))
 			flags = add_flags(flags, "INAT_NO_REX2")
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 253690e..183aa66 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -82,6 +82,7 @@
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
 #define INAT_EVEX_SCALABLE	(1 << (INAT_FLAG_OFFS + 10))
+#define INAT_INV64	(1 << (INAT_FLAG_OFFS + 11))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -242,4 +243,9 @@ static inline int inat_evex_scalable(insn_attr_t attr)
 {
 	return attr & INAT_EVEX_SCALABLE;
 }
+
+static inline int inat_is_invalid64(insn_attr_t attr)
+{
+	return attr & INAT_INV64;
+}
 #endif
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index e91d4c4..bce69c6 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -324,6 +324,11 @@ int insn_get_opcode(struct insn *insn)
 	}
 
 	insn->attr = inat_get_opcode_attribute(op);
+	if (insn->x86_64 && inat_is_invalid64(insn->attr)) {
+		/* This instruction is invalid, like UD2. Stop decoding. */
+		insn->attr &= INAT_INV64;
+	}
+
 	while (inat_is_escape(insn->attr)) {
 		/* Get escaped opcode */
 		op = get_next(insn_byte_t, insn);
@@ -337,6 +342,7 @@ int insn_get_opcode(struct insn *insn)
 		insn->attr = 0;
 		return -EINVAL;
 	}
+
 end:
 	opcode->got = 1;
 	return 0;
@@ -658,7 +664,6 @@ int insn_get_immediate(struct insn *insn)
 	}
 
 	if (!inat_has_immediate(insn->attr))
-		/* no immediates */
 		goto done;
 
 	switch (inat_immediate_size(insn->attr)) {
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index cd3fd51..262f7ca 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -147,7 +147,7 @@ AVXcode:
 # 0x60 - 0x6f
 60: PUSHA/PUSHAD (i64)
 61: POPA/POPAD (i64)
-62: BOUND Gv,Ma (i64) | EVEX (Prefix)
+62: BOUND Gv,Ma (i64) | EVEX (Prefix),(o64)
 63: ARPL Ew,Gw (i64) | MOVSXD Gv,Ev (o64)
 64: SEG=FS (Prefix)
 65: SEG=GS (Prefix)
@@ -253,8 +253,8 @@ c0: Grp2 Eb,Ib (1A)
 c1: Grp2 Ev,Ib (1A)
 c2: RETN Iw (f64)
 c3: RETN
-c4: LES Gz,Mp (i64) | VEX+2byte (Prefix)
-c5: LDS Gz,Mp (i64) | VEX+1byte (Prefix)
+c4: LES Gz,Mp (i64) | VEX+2byte (Prefix),(o64)
+c5: LDS Gz,Mp (i64) | VEX+1byte (Prefix),(o64)
 c6: Grp11A Eb,Ib (1A)
 c7: Grp11B Ev,Iz (1A)
 c8: ENTER Iw,Ib
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index 5770c80..2c19d7f 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -64,6 +64,8 @@ BEGIN {
 
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
+	invalid64_expr = "\\(i64\\)"
+	only64_expr = "\\(o64\\)"
 	rex_expr = "^((REX(\\.[XRWB]+)+)|(REX$))"
 	rex2_expr = "\\(REX2\\)"
 	no_rex2_expr = "\\(!REX2\\)"
@@ -319,6 +321,11 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(ext, force64_expr))
 			flags = add_flags(flags, "INAT_FORCE64")
 
+		# check invalid in 64-bit (and no only64)
+		if (match(ext, invalid64_expr) &&
+		    !match($0, only64_expr))
+			flags = add_flags(flags, "INAT_INV64")
+
 		# check REX2 not allowed
 		if (match(ext, no_rex2_expr))
 			flags = add_flags(flags, "INAT_NO_REX2")

