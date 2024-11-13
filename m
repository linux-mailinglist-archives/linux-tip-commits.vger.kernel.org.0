Return-Path: <linux-tip-commits+bounces-2844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031F9C6785
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 04:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90092863E1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC79158DA3;
	Wed, 13 Nov 2024 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKuJO2td";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpPWAx5g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1715B96E;
	Wed, 13 Nov 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466798; cv=none; b=Jj2Aa3qiuYwERymTI9MP003tctShhIHiy/0TrynEDJn0P4nv7ExLVjWI7DTEoDbvZqTNau5Uscif9ASCIAvpFAPZ54C+BqXJYikQsRcYCTB802Z6KeYXqCwZl2lOeqposvOQCygW++u1XTmpb8jqKmEQOz55wEASZw9dvFGrxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466798; c=relaxed/simple;
	bh=RNmGvv9qtJftQkt/MWW4KQAf0jQJyolE+UMtWsMXSuQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AG6pTX4rkSeK+0gP3n6LazAehNbehqQH9dmL9MzZwINHkSFSwuIJ/mBn6DfeLuudxuB6U9Abm9yGFWsgvtSDZC0QfL+qJ24TlnS7k/cw6hEExZHCpcIsQ7zTzkFTJbVT/MQEbP+3MXdyKOWmS0b+AmwPoTIpevcuDPVKMedDvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKuJO2td; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QpPWAx5g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 02:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731466793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYC+Kan572GR82qnRgBfISaqYfYJOjJmu529Q7Uf5Dg=;
	b=fKuJO2tdmH+YdcaXrT34beIuXTEG1eV0LwEroboNCTCq2PGCu7DzoXHWfPopXEZDUI+ZDD
	5AoCdU9kPP6k3bjE7migj3F6RCh5h0as/3zkiq+6JA2TRvZOoLCz+bFGPEgHM6pWkd3bhJ
	gL8X4dGfp35V5Zw2IGOnHPy+BtyMx6SAseHfksYGJ8w6LiXsrMGfoUGwUGyeyGxn29iMUJ
	u5PhCrJBwS0eZmngOp01H+rNcw8rBvSIqQIxsuIExJ+KWvgZZpfpFtCiSI/pZkLkQzSQ6w
	E0LtZTrfq5R1ofPUMYwFEudniCSqEy8KkXVy10ER38ynImaoSgmPLqxV2GafsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731466793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYC+Kan572GR82qnRgBfISaqYfYJOjJmu529Q7Uf5Dg=;
	b=QpPWAx5gjwywpKSBdYvJ+Zwu7nVhhJ4k1lkE87Xe05O5hJyt09bT5ICAVddkpIDXUUcPQU
	TLfAk1OKrf/wUzBg==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Put cpumask_test_cpu() check in
 switch_mm_irqs_off() under CONFIG_DEBUG_VM
Cc: Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241109003727.3958374-4-riel@surriel.com>
References: <20241109003727.3958374-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173146679261.32228.5720589109198727642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     7e33001b8b9a78062679e0fdf5b0842a49063135
Gitweb:        https://git.kernel.org/tip/7e33001b8b9a78062679e0fdf5b0842a49063135
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 08 Nov 2024 19:27:50 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2024 03:42:41 +01:00

x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM

On a web server workload, the cpumask_test_cpu() inside the
WARN_ON_ONCE() in the 'prev == next branch' takes about 17% of
all the CPU time of switch_mm_irqs_off().

On a large fleet, this WARN_ON_ONCE() has not fired in at least
a month, possibly never.

Move this test under CONFIG_DEBUG_VM so it does not get compiled
in production kernels.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241109003727.3958374-4-riel@surriel.com
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1..b0d5a64 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -568,7 +568,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * mm_cpumask. The TLB shootdown code can figure out from
 		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
-		if (WARN_ON_ONCE(prev != &init_mm &&
+		if (IS_ENABLED(CONFIG_DEBUG_VM) && WARN_ON_ONCE(prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 

