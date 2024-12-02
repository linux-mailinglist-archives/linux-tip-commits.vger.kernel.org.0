Return-Path: <linux-tip-commits+bounces-2943-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98B9E00A3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B614CB2EDC3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297E20C017;
	Mon,  2 Dec 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xj29hMXD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i07xZkKs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F220B800;
	Mon,  2 Dec 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138130; cv=none; b=q9/9pMMpERDt79FMrn9qHn4ffl3e8RpmLGY/xln3dhXMSGWTtASciDTt3fhkGG5ttcjic5/EKbhfXRBwf5SRhXF0KGb75rwMGycm4aXdUNzK7Z5AD1fp5s132181Z3+TuqWwJ9Dx9ksueAt/42AWh/eq0BHgOFCl7Ktq29M8Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138130; c=relaxed/simple;
	bh=OXuTuOpwAC9ir1CsVzSZRQbmPwyO1//JOSpjv9QNjM0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j3pfJeaEKm50puo9GubvuoPLYfIyUc3mM8Ehxf2Sun07csqU4RqQyMMt52OIocTaOZwHe856KZtP5c2/Ea/M+0Af7zLEL/Ewf6oeLOa4jgj1d4smKA2jvTIhAQ/fC5EGwH5PxmjJq6XuO/HxvKBjBTaxRy0xL9NSscwx2w+tThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xj29hMXD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i07xZkKs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZgJ9W9HJSBN5pOK4qnQS51rPwd69cSCljuXSWSAO08=;
	b=xj29hMXDtcd9ljlX/mYnuKiAZ+PN+spgtYIMJp9FnUGPe4t0tHEFExBWqDPaxIGU5HO6Ji
	cytaHCT300mw05FaYoJINXPiUOcl0bnm+oCarQvjfHFUjIittc3pLFJuLJDOnUWBT19apB
	rbRW4xp1oVLWlBZlSl+TpXc0CUHtX8p1FVnoSqEpqczXs28f7M6OJKC5hHbXI/VAqQmMWk
	Iw6yBl2QMxe/DvVh0xE4mxSrEldIEtmnK7D9zu386yViylgvzaKEgnUbqKzOpTmr3D3oc8
	nnjhKDQxcsil5Ukh8z72fPTCtYVNoVN9NIzcvzn5WiLt/ean01OAfM5cS06VJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZgJ9W9HJSBN5pOK4qnQS51rPwd69cSCljuXSWSAO08=;
	b=i07xZkKsGAYH8CMojENutnIup1LSpnJX6wIipTBdZlzmTHDnW3v+20+gWT6kqi3IFqllrJ
	tfmORnlgjTBtmDAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Collapse annotate sequences
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.688871544@infradead.org>
References: <20241128094311.688871544@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812453.412.17242165687956077802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a8a330dd9900024dc18b048c4f0f3c6ad22ff4c1
Gitweb:        https://git.kernel.org/tip/a8a330dd9900024dc18b048c4f0f3c6ad22ff4c1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:42 +01:00

objtool: Collapse annotate sequences

Reduce read_annotate() runs by collapsing subsequent runs into a
single call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.688871544@infradead.org
---
 tools/objtool/check.c | 87 +++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 55 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2222fe7..3bea8b2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2381,21 +2381,24 @@ static int read_annotate(struct objtool_file *file,
 	return 0;
 }
 
-static int __annotate_ignore_alts(struct objtool_file *file, int type, struct instruction *insn)
+static int __annotate_early(struct objtool_file *file, int type, struct instruction *insn)
 {
-	if (type != ANNOTYPE_IGNORE_ALTS)
-		return 0;
+	switch (type) {
+	case ANNOTYPE_IGNORE_ALTS:
+		insn->ignore_alts = true;
+		break;
 
-	insn->ignore_alts = true;
-	return 0;
-}
+	/*
+	 * Must be before read_unwind_hints() since that needs insn->noendbr.
+	 */
+	case ANNOTYPE_NOENDBR:
+		insn->noendbr = 1;
+		break;
 
-static int __annotate_noendbr(struct objtool_file *file, int type, struct instruction *insn)
-{
-	if (type != ANNOTYPE_NOENDBR)
-		return 0;
+	default:
+		break;
+	}
 
-	insn->noendbr = 1;
 	return 0;
 }
 
@@ -2429,26 +2432,21 @@ static int __annotate_ifc(struct objtool_file *file, int type, struct instructio
 	return 0;
 }
 
-static int __annotate_retpoline_safe(struct objtool_file *file, int type, struct instruction *insn)
+static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
-	if (type != ANNOTYPE_RETPOLINE_SAFE)
-		return 0;
-
-	if (insn->type != INSN_JUMP_DYNAMIC &&
-	    insn->type != INSN_CALL_DYNAMIC &&
-	    insn->type != INSN_RETURN &&
-	    insn->type != INSN_NOP) {
-		WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
-		return -1;
-	}
+	switch (type) {
+	case ANNOTYPE_RETPOLINE_SAFE:
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC &&
+		    insn->type != INSN_RETURN &&
+		    insn->type != INSN_NOP) {
+			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
+			return -1;
+		}
 
-	insn->retpoline_safe = true;
-	return 0;
-}
+		insn->retpoline_safe = true;
+		break;
 
-static int __annotate_instr(struct objtool_file *file, int type, struct instruction *insn)
-{
-	switch (type) {
 	case ANNOTYPE_INSTR_BEGIN:
 		insn->instr++;
 		break;
@@ -2457,6 +2455,10 @@ static int __annotate_instr(struct objtool_file *file, int type, struct instruct
 		insn->instr--;
 		break;
 
+	case ANNOTYPE_UNRET_BEGIN:
+		insn->unret = 1;
+		break;
+
 	default:
 		break;
 	}
@@ -2464,16 +2466,6 @@ static int __annotate_instr(struct objtool_file *file, int type, struct instruct
 	return 0;
 }
 
-static int __annotate_unret(struct objtool_file *file, int type, struct instruction *insn)
-{
-	if (type != ANNOTYPE_UNRET_BEGIN)
-		return 0;
-
-	insn->unret = 1;
-	return 0;
-
-}
-
 /*
  * Return true if name matches an instrumentation function, where calls to that
  * function from noinstr code can safely be removed, but compilers won't do so.
@@ -2583,14 +2575,7 @@ static int decode_sections(struct objtool_file *file)
 	add_ignores(file);
 	add_uaccess_safe(file);
 
-	ret = read_annotate(file, __annotate_ignore_alts);
-	if (ret)
-		return ret;
-
-	/*
-	 * Must be before read_unwind_hints() since that needs insn->noendbr.
-	 */
-	ret = read_annotate(file, __annotate_noendbr);
+	ret = read_annotate(file, __annotate_early);
 	if (ret)
 		return ret;
 
@@ -2636,15 +2621,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_annotate(file, __annotate_retpoline_safe);
-	if (ret)
-		return ret;
-
-	ret = read_annotate(file, __annotate_instr);
-	if (ret)
-		return ret;
-
-	ret = read_annotate(file, __annotate_unret);
+	ret = read_annotate(file, __annotate_late);
 	if (ret)
 		return ret;
 

