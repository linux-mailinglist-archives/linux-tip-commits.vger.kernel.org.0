Return-Path: <linux-tip-commits+bounces-4390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB0A68B21
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350F01882C78
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73B266574;
	Wed, 19 Mar 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D8x3e0/f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TR4PAmbu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCC263F51;
	Wed, 19 Mar 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382251; cv=none; b=a4ADJMrXci83XM8DqReL8DB5o6Jur3vZ/1ghRZhFH8ikXLqL1Klliw3I8xD8DoMmLVPGIZgofOz90IZnHqw8mqExlpGdIvTDZqkYga2ue0wEugQJ0kR0FLzvy8FmGSgrmrvP5Z2zwkqOBo/ZBcXd2dkB+Lom/PaKV0ssnr72Epg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382251; c=relaxed/simple;
	bh=WGQ54VuGFzwaNuQtc7gBkamFgiBy6PSMr2iyhEvzK4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Aa2AxBmZSX1wP6JTAVjo7Ee+D22o3xYQwWYdVo4vqkQA00R5CHqmU/PO3qHeBzuOBI3HTcyfoNtsHNAnZ09OycgbHhG/vigjjxM+g9o5LjuX+7lRj+DE/sRj4EDL9VZTOINmkR9HaqJkd/Cnid8i2gEcF6GJR7G6rWHRqNJvmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D8x3e0/f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TR4PAmbu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaMIdbkhpgNp4J26dSlXGIgYqJh1nVI0IYxXZcz7Ne4=;
	b=D8x3e0/fIved+mzQZBaZeAK1tRxmHUKW6pIzxc2N7G23Qo4wFKSofDHU0fEa3xAYkVgJgO
	NwXzUbpj9yzza1bySC0kmbw3OEmA1jEadb4m7Dt9tCUY/4XVhjTmkmejVY4qUI4Qe/FvaP
	mnaUkucL5s4q7+z0k+Q4LuA30qtlSiPAJilcYP4Api3iVqd9NuWl9OQ0PJPUQ9EH144DJb
	WPIX9TjTFhcd+7icZYUyK/BQ4PKjYKTLMKiAvwkaR9MA+Kr2Vd0/3dv//EdsR4mKJUgpK6
	3IBMOp82f/YleldBrMIo4cvOPC75oxgLK4xIH9BLG0XdrQidMEHOAwGfWGBOkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaMIdbkhpgNp4J26dSlXGIgYqJh1nVI0IYxXZcz7Ne4=;
	b=TR4PAmbuxEWBsz6aNzeMnKOphlPlbZvaIOZbwASdj3beltrr6+vIXFw62rIo9GRoK1Ga41
	dXrCzemxf8Efi7Ag==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Use broadcast TLB flushing in page reclaim
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-7-riel@surriel.com>
References: <20250226030129.530345-7-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224586.14745.2368086970532828774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     72a920eacd8ab02a519fde94ef4fdffe8740d84b
Gitweb:        https://git.kernel.org/tip/72a920eacd8ab02a519fde94ef4fdffe8740d84b
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:41 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

x86/mm: Use broadcast TLB flushing in page reclaim

Page reclaim tracks only the CPU(s) where the TLB needs to be flushed, rather
than all the individual mappings that may be getting invalidated.

Use broadcast TLB flushing when that is available.

  [ bp: Massage commit message. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226030129.530345-7-riel@surriel.com
---
 arch/x86/mm/tlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8cd084b..76b4a88 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1320,7 +1320,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		invlpgb_flush_all_nonglobals();
+	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();

