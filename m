Return-Path: <linux-tip-commits+bounces-4395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F95A68B38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160B33ABC3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A4267B1C;
	Wed, 19 Mar 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyIBOfeL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3RfPoQSm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215925DAFF;
	Wed, 19 Mar 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382253; cv=none; b=UgghfpcQOclanxIOKRBTNyNxqpkisYxy6c2qRbVFNJBsBs0OOctvKUYXz0k4VBPFNSuGPcsTzVBMjVHzqdrk+kq2CMcghMpZ6oQWbSZhVVCboXgnedpy/Qmb/K+ctNRTiKksF8RNXx9L9yrK9rIAANM5quhni7MOqkZq0QLdqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382253; c=relaxed/simple;
	bh=VX5xvQBjyQTr6uFADXCyFwIZIjujmCAgUB9kW7m8z5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=leLd2ISXn351HgY64xPu4X9RbTfriFDKo0a9t4S+f5z50PMGDabBxqig9BkIBuQOTnJ45WdjuIUvd6/aieg1kfcc4vvXQCLkc/ogvJTTYlA0jlAqSvOKxWQ2FK8r/pe+IFCI4jcOI2LpkdiHFkZyb1H6UtAaofWYjPUROlUPkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyIBOfeL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3RfPoQSm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pu/7+pMf9XL22Wb0DhqMbW2L7+pWcUched/Er7keDoY=;
	b=cyIBOfeLigWzipUyOg8XST5adKvyv15xi6YTthYp7HYUQFPKQzLVMwqTU0DdXrQjQzTz64
	hBpxPU9Gt9mjhzOeuXNqaXV5pYOdQhQVPGzC6uqj5Yp/N5kbn9NfrEABSNFLBu08HfjfPT
	g6Q+3XjWpNvlNKV0N/EIPMPl794xsUFlDFkfGtTHghuc6bOr24tMOyXUW1ydymRBidgJk1
	N8pll/Hrlevng9WEDOlP0kjtmsXTxpd0czvU5DCyWGCmusJlV6bVxeMWev5rOuqdI79KDW
	eZ9xuXRQ9rXmpGz82JonK8HnreDgif2mW1vJnR6imjtg+QFhIVLiixqnf5EVDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pu/7+pMf9XL22Wb0DhqMbW2L7+pWcUched/Er7keDoY=;
	b=3RfPoQSmR7w3XEAVYNn1JEj4cosiEcrG1Ch939/zKHbjABWuSIWj79AM8J2k5/VkNEuJk3
	AXtM0SGOINO4HEBQ==
From: "tip-bot2 for Philip Redkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/mm: Check return value from memblock_phys_alloc_range()
Cc: Philip Redkin <me@rarity.fan>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan>
References: <94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224871.14745.17400349621004327421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     631ca8909fd5c62b9fda9edda93924311a78a9c4
Gitweb:        https://git.kernel.org/tip/631ca8909fd5c62b9fda9edda93924311a78a9c4
Author:        Philip Redkin <me@rarity.fan>
AuthorDate:    Fri, 15 Nov 2024 20:36:59 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:05:22 +01:00

x86/mm: Check return value from memblock_phys_alloc_range()

At least with CONFIG_PHYSICAL_START=0x100000, if there is < 4 MiB of
contiguous free memory available at this point, the kernel will crash
and burn because memblock_phys_alloc_range() returns 0 on failure,
which leads memblock_phys_free() to throw the first 4 MiB of physical
memory to the wolves.

At a minimum it should fail gracefully with a meaningful diagnostic,
but in fact everything seems to work fine without the weird reserve
allocation.

Signed-off-by: Philip Redkin <me@rarity.fan>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan
---
 arch/x86/mm/init.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 62aa4d6..bfa444a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -645,8 +645,13 @@ static void __init memory_map_top_down(unsigned long map_start,
 	 */
 	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
 					 map_end);
-	memblock_phys_free(addr, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
+	if (!addr) {
+		pr_warn("Failed to release memory for alloc_low_pages()");
+		real_end = max(map_start, ALIGN_DOWN(map_end, PMD_SIZE));
+	} else {
+		memblock_phys_free(addr, PMD_SIZE);
+		real_end = addr + PMD_SIZE;
+	}
 
 	/* step_size need to be small so pgt_buf from BRK could cover it */
 	step_size = PMD_SIZE;

