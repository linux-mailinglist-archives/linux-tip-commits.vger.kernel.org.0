Return-Path: <linux-tip-commits+bounces-3321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE1A25A21
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B93A9DED
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F682063C7;
	Mon,  3 Feb 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpYWEoxT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lR7oOknM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF16205AD5;
	Mon,  3 Feb 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587009; cv=none; b=Nk3kvQi7IHN7aHSakcOyFoxG79MSWwUurt1eiDd/fegdaV7iewtBsCnbjvDSJwOw1VQ0+fYi3bVNFad6+KLwdqMiFPvnqmseTtfsTsPz0EOqPwyo9oLrkh/o8A6UnJLfDd9oe6PoiG16/L38P3K9rvjUyQqiuQDGzkXTdFK/3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587009; c=relaxed/simple;
	bh=sOhyOtBO0vxlukHp+nbn/k2lto7lBPMduZfNtFxLsPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZMJ0M/Hi0eXqGCTUua/WbO9ujUAaYUc3Zk59VjOV6971IGgQjZ4BhetQU2EJJgKlmkwVIwfUQxnZzr5vOoTRYmwhx1r11YeBCPEn9ro9deK2qRueGS7WuVUOO+nJy6dV/uuVx1mkRiIGUT31yy5G/LFYnkpUN72p6/+2FhrSe6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpYWEoxT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lR7oOknM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LSC/+fKCkLakTT6diq1mVUGNLQKegkylfZMEu3alGc=;
	b=MpYWEoxT8JIYnyozXirW3yc17zlCtpRcNXbH5/F/fIdWBu9Z0+7Phar4fDfXfpgtOxx32m
	7yjhzYFo9hesE3Vu5Ij6UJEn/ZyMwaD81SUBmJLCIceEC7IU7TvRiPGNl4FpMxpA/weWGX
	1/DsELOREdCF8z/1Se4vGPJQmuVyIeeYDFPcj5eLqEqLLjk+w/gAnXNS1cezLWEDDJ8bsw
	/z4/oEo2D/Gm5HA+oPSk6vydS6tu94t+074szGz5dIFO7y/BT6s6BCPDdaodyIjNNG3WTy
	VCLakTEoq261AV7iN5xkGub/eiC9SLyeeKOu+XiD7/vfue1ujVj6gDNb3BR5Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LSC/+fKCkLakTT6diq1mVUGNLQKegkylfZMEu3alGc=;
	b=lR7oOknMYFayX8rXDhbR/uOrCGPFXzZR1GMhvvWpGNE8ZY8z7oFHYgpFl/SHtYPa76tJwF
	sGO+x2wg+uf1qACA==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] execmem: don't remove ROX cache from the direct map
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-5-rppt@kernel.org>
References: <20250126074733.1384926-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700532.10177.16215864987528188939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     925f426451182a9f3e0f7f0e7e928f32f81a966a
Gitweb:        https://git.kernel.org/tip/925f426451182a9f3e0f7f0e7e928f32f81a966a
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Sun, 26 Jan 2025 09:47:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:01 +01:00

execmem: don't remove ROX cache from the direct map

The memory allocated for the ROX cache was removed from the direct map to
reduce amount of direct map updates, however this cannot be tolerated by
/proc/kcore that accesses module memory using vread_iter() and the latter
does vmalloc_to_page() and copy_page_to_iter_nofault().

Instead of removing ROX cache memory from the direct map and mapping it as
ROX in vmalloc space, simply call set_memory_rox() that will take care of
proper permissions on both vmalloc and in the direct map.

Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-5-rppt@kernel.org
---
 mm/execmem.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 317b6a8..04b0bf1 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -257,7 +257,6 @@ out_unlock:
 static int execmem_cache_populate(struct execmem_range *range, size_t size)
 {
 	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
-	unsigned long start, end;
 	struct vm_struct *vm;
 	size_t alloc_size;
 	int err = -ENOMEM;
@@ -275,26 +274,18 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	/* fill memory with instructions that will trap */
 	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
 
-	start = (unsigned long)p;
-	end = start + alloc_size;
-
-	vunmap_range(start, end);
-
-	err = execmem_set_direct_map_valid(vm, false);
-	if (err)
-		goto err_free_mem;
-
-	err = vmap_pages_range_noflush(start, end, range->pgprot, vm->pages,
-				       PMD_SHIFT);
+	err = set_memory_rox((unsigned long)p, vm->nr_pages);
 	if (err)
 		goto err_free_mem;
 
 	err = execmem_cache_add(p, alloc_size);
 	if (err)
-		goto err_free_mem;
+		goto err_reset_direct_map;
 
 	return 0;
 
+err_reset_direct_map:
+	execmem_set_direct_map_valid(vm, true);
 err_free_mem:
 	vfree(p);
 	return err;

