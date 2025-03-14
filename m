Return-Path: <linux-tip-commits+bounces-4219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F65BA61C11
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0559C3B3B23
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D3206F34;
	Fri, 14 Mar 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJm5qerk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9M6D45MY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C32063EE;
	Fri, 14 Mar 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982649; cv=none; b=fP97yU/n7vETcFf6RzexI0rz7neZ5KeSxCLYv/kxGlkAFmenL+H+5ZDi0XVzOKVZGYl1z+Wt+LE23pxbUsxBpDPupycEpVgfoVMxnolxQ+dQOlKoVyfPOTxJGvNVWepA+YFr7OnyRGz0O9VoNAVC3aG98YuF9OTkTcwLdeh3ox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982649; c=relaxed/simple;
	bh=HDbWK1gwIEjHe+zB6vM0eiOaTbLJsaCKesDaQb1Q57s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=awJfq2JKTTl8gqXdTbvqn8lXPxMVLqSgTlFp2/Gi6Gkc/4muat63BGGqinakpFUJH1CxxIlSmRpmBFNEAjty2gKqpDtyN/dpkDW0fHsqEOSiiU7GbE9igUExju34hrjIyl7QmegIwN9pK6IEh+0YKfZcewsIxot+y2TgNo9eaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJm5qerk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9M6D45MY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsEsWMvF0ZSMDB7EHzPcvunnquKEuUu7AwKLjFuizNY=;
	b=cJm5qerk+/Cowfb3o7drxt5iWW0L1LENG0Y3G5ymmdCV3hcKOYMTKW2p7OKMmzt6eGfUQ9
	8G5TNQBk0Xf98isAGa67uFWmW8dhBQrxlyauPD/osSuEbRV8j5dYwtGBKQ+zc8zooYPPVx
	8C/61xIeZzP6qz10cJzyukGHVnMahjU7Q4HYAGXG+KptQRDd2JPL8M5sWk09nXXKsWeHJZ
	qwBCHDzYy958/sxq13ULdi5c1ZcVcGbX41kdtFDCoP0y69PSN5AF4utd1cavKYeWE+6VCp
	QEJsnh4kKaRXZqUcphqY8QH+64VbYCHYlsD3Ny5PxBncjpBDu91U9yA3BQJBlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsEsWMvF0ZSMDB7EHzPcvunnquKEuUu7AwKLjFuizNY=;
	b=9M6D45MYpI6kTtAU9uU7OUTIw4HEhPl22yYVQQZy85Y9MJv2GJqgnO1915bhVHAubSLo7v
	dZtzzxZcxc15aEDg==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Handle various symbol types of rodata
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211115016.26913-2-yangtiezhu@loongson.cn>
References: <20250211115016.26913-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198264378.14745.7475966821311554479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ab6ce22b789622ca732e91cbb3a5cb5ba370cbd0
Gitweb:        https://git.kernel.org/tip/ab6ce22b789622ca732e91cbb3a5cb5ba370cbd0
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 11 Feb 2025 19:50:10 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:38 -07:00

objtool: Handle various symbol types of rodata

In the relocation section ".rela.rodata" of each .o file compiled with
LoongArch toolchain, there are various symbol types such as STT_NOTYPE,
STT_OBJECT, STT_FUNC in addition to the usual STT_SECTION, it needs to
use reloc symbol offset instead of reloc addend to find the destination
instruction in find_jump_table() and add_jump_table().

For the most part, an absolute relocation type is used for rodata. In the
case of STT_SECTION, reloc->sym->offset is always zero, and for the other
symbol types, reloc_addend(reloc) is always zero, thus it can use a simple
statement "reloc->sym->offset + reloc_addend(reloc)" to obtain the symbol
offset for various symbol types.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20250211115016.26913-2-yangtiezhu@loongson.cn
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ce973d9..cfab4a1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1954,6 +1954,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	unsigned int prev_offset = 0;
 	struct reloc *reloc = table;
 	struct alternative *alt;
+	unsigned long sym_offset;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -1971,9 +1972,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
 			break;
 
+		sym_offset = reloc->sym->offset + reloc_addend(reloc);
+
 		/* Detect function pointers from contiguous objects: */
-		if (reloc->sym->sec == pfunc->sec &&
-		    reloc_addend(reloc) == pfunc->offset)
+		if (reloc->sym->sec == pfunc->sec && sym_offset == pfunc->offset)
 			break;
 
 		/*
@@ -1981,10 +1983,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		 * which point to the end of the function.  Ignore them.
 		 */
 		if (reloc->sym->sec == pfunc->sec &&
-		    reloc_addend(reloc) == pfunc->offset + pfunc->len)
+		    sym_offset == pfunc->offset + pfunc->len)
 			goto next;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
+		dest_insn = find_insn(file, reloc->sym->sec, sym_offset);
 		if (!dest_insn)
 			break;
 
@@ -2023,6 +2025,7 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 	struct reloc *table_reloc;
 	struct instruction *dest_insn, *orig_insn = insn;
 	unsigned long table_size;
+	unsigned long sym_offset;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -2046,7 +2049,10 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 		table_reloc = arch_find_switch_table(file, insn, &table_size);
 		if (!table_reloc)
 			continue;
-		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
+
+		sym_offset = table_reloc->sym->offset + reloc_addend(table_reloc);
+
+		dest_insn = find_insn(file, table_reloc->sym->sec, sym_offset);
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 

