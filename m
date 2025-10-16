Return-Path: <linux-tip-commits+bounces-6922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1DBE2994
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D179F501AD7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C933CE9F;
	Thu, 16 Oct 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LLQi2PW1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQdr2bwP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3163375BF;
	Thu, 16 Oct 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608414; cv=none; b=Z070NNgeAt2W4Z+ykmf+oaGDfEUkBifH0dtdSY20sid9xG3o7XQPCLUjzh18/Vgxd3ebp8eH3WJrqLp8S08yxDDZKUgY2Z4B897e796JZz3UhofJ7x7avn2s57h9QZZBA0r8z5x7EvUOebJP3TWDt8IwlJnVHMRuRMBAuJ89mH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608414; c=relaxed/simple;
	bh=GcH067H1GJQdPRuVnrzRh/eFXn2onp8p+tbCNbp4s3c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QCrPGa1Z5tP4hFrondDp57Gsk4Y8aw+8qDdq5g/pm4PzOUzB9oVwe0O//cxS168k9ouTqbugdOUvohkQBnMP/4W3sfPUemdTaENvzhTQ+/I7MO1swoAa7r8clJGm/OGHxKkn6jCf4EExaZAsjHTUkYJQ+3aBM5AMKxYUpuO7Oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LLQi2PW1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQdr2bwP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3xiTgYGVEuxDwyIdegMmcKN15T4O/m+lmwymkn7N/h4=;
	b=LLQi2PW1Itj8k4F43BfIOEmdqesFgxERDHyEKDSDisCfAArnZsyVg9ouM5wiA82dcEfqly
	JnAo4GXpg+lu0rcCdIaD3m0eBLgSB+Zva0ArtK+8wh7cx1El9kfr8X7LC73a8dwp4Cd7ov
	AjzXfWn1Iup/XMgZWu5kPUOJkTxgqJRmiCKJ14Ofog7ElHEaI4QENzJTGvXAQP0cvh+EiC
	UQgffXIaJ02sEQ9x9pdf9O59EPdAa1SLSj6Uf9J21+2anVVXiMXrDhe9RXNoBd0txqF2Vq
	G4ptr/yXIp1A5XnH8XNLpl5wo/givrEkc8OUgx0o4LaiuKuxoCgk8bOXtUpQLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3xiTgYGVEuxDwyIdegMmcKN15T4O/m+lmwymkn7N/h4=;
	b=bQdr2bwPs/aD9ClkEV9Krer+pF2PThwZm3i+sT6M6bfI5ra1xyuM5Y9jUEk6yG2MTER8CX
	dhDG33mp1FY09uAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] compiler.h: Make addressable symbols less of an eyesore
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839333.709179.15080960141371280408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9f14f1f91883aa2bfd6663161d2002c8ce937c43
Gitweb:        https://git.kernel.org/tip/9f14f1f91883aa2bfd6663161d2002c8ce9=
37c43
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:14 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

compiler.h: Make addressable symbols less of an eyesore

Avoid underscore overload by changing:

  __UNIQUE_ID___addressable_loops_per_jiffy_868

to the following:

  __UNIQUE_ID_addressable_loops_per_jiffy_868

This matches the format used by other __UNIQUE_ID()-generated symbols
and improves readability for those who stare at ELF symbol table dumps.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6a32250..ab181d8 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -287,7 +287,7 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define ___ADDRESSABLE(sym, __attrs)						\
 	static void * __used __attrs						\
-	__UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)(uintptr_t)&sym;
+	__UNIQUE_ID(__PASTE(addressable_, sym)) =3D (void *)(uintptr_t)&sym;
=20
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))

