Return-Path: <linux-tip-commits+bounces-3918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC06A4DADA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DCE3A7BA2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F9201004;
	Tue,  4 Mar 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSnut7ua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vnKzZdku"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87620010C;
	Tue,  4 Mar 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084592; cv=none; b=LIFF+zkmqkYkQSnd9x9cPFd3CMVCyeR9Y3lUQmZ4qNgbDroWSFsiwx77wfCaxKxpHj0HhNH0feuDAvy+mpTo0almqDM8Zp1KdtZz5RVSQ4MzOSx1g4rjkB9PU13RFjtrD0hTpl3Cx+Ifuif2L96G7+/N6OGGVBHDDFoPKpqdLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084592; c=relaxed/simple;
	bh=6kWpr5Sl3uLC1Q2nhpo2ss/JudqEVlR5ayFmNFhLAos=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VYHnxaqCPIy1l129hhkW6K+be+sKjtjNdN1G6YRSg936eYTlzXL+JegMdydhT6/m6Vwx5wbb2XMzg8d0rPJfGNJjeAz0JSCjU82l4GPuN+IeP+kEH6G1WJPjroOJu+bHSsrCOGl0GrFRi6y3Ll/bysWjDWLN/ZtvgpuWPunOA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSnut7ua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vnKzZdku; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqPUqJE4mSYEUv9PFkMBhTkph0084A34/QujpeyH/Uo=;
	b=VSnut7uamnDkMI0YCH9K2w/+azgjq8sd6GlEfr1fQ3okmmq8IVBQzLoWQ+IExfGE4gXHfu
	VQALsup/m4GilSz6c9j59r3x1NsGI0dKT7h3cWO1dUI6SiNfn/BcTpY8N9iDBw0BPpJ1Qo
	BmnIFuJsRxZufxj997AkKhHWNyseKVfpJCTb3g1Mf+U8kiqDvaktPuIXDe0to2Bdp3Mw2A
	uQHM+4bFfGwF2RNdcjCvAMyFZo7w0nIcuGBfLc5FzCG/SAf7UXajSAmOC7P1nrpJycwFQA
	BvKBKc6SL4W5t7FWvvQOWpODxkz2fZjqvBdwHfaEke+CyLQO5rFJgEvy+lCpZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqPUqJE4mSYEUv9PFkMBhTkph0084A34/QujpeyH/Uo=;
	b=vnKzZdkuwxADPAF7SP44g6pYicvZNt8LaYU4pIgtGjXIKa5P31NCk5cA64ybgrXdyYyMc8
	Z0Q8XaxGzXR3ZRAA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Move this_cpu_off to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-12-brgerst@gmail.com>
References: <20250303165246.2175811-12-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458876.14745.14954409374682348685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     04ce0ca5d5b6d79376913b272e14118be09c6367
Gitweb:        https://git.kernel.org/tip/04ce0ca5d5b6d79376913b272e14118be09c6367
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:29 +01:00

x86/smp: Move this_cpu_off to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-12-brgerst@gmail.com
---
 arch/x86/include/asm/percpu.h  | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 6fbb52a..4f202cd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -584,7 +584,7 @@ do {									\
 #include <asm-generic/percpu.h>
 
 /* We can use this directly for local CPU (faster). */
-DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 175afc3..bfa48e7 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;

