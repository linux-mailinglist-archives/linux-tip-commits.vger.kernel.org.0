Return-Path: <linux-tip-commits+bounces-7870-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 656EDD1109C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B45CE301BEBB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736633F8B3;
	Mon, 12 Jan 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YduXbAqe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gz3lPAjo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322533E364;
	Mon, 12 Jan 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204982; cv=none; b=YHcC4VYUFUr6oTcqQJ3V9EnVb3FT053FSp0mu+tl0Tsr3kkejrjChZ1GEBIs5aSXvPI5QVvTa+zsqdQU8mtAJ0MbjedmtfUF7UQxoniz2nuo0GLS9NKAag0bWAGntiewCTCs0HUJL2QYG0njBCU6JqiPSyhVtWMZFJH5Jd/sRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204982; c=relaxed/simple;
	bh=GwWYvddNF7oQJbA1WAlHTbnnGnpGtp3lXTcnsMTjaNE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GNiX+D9cwqwH9C4nDx4xuDFKPOjkSwlSZXPBygLj9XtPbd78i0u8TL9RLyeZtCfaHadXQdPTawn7y3sr/lZDH25hg3wC4gDKhtccPJEJ1/ViYfGWPphy+/XVIkNjqzww6ea68fL5U/7Q/P8KiJqyuZvLYsC5pVSRPi9nLhFH3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YduXbAqe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gz3lPAjo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:02:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzIPYor4vHm5PGt3uEZ5dNtvbMpc97MQMZO2vgJqARI=;
	b=YduXbAqe/Mqv3tKwFN3aCGacHz+N8HbSYYaL/fmxL5ekYcMJOxVUSm/KfI1ufE4KmhbVCc
	fJVlc2U13KiRE/7NKK3VfgcfI5+AH48zOb8vFALbQNzzujjj26Z8Oc3/N39cK1b8z/j5e1
	7GrwhQ2eZa3V9hvWFEHHDCyzGkdX+DoMzO+K4oH1jrV6pQ9rNrAJX3H38kjvveEUrNz3NH
	khmGgHn21OxDHizwXW+sDAZ2O8F4UgLJ1pv0QijPQKuEx+WmXZrod/YezVQJCA8E94sm6j
	0FJWlctWHUVxthC8wwD7NyCpkYljyOF5njl/mpxAXs/RUo5BtnzkSOoeyg8ciA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzIPYor4vHm5PGt3uEZ5dNtvbMpc97MQMZO2vgJqARI=;
	b=gz3lPAjoa+ocEECtI0JZOrp+K5RXRdYxZuJTDKv7+jL1R8FzhPuRnlaewBVtIinAZcNVVe
	RgwXK/+dxBYWPOBQ==
From: "tip-bot2 for Keke Ming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arm64/uprobes: use kmap_local_page() in
 arch_uprobe_copy_ixol()
Cc: Keke Ming <ming.jvle@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260103084243.195125-3-ming.jvle@gmail.com>
References: <20260103084243.195125-3-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820497768.510.4679550327280215792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     094cc7bb5fc3b484614417b4578233a38e3df942
Gitweb:        https://git.kernel.org/tip/094cc7bb5fc3b484614417b4578233a38e3=
df942
Author:        Keke Ming <ming.jvle@gmail.com>
AuthorDate:    Sat, 03 Jan 2026 16:42:40 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:27 +01:00

arm64/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()

Replace deprecated kmap_atomic() with kmap_local_page().

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260103084243.195125-3-ming.jvle@gmail.com
---
 arch/arm64/kernel/probes/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/up=
robes.c
index 9416688..4c55bf8 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -15,7 +15,7 @@
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		void *src, unsigned long len)
 {
-	void *xol_page_kaddr =3D kmap_atomic(page);
+	void *xol_page_kaddr =3D kmap_local_page(page);
 	void *dst =3D xol_page_kaddr + (vaddr & ~PAGE_MASK);
=20
 	/*
@@ -32,7 +32,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long=
 vaddr,
 	sync_icache_aliases((unsigned long)dst, (unsigned long)dst + len);
=20
 done:
-	kunmap_atomic(xol_page_kaddr);
+	kunmap_local(xol_page_kaddr);
 }
=20
 unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)

