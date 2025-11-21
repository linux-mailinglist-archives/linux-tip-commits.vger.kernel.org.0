Return-Path: <linux-tip-commits+bounces-7443-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5FC78510
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 498BB4EF064
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB28A34405F;
	Fri, 21 Nov 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBUde/Mp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aF0jJD5I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF641344043;
	Fri, 21 Nov 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719065; cv=none; b=GXAfsPLifwSLJffLj55+0NZ2Ew7ZnPzyT4qdxQO4GaKMnSC6ioQ8h9O8l9DL2o0W+zhmGpv5paSwpYL6EXCbh88Lyb5YSjWsCcMLd7z+vweRpNSv3bVlq1XRLnVm/Lloa+t9XYAT1z2lTeVRrlyFx0t6z8vwxFNKbfpSF5G19js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719065; c=relaxed/simple;
	bh=JeR/GRbi9Pl+yPtMd213YbdOevrKLotPEWbXMuuhJzA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IUlqr+uv1xpiWcFPyQPSU/mIe0UGiy2m2Gt8PZiHEBlG1yLjmJCiVZ253U0OS4k9hSI++IefBF10PRRnkv1uIqWaOPC477z36F1DykDc03ORXAuIRCr0PhoG7gicdnelB4higdEugKQiekRea7E76Q7zRA2gGDehAl6m6dbHG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBUde/Mp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aF0jJD5I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xLCHEc//NXpkA/2MiTT5j0t2WdtPt12BQfYBTbn8gQ=;
	b=iBUde/Mp7fuJ+Z+72qS4kunEWH9sB+j3VdhjZUvCAJT/JCy9MsXUQpjdlGn5rOMgDY4fHC
	YE+gMweD5k3tWVi2pYOMlXKwzXrOUbjKZxtZmxmJf2NHYEtVj7qOlgaFB+frXERdG5k175
	renrbqX61aMIFGSNLgeEaAVO1qmZgJNa7F5LfWMN/SoC7Bvc4D5WQyPHSPvuEgsNcTfNrX
	k7ZPem0AzEfrCckW16Oo4PNDZo/33e8tS5Lb77xwbxJdPbbDWoZpl9R4efoovLOPxp8tV/
	3w0TGmZE2pmbkq+a5uAfQW+lbMLEBmXKW5XsHDXsKKlHUb3WWkwFJR9A/pJIkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xLCHEc//NXpkA/2MiTT5j0t2WdtPt12BQfYBTbn8gQ=;
	b=aF0jJD5I87Ahq/RZAsTNkaAJ9k3GN3RoebnERS+JILPuIxKDw4d3YqQ3fbL4egbDy8mAzs
	Ix0x+5va0qsz6cCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] Revert "objtool: Warn on functions with ambiguous
 -ffunction-sections section names"
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c7d549d4de8bd1490d106b99630eea5efc69a4dd.1763669451.git.jpoimboe@kernel.org>
References:
 <c7d549d4de8bd1490d106b99630eea5efc69a4dd.1763669451.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371905887.498.4204477685302876780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     11991999a20145b7f8af21202d0cac6b1f90a6e4
Gitweb:        https://git.kernel.org/tip/11991999a20145b7f8af21202d0cac6b1f9=
0a6e4
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:14:21 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:10 +01:00

Revert "objtool: Warn on functions with ambiguous -ffunction-sections section=
 names"

This reverts commit 9c7dc1dd897a1cdcade9566ea4664b03fbabf4a4.

The check-function-names.sh script now provides the function name
checking functionality for all architectures, making the objtool check
redundant.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/c7d549d4de8bd1490d106b99630eea5efc69a4dd.17636=
69451.git.jpoimboe@kernel.org
---
 tools/objtool/Documentation/objtool.txt |  7 +-----
 tools/objtool/check.c                   | 33 +------------------------
 2 files changed, 40 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Document=
ation/objtool.txt
index f88f8d2..9e97fc2 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -456,13 +456,6 @@ the objtool maintainers.
     these special names and does not use module_init() / module_exit()
     macros to create them.
=20
-13. file.o: warning: func() function name creates ambiguity with -ffunctions=
-sections
-
-    Functions named startup(), exit(), split(), unlikely(), hot(), and
-    unknown() are not allowed due to the ambiguity of their section
-    names when compiled with -ffunction-sections.  For more information,
-    see the comment above TEXT_MAIN in include/asm-generic/vmlinux.lds.h.
-
=20
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask objtool maintainers for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1a20ff8..490cf78 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2642,37 +2642,6 @@ static int decode_sections(struct objtool_file *file)
 	return 0;
 }
=20
-/*
- * Certain function names are disallowed due to section name ambiguities
- * introduced by -ffunction-sections.
- *
- * See the comment above TEXT_MAIN in include/asm-generic/vmlinux.lds.h.
- */
-static int validate_function_names(struct objtool_file *file)
-{
-	struct symbol *func;
-	int warnings =3D 0;
-
-	for_each_sym(file->elf, func) {
-		if (!is_func_sym(func))
-			continue;
-
-		if (!strcmp(func->name, "startup")	|| strstarts(func->name, "startup.")	||
-		    !strcmp(func->name, "exit")		|| strstarts(func->name, "exit.")	||
-		    !strcmp(func->name, "split")	|| strstarts(func->name, "split.")	||
-		    !strcmp(func->name, "unlikely")	|| strstarts(func->name, "unlikely.")	=
||
-		    !strcmp(func->name, "hot")		|| strstarts(func->name, "hot.")	||
-		    !strcmp(func->name, "unknown")	|| strstarts(func->name, "unknown.")) {
-
-			WARN("%s() function name creates ambiguity with -ffunction-sections",
-			     func->name);
-			warnings++;
-		}
-	}
-
-	return warnings;
-}
-
 static bool is_special_call(struct instruction *insn)
 {
 	if (insn->type =3D=3D INSN_CALL) {
@@ -4942,8 +4911,6 @@ int check(struct objtool_file *file)
 	if (!nr_insns)
 		goto out;
=20
-	warnings +=3D validate_function_names(file);
-
 	if (opts.retpoline)
 		warnings +=3D validate_retpoline(file);
=20

