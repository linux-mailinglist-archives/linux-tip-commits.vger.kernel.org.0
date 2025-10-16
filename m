Return-Path: <linux-tip-commits+bounces-6898-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F088BE28F7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E494319C6BC8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4DB320CDF;
	Thu, 16 Oct 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONBa48sm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jch/Fjnc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9932F775;
	Thu, 16 Oct 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608388; cv=none; b=ObltEo7gko5uGdUsQUvATKZS8aCp4JciiG87Ht3jx/VeCztf02gHHhaFVLkXK5f3YquBjFu9AkhpazNzBjzOP4wdAzE2vPEalPM+hub8LQA7SBhHiKu1Z0bYXv7NA9LD3BvAml+SuH82Xim1VfGrydXFRRt906MqE8QqReMO6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608388; c=relaxed/simple;
	bh=LfWiEiJEv8/j4pKPQTcxaJRGfXKJLXHHsqxp1V02hco=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T/eMu8OofUR7x1gLP3p/5qOfeNoJdvLkZ54F+5H66yvg7K4nPTmGKcYCdd5ZjctDgAuirwYFQiPWbE8xWPJqQ+gZdqFkB2kExKXsILVKW2/VM0AhLgjG4ysng4oQuy4uPMPgWxCKRHgV7vl3PRaw/X63DIkcfh4cYJRZmmWmc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONBa48sm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jch/Fjnc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6IvGAclcIDRK95/hNHzt8IF5PLZ4s97sfmMFbVzRHcM=;
	b=ONBa48smR/XgHCDYz+O4GVOGSR9Ac6Hxf/qdM6GYECGNpkZHQEDyBMED5tzSLg2sHbhA24
	uRh4uAj7tyDQ8Lu8aSZb9u1dfGfQk5wIxEFbJlroAf9CKEY2eJ6jDAPv3juGkhqDv8GNiw
	1axbz1p6sEc5yrrglAvJ071gQxx+sMmR2vFMh3xgQZKeLTsdBCcEWLQPo+7T4oJMMLtuxQ
	h5ePo7cd6gH/xDKe9y/vpDQ9Q+fBaglDCzv5TcFXRVOCVIoj8pgWUOJHogn3NV1KmUr/Gi
	71ZmK91WsAYJcK5VFj2xMaN7ub1KRtrxjK5zh81DYOLKkX+6yIdqW6iHIAhHRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6IvGAclcIDRK95/hNHzt8IF5PLZ4s97sfmMFbVzRHcM=;
	b=Jch/FjncYGlDJ88vPpHgsnqKUVDSHOXFMgtLVu+p87oC2vPs/FZBHNInPHBI7GCAkQSdEU
	us/6vEf071E8pJAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Add empty symbols to the symbol tree again
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837969.709179.14363639786641644262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     81cf39be3559f3cebef6ad7b0893c06bf5a5847e
Gitweb:        https://git.kernel.org/tip/81cf39be3559f3cebef6ad7b0893c06bf5a=
5847e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:25 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Add empty symbols to the symbol tree again

The following commit

  5da6aea375cd ("objtool: Fix find_{symbol,func}_containing()")

fixed the issue where overlapping symbols weren't getting sorted
properly in the symbol tree.  Therefore the workaround to skip adding
empty symbols from the following commit

  a2e38dffcd93 ("objtool: Don't add empty symbols to the rbtree")

is no longer needed.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 19e249f..a8a78b5 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -96,7 +96,8 @@ static inline unsigned long __sym_last(struct symbol *s)
 }
=20
 INTERVAL_TREE_DEFINE(struct symbol, node, unsigned long, __subtree_last,
-		     __sym_start, __sym_last, static, __sym)
+		     __sym_start, __sym_last, static inline __maybe_unused,
+		     __sym)
=20
 #define __sym_for_each(_iter, _tree, _start, _end)			\
 	for (_iter =3D __sym_iter_first((_tree), (_start), (_end));	\
@@ -440,13 +441,6 @@ static void elf_add_symbol(struct elf *elf, struct symbo=
l *sym)
 	list_add(&sym->list, entry);
 	elf_hash_add(symbol, &sym->hash, sym->idx);
 	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
-
-	/*
-	 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
-	 * can exist within a function, confusing the sorting.
-	 */
-	if (!sym->len)
-		__sym_remove(sym, &sym->sec->symbol_tree);
 }
=20
 static int read_symbols(struct elf *elf)

