Return-Path: <linux-tip-commits+bounces-7869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B822D11087
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21FEF304F2FC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2133E352;
	Mon, 12 Jan 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNY+mNvy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g5Gebvww"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17F33CE86;
	Mon, 12 Jan 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204980; cv=none; b=PwhU1/LCpbwMUlZJAZsWSml1jbzgTBV+RSjMCYOLDIV5df24dZwO8AIVwRXBG/wRN6YL7TS1ZDFdgkgSNOo4DyGlDUqfCiHyEyYar3Yb38T9FsROqlzv89KGnwcaW/AVGtlMqovwQepEMQeUZQgVKhTu4XQrV99gQx6leS5CQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204980; c=relaxed/simple;
	bh=FQk6eskyHGQ3k7/j0cAAjdC44aTAQpziauctuA6uC5U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=huo7hUaZDasdf3Em8j3EE3lQ/PqwCXq7IbA3EFTlYnXVRrH3vWub9TQODvUxa2gM0rOjPNOzk7EtjEZnvjFi8Bx0mjjmMWdk9UjPLHc6LN5/T5+Qbs1DJ/ORFGX/4IUhZfn7c8KIFaCC1o0WmpmglMJE5fjbqy/aXtpZV6Hi5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNY+mNvy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g5Gebvww; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BePdfaGo118qfjCe970+FXv0TfBfOHbjXXNZS2nU04c=;
	b=uNY+mNvyV78W7M+GZ8wV2RiKhnlhwxdN7cuDfZNvQJz+PaJSzlUBqRJBdOYfk13terJRpl
	eSJsT5jCjp9Ab2tMBRO1/JKCpwXYMThZRPjlK8YyQXs5I8ErjrbcUaBpcLnFfbdfr4EH0P
	nRllS4/o9sT6GGDdClYeDxzEf2kyyObwYiGNnP1DnwmjfGSzc9GfPoy6X9DOyV70gHKbHm
	3BmYke/uOjaUyxYWEzeqWTePUgQ/3GhK9JgyRXk7RHciS2kmcZ8Zw4PY32iPDhGLPFdW37
	o3qOqbIQJWFiwAeNxrDrbn8YCC50gPyV+qxHE90TMru3iOT7SU+xMX39Lj0W1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BePdfaGo118qfjCe970+FXv0TfBfOHbjXXNZS2nU04c=;
	b=g5GebvwwnyzH5SKSAdN06A+FiKHVyvTedtfjwBwbNhGzImhHJwFn0UsuUSh98+TgSa9xRj
	v7VuMB3QsDR/yiAw==
From: "tip-bot2 for Keke Ming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] mips/uprobes: use kmap_local_page() in
 arch_uprobe_copy_ixol()
Cc: Keke Ming <ming.jvle@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260103084243.195125-4-ming.jvle@gmail.com>
References: <20260103084243.195125-4-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820497631.510.8623845272593435833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e6eb9acc024cdad7d1cbb7693ac39afdf9c5193f
Gitweb:        https://git.kernel.org/tip/e6eb9acc024cdad7d1cbb7693ac39afdf9c=
5193f
Author:        Keke Ming <ming.jvle@gmail.com>
AuthorDate:    Sat, 03 Jan 2026 16:42:41 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:27 +01:00

mips/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()

Replace deprecated kmap_atomic() with kmap_local_page().

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260103084243.195125-4-ming.jvle@gmail.com
---
 arch/mips/kernel/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 401b148..05cfc32 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -214,11 +214,11 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned =
long vaddr,
 	unsigned long kaddr, kstart;
=20
 	/* Initialize the slot */
-	kaddr =3D (unsigned long)kmap_atomic(page);
+	kaddr =3D (unsigned long)kmap_local_page(page);
 	kstart =3D kaddr + (vaddr & ~PAGE_MASK);
 	memcpy((void *)kstart, src, len);
 	flush_icache_range(kstart, kstart + len);
-	kunmap_atomic((void *)kaddr);
+	kunmap_local((void *)kaddr);
 }
=20
 /**

