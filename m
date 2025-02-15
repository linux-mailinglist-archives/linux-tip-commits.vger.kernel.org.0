Return-Path: <linux-tip-commits+bounces-3377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED6A36D7D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744F518957C3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75A1DB15B;
	Sat, 15 Feb 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGuP+Z1b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9AhZUqQb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDE1BD017;
	Sat, 15 Feb 2025 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617006; cv=none; b=eykKRS76jgN69NKgb4J5GviH0jxIyYFxP0l6Jo864v+Y5lKffgHDF824RR1dCZYyvmetWjWfTrsjOT+urHHuQ00VFBTeBi/N9nEj5BBXtj7CiQgZWKfD9vD0gBFZ6S2BnzLj9P7VR7eyP+vjQjniqhCbNw19nh80e50B50Fc/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617006; c=relaxed/simple;
	bh=kpXtMnA0USK/aNM0ICs2wbh0ICecsgqbBfs4a5GrTyk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BEMtnEfjsGuBNJ5VtaEah8PmoEaNPTLOzpXul0jsIqNwWde+fFH79bWovDGInT+hDabO87dx+tKk2OwOtyDEa4Jvad1wzAcz06QYdj5OgLxHolYRSSyDNwf04bASF6MD9x4SazHkd+NiauqLcINUyWQ8FIRWRvIp5OCkS06hPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGuP+Z1b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9AhZUqQb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739617001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9laLNhz/M9XkIlh7DF82MwYNKUBr1YJBn8rW298KhM=;
	b=HGuP+Z1bBV30Rao7/C2P9sSGccHD0MHgRZ7CxaDWZ7L3uivLidC5uBKcQLvzxMGhNFp+IC
	tQ2hOWnlpPogL9lX9NZIZlqNSnj+DU9VhxE5qarTkFAYcDcZ1cf4XjXXsPU3AUMVQnMeh9
	FCmOUyIm1kO39Uc9QgO+PGcXLCAHdlRebUcDvj/tmn0wEvDRo6LNkH9v5Owe/8r1E810FP
	9n40FrKcGf5zjbgwF2Rvg1vM0bwwBQOm5JToZ2EhDOKE4f/K6n+s7qVCH04PWeyRuL7Df1
	5PPQ/zClMYPE0VNyIklMuqPcQInyErZA5ULdq9xmkKjyJgtEW4NIJltbpeJn9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739617001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9laLNhz/M9XkIlh7DF82MwYNKUBr1YJBn8rW298KhM=;
	b=9AhZUqQbGLSRLMt4jqLG7cjXu7fqZ94hmxsNnnjkaTwHQdz2ERgNemX1O9c5usx02n+UwH
	7weM9VevRuNl/sAQ==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] module: don't annotate ROX memory as kmemleak_not_leak()
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214084531.3299390-1-rppt@kernel.org>
References: <20250214084531.3299390-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961700088.10177.5467759050046137250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     675204778c69c2b3e0f6a4e2dbfeb4f3e89194ba
Gitweb:        https://git.kernel.org/tip/675204778c69c2b3e0f6a4e2dbfeb4f3e89194ba
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Fri, 14 Feb 2025 10:45:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:02 +01:00

module: don't annotate ROX memory as kmemleak_not_leak()

The ROX memory allocations are part of a larger vmalloc allocation and
annotating them with kmemleak_not_leak() confuses kmemleak.

Skip kmemleak_not_leak() annotations for the ROX areas.

Fixes: c287c0723329 ("module: switch to execmem API for remapping as RW and restoring ROX")
Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250214084531.3299390-1-rppt@kernel.org
---
 kernel/module/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c127be..a256cc9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1260,7 +1260,8 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	 * *do* eventually get freed, but let's just keep things simple
 	 * and avoid *any* false positives.
 	 */
-	kmemleak_not_leak(ptr);
+	if (!mod->mem[type].is_rox)
+		kmemleak_not_leak(ptr);
 
 	memset(ptr, 0, size);
 	mod->mem[type].base = ptr;

