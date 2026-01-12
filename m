Return-Path: <linux-tip-commits+bounces-7871-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3430AD110A5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5323F30188CE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D533FE27;
	Mon, 12 Jan 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmpanXqM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJogbmSF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018633F361;
	Mon, 12 Jan 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204982; cv=none; b=kEv64qHAW0aQUg8NstZp9QBJv2o/gL3pE7NOqZ/2ClB1Cm+hkAJpajXATXPO6ptMFZYgjYbaS7mzbquUr5I/uprs2hUR3nzRmqBXtdglz30pVd/1PWPmuY+RfdUHsE4FZO0af1pHXIuT5tGp9EZHFpm4ay/K93fJZyaJ/tbWYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204982; c=relaxed/simple;
	bh=yNP4pEvD1jhi+h8Qq/5A10FQSTwC5yOQEk37C6uYKhU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XBkXdblXNbH6xCBxRU9g6+2dWDitGyOjrCx4UCIxiRSvvt+ZMyGfM23sJwjlnUeGFkCl/yx6L5keFIYafS+TnlW3YoOyatL+ObgspEuJLNzH9BE4DuBtjJ5gbS7UJrbaax/TVjO3Dd/tIxhG+VuCo26cIhxRyp9FIXuZHFe4gX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmpanXqM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJogbmSF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:02:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODTDpsItASEIc1da8lRNsM2hV0EuvxKOV+CV+w1ErOM=;
	b=fmpanXqMIOXgiL814AfyruzYif1mG5KbteFIduKGwmKPQBvdfAaL2xL4bMLy30jjLpu0MM
	A2VVGDaZkkf/tfzcIICCnHmgTucEVECgmcfOY8HTrERGZX8qJxtS0yUdiCKeCqkI25XAO0
	YfxSZDKSjg6HZ6BFHtc53vwLMiU7FicmYJW0CDl2NmkO1x9KwOxkM9O8uSGpLkZNz2zXhD
	NEg8WwzdwNizFadET2U/2UMPQdpwFb35YeSNOpaJzXKva1Vknjap8ke3WY2xmQVbKPTScZ
	NXAoD6YUQCrK34arH81B7X3JN7L//4W9YGv1ofKmCrx7Zh/ttCmDIH34vURkhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODTDpsItASEIc1da8lRNsM2hV0EuvxKOV+CV+w1ErOM=;
	b=vJogbmSF5TMdd6hBNPmy2Gd3560rWND8jrC4RRWVG8cDu7dxeh1r+6XUC8qXuJk9dxQyLf
	NsnAycd99U5ajkDg==
From: "tip-bot2 for Keke Ming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] riscv/uprobes: use kmap_local_page() in
 arch_uprobe_copy_ixol()
Cc: Keke Ming <ming.jvle@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260103084243.195125-2-ming.jvle@gmail.com>
References: <20260103084243.195125-2-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820497882.510.11049181070245867998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a18dfb5dd33247679a0cc4ff208ad7340d1e08a5
Gitweb:        https://git.kernel.org/tip/a18dfb5dd33247679a0cc4ff208ad7340d1=
e08a5
Author:        Keke Ming <ming.jvle@gmail.com>
AuthorDate:    Sat, 03 Jan 2026 16:42:39 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:27 +01:00

riscv/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()

Replace deprecated kmap_atomic() with kmap_local_page().

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260103084243.195125-2-ming.jvle@gmail.com
---
 arch/riscv/kernel/probes/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/up=
robes.c
index cc15f7c..f0d0691 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -165,7 +165,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned lo=
ng vaddr,
 			   void *src, unsigned long len)
 {
 	/* Initialize the slot */
-	void *kaddr =3D kmap_atomic(page);
+	void *kaddr =3D kmap_local_page(page);
 	void *dst =3D kaddr + (vaddr & ~PAGE_MASK);
 	unsigned long start =3D (unsigned long)dst;
=20
@@ -178,5 +178,5 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned lo=
ng vaddr,
 	}
=20
 	flush_icache_range(start, start + len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }

