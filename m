Return-Path: <linux-tip-commits+bounces-4852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C2A858C6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A127AC713
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA082BEC2D;
	Fri, 11 Apr 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgOPVSvf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBjg2IAX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9229DB7C;
	Fri, 11 Apr 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365716; cv=none; b=khGEGXhfrptS75NnEPqMk4bw8tXbpEflka5DZoVD3MB4jEP1TZqrgw1V2jLH6c2JusVFeA+5gtyl+5+t86DI90YSP66sQVH2pKQsQAbCVfhk5sXH6y3sNPRghf3VcUQPR83LjNKs7nbHpl0Ck/vmuRyeDS7K40yBD11QGmblJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365716; c=relaxed/simple;
	bh=Dk1Yk17MfDth0ZbYXVH6LnrCPdAyO+fMxWVIlYKbpTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f7EZ5Q+2RMoCQP9N1uWUJXWUkXqcEGPssix1OOO1YedL9jMsJcV3DD+gSGoZL0EEUkM7OHwuUHEw34g4XWWKRAyvMYEYlvGogbqbcoZPWNwJcVXiIhRV/+iTH4fDcDD5+JGPUgXZau5NWf/psULW4oRQv9dSdCSOKY4Nk1hegmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgOPVSvf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBjg2IAX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//I64mINq/5LBy8lOV+lbOOJcP8wycqLt22dYpZ4p4w=;
	b=wgOPVSvfhFqK7PklDepGdXwozsH0Vk1Wi+IwDmP17eqjZ5HrFDz6r7/BU9bbjKlTIUqpij
	ObgpaDcPN9o/5seOP5otM2T/bxaYxCMXcUPLl7E9v/mDTl5FweMl9C7+vxWSqt7L98FOvj
	9s7N2ofc/BLVU35paIXvVHA4qzGY7gPQVpAmWHtp5oCD1S9KWyHgyl1YLbeYqxtDrhxT37
	QiXVjS3HDkpNBCnv0eKO2N8rZUj8n7GDM5SK65hr39smHKwZab/Oe5A4cwJ0xY+3NJqcN/
	/17eCx0M7Gvh7HcPh9tYeH+JHD/fj7VifkOPHwA/QGvYO+puvkJiW4deNoSfbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//I64mINq/5LBy8lOV+lbOOJcP8wycqLt22dYpZ4p4w=;
	b=QBjg2IAXsUf31WDqe08ed6BTUz1ISFpZbsSHO/PAGSP6/H7x/zuCnRblJd564XHY+MWTB0
	1Vuh3o0G+zkNHLDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Document 'smp_text_poke_single()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-38-mingo@kernel.org>
References: <20250411054105.2341982-38-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571240.31282.9691204511880217505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     9647ce465265720509f80f21f0b36c00bb0c0d18
Gitweb:        https://git.kernel.org/tip/9647ce465265720509f80f21f0b36c00bb0c0d18
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Document 'smp_text_poke_single()'

Extend the documentation to better describe its purpose.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-38-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f0bb215..a9726cc 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2880,7 +2880,7 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
 }
 
 /**
- * smp_text_poke_single() -- update instructions on live kernel on SMP
+ * smp_text_poke_single() -- update instruction on live kernel on SMP immediately
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
@@ -2888,7 +2888,8 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  *
  * Update a single instruction with the vector in the stack, avoiding
  * dynamically allocated memory. This function should be used when it is
- * not possible to allocate memory.
+ * not possible to allocate memory for a vector. The single instruction
+ * is patched in immediately.
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {

