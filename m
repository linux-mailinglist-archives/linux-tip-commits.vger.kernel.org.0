Return-Path: <linux-tip-commits+bounces-4841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B6A858BC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945D39A2D61
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423629C334;
	Fri, 11 Apr 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyFEqdPm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V61RbNaa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9029B220;
	Fri, 11 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365705; cv=none; b=UJFPzZVeOA/QFr/9jnzu2DbDXuDJ+K5p3HB8SG30ttDwO05DyorTWV8+r4ghMxd1lrcCu2BnMx7dUgkqojZM9KzXTo5Fq5NvTJSfjuy6tSWYfTOctopC6LDR7M+J9NKKJ1THxxEdic+WD7ni7LoHQvrbdFpOUeLCMNqy5HGdZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365705; c=relaxed/simple;
	bh=OesOyefBS/sM4Vt1NTh+xFG8oUm4rzldL/1Mv6byIFI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n/S2vxFLAB+xaRSQaDnJiSWoDvSi1guCN/aOhUILggp3O4vSUzBVWejBzBhnk0PkU+wFfjy+yCb8oQ9zOAWjqRYreZaw+fhjgbzR0/6xxR1GbTQ9n0q2Rk4o4oO7JdfvvBHvYdsJ9eqcRPjwrd7dJIXQxnmRQd1fuWDGLRr15po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyFEqdPm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V61RbNaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYsxcJbMqAOYtR5yEu9HXhpBDo8pITdaAfGLFDRILPg=;
	b=WyFEqdPmxz0EMivyfXQL4PoZGkToOo8MGrsEa9Ipx+yYgadgz/oy2V6V+rXmr4MxvO9aUn
	gzgbqd292jtMTdTgek+NFItGghavNOR9lZ0h8e+nlgmjjjXHpKeX0IyhBg71erzts4Ebxa
	Ipm57kuQrFgZYJEFO3iF0QT3IdsBrphvdtONs7kBIiTWZsp48uqwbfOhDEUHBzv68CK/DJ
	swESWVq33p+KKEavVaSOHW/rEqizm+5A4HcH/Oz1zxKZcIDB+55IHdpLm1jddVe78puzk6
	pVbXeBD8EyZDDtGl+7LCkRb3R+8NX9IqMpRPxzZV5mwWd8a6lzNci4uAbVoqdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYsxcJbMqAOYtR5yEu9HXhpBDo8pITdaAfGLFDRILPg=;
	b=V61RbNaaRlGoQWES4OEpx+IxEeuVRdrWYJ4+9TkupB3hmwJLnnFsOxnNFWBkoSE3LRZBXR
	J3/YyiKaYtF8sLCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Simplify the #include section
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-48-mingo@kernel.org>
References: <20250411054105.2341982-48-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570174.31282.15716098760927710552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     db5c68c88c07337b7e5801abfb926f9191fa7945
Gitweb:        https://git.kernel.org/tip/db5c68c88c07337b7e5801abfb926f9191fa7945
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Simplify the #include section

We accumulated lots of unnecessary header inclusions over the years,
trim them.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-48-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b8e0b1b..eb3be5d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1,36 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
-#include <linux/module.h>
-#include <linux/sched.h>
+#include <linux/mmu_context.h>
 #include <linux/perf_event.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
-#include <linux/stringify.h>
-#include <linux/highmem.h>
-#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
-#include <linux/stop_machine.h>
-#include <linux/slab.h>
-#include <linux/kdebug.h>
-#include <linux/kprobes.h>
-#include <linux/mmu_context.h>
-#include <linux/bsearch.h>
-#include <linux/sync_core.h>
+
 #include <asm/text-patching.h>
-#include <asm/alternative.h>
-#include <asm/sections.h>
-#include <asm/mce.h>
-#include <asm/nmi.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <asm/insn.h>
-#include <asm/io.h>
-#include <asm/fixmap.h>
-#include <asm/paravirt.h>
-#include <asm/asm-prototypes.h>
-#include <asm/cfi.h>
+#include <asm/nmi.h>
 
 int __read_mostly alternatives_patched;
 

