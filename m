Return-Path: <linux-tip-commits+bounces-2842-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC39C677E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 04:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B171F24030
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E72215C14F;
	Wed, 13 Nov 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iy2ytE5H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R74a/u+2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C815ADAF;
	Wed, 13 Nov 2024 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466796; cv=none; b=g2RLPalFfaxVME3joqIABjPB+KrLa1vfUvOr0d2zGX+5V6dDC2pDHko9c12i1nzrfAHMW5JluQop5u/MTGgD1DOvfYLfUmpS4fgASY42R5lSzDooWQ+MbDX+gf5USLiyukrOhen0UAsnxt5hIh0k7612aVFnsHnH+A1y+DI62FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466796; c=relaxed/simple;
	bh=eGFpRZ/iLGYFutWUP4R8DafuyjJBtAUWfAw4L4YAnBw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YCJLJ7VYhhCa3DjZ6O8f3eglSohUtqV7lLOHMXwI0tfrIo5Z/HsgSzizUTMMQGAqK25MGRyQ8vyRj/ct0FEoGjvi9RPz5K8PVDoORp7K5tp8ZqgzIets+Cg3hbp700NI3gTJhkPpYbGepTeD0yAP+8OpqdzhIqgy9hj4av2rykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iy2ytE5H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R74a/u+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 02:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731466792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sj6WqAmn4yh0l2mIlYkJu9aJKD9YLZS1Ip+Z4X2ivzk=;
	b=Iy2ytE5HJeP86n6vbYP5bfOZuRfluQAX3paQn923zSbfnTYVAsvP8mHGmOmdYvB7KL04XO
	34guGlly1wfo+pbXfy4LxuVXErtij03g2RUBtQMbyDshCrBb8gBL9LtFc3ZKnSiFODda5j
	Ght1Nq/1z8H4+Xi90P4/bNyAF4uv1GbRB0YB4M1e0NMpwakHkXw6P1u6sYKyWtjHjhYu7H
	+GlrjjXAtQZsOui0RMr+Hqa51+PFHsAR9V8+NLBAhJDuOdIi1z/79lvYJDfCtmJ93ntuem
	TMeIVIQWLE163GaPp37/4Dot1O8BxcVXBXiKePdwcZdbj/uBMdMAvGBexjVRbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731466792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sj6WqAmn4yh0l2mIlYkJu9aJKD9YLZS1Ip+Z4X2ivzk=;
	b=R74a/u+20Tbf+iZJH3iUSLtjPnqzOS/De60W1oKdqQAKdT0jIIPUoEUo13SkahtFwoH7M6
	rRmuNtX0rcVFV1Dg==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU
Cc: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241109003727.3958374-3-riel@surriel.com>
References: <20241109003727.3958374-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173146679112.32228.10142601274582847300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c058cc5fedf0cc2d05d44b166e155690e101aa6e
Gitweb:        https://git.kernel.org/tip/c058cc5fedf0cc2d05d44b166e155690e101aa6e
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 08 Nov 2024 19:27:49 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2024 03:42:41 +01:00

x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU

Add a tracepoint when we send a TLB flush IPI to a CPU that used
to be in the mm_cpumask, but isn't any more.

This can be used to evaluate whether there any workloads where
we end up in this path problematically often. Hopefully they
don't exist.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241109003727.3958374-3-riel@surriel.com
---
 arch/x86/mm/tlb.c        | 1 +
 include/linux/mm_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cc4e57a..1aac4fa 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -760,6 +760,7 @@ static void flush_tlb_func(void *info)
 		/* Can only happen on remote CPUs */
 		if (f->mm && f->mm != loaded_mm) {
 			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
+			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
 			return;
 		}
 	}
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8..6b6f054 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1335,6 +1335,7 @@ enum tlb_flush_reason {
 	TLB_LOCAL_SHOOTDOWN,
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
+	TLB_REMOTE_WRONG_CPU,
 	NR_TLB_FLUSH_REASONS,
 };
 

