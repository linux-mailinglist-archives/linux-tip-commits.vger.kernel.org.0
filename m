Return-Path: <linux-tip-commits+bounces-3745-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A4A49FBF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF8E3B6642
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A191F09A8;
	Fri, 28 Feb 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+I5ynZ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+3Tlu7A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461E1F09BF;
	Fri, 28 Feb 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762237; cv=none; b=uKGce/bhdiwZkGWkjzcJy84VyayEc7l7RY+TivbRIQwruTYPsYXxTS0Hq8nRbPKSrsUJ2IX2fjTyAjcKBEq2J5uSuIUz7Y9QXvA9kKdDEHr1mFjQBTv+PJjw3gNZlfdmOgDF7oW7mYmv+3j+QOgfaG5UASVZk7Hu13vjPbSkrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762237; c=relaxed/simple;
	bh=/Ae4HgG3M2HwDUnSDcbQfoLKCpADxkiZyCQwgxStM88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t2TlhiLqN6+nrVSRu0SJvlijiZJ24+ui2a15RIQ4I4FjGi6PAJAJWi6Z5KSyFSdbKPkhYk5PxnjSCmGTckAq6IJa7/0lL3Rud8k46LUGqhIaNloltrZlwq6/AA7wKo3wPiHT6hTpFPg34239aOQNHVGSeGRzKvsOZkVGrFw1mBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+I5ynZ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+3Tlu7A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 17:03:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740762234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BY+4NTQYN4S9VPZV9SE1nYFKoK49aDBE7tr7zSSio5Y=;
	b=V+I5ynZ7cpEI3YukSQCAUrmMH3CEZWyHadp9YrT31Y//a/+GIQxJN3N2ceCKA/A9tNTT8F
	eKCiZzGgwMHWy/BTffBc7NH1MtniyI0yiNG+eA94Bccspcu/Z3E6oXIOcZzJjEHxxxEgwS
	uwkQzQcZqRgs33jDesHKV115jSPzupOzCyUeqD/QaN25VCTodO/sD+oaPEJ4PbksexHVE+
	VWN5SjganIIe7ZAjcRbf3kpUl8CkNko9DHvv/8IpIMS5HAYtJZco//fZJNy3OA/NpgaLwt
	DakWjhQ313IpEWVZu8cmMErEFsg1ahyEFGI5ER6Eif4N0ViHpbhxwluFRtDiyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740762234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BY+4NTQYN4S9VPZV9SE1nYFKoK49aDBE7tr7zSSio5Y=;
	b=y+3Tlu7AuSFFV9YvSjSsSb72sQDuaURkCTipX2/R8REdnKG4rDFviFmWVMdb7buUhjOOuS
	ZOUJYf7DpqRXt3Ag==
From: "tip-bot2 for Kevin Brodsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/headers] x86/mm: Remove unused __set_memory_prot()
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Ingo Molnar <mingo@kernel.org>,
 David Hildenbrand <david@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212080904.2089632-2-kevin.brodsky@arm.com>
References: <20241212080904.2089632-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174076223359.10177.192242044439144224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/headers branch of tip:

Commit-ID:     693bbf2a50447353c6a47961e6a7240a823ace02
Gitweb:        https://git.kernel.org/tip/693bbf2a50447353c6a47961e6a7240a823ace02
Author:        Kevin Brodsky <kevin.brodsky@arm.com>
AuthorDate:    Thu, 12 Dec 2024 08:09:03 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 17:35:14 +01:00

x86/mm: Remove unused __set_memory_prot()

__set_memory_prot() is unused since:

  5c11f00b09c1 ("x86: remove memory hotplug support on X86_32")

Let's remove it.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20241212080904.2089632-2-kevin.brodsky@arm.com
---
 arch/x86/include/asm/set_memory.h |  1 -
 arch/x86/mm/pat/set_memory.c      | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index cc62ef7..6586d53 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -38,7 +38,6 @@ int set_memory_rox(unsigned long addr, int numpages);
  * The caller is required to take care of these.
  */
 
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
 int _set_memory_uc(unsigned long addr, int numpages);
 int _set_memory_wc(unsigned long addr, int numpages);
 int _set_memory_wt(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ef4514d..b289667 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1942,19 +1942,6 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 		CPA_PAGES_ARRAY, pages);
 }
 
-/*
- * __set_memory_prot is an internal helper for callers that have been passed
- * a pgprot_t value from upper layers and a reservation has already been taken.
- * If you want to set the pgprot to a specific page protocol, use the
- * set_memory_xx() functions.
- */
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
-{
-	return change_page_attr_set_clr(&addr, numpages, prot,
-					__pgprot(~pgprot_val(prot)), 0, 0,
-					NULL);
-}
-
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*

