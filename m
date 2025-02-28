Return-Path: <linux-tip-commits+bounces-3747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38095A4A007
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6591D7A33E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3321F4C88;
	Fri, 28 Feb 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDfsfCZ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BwLi/fZD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770151F4C87;
	Fri, 28 Feb 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762848; cv=none; b=oHuPySO0vUTCn9/CONAVnr1SjuBURrckgWqTXY8jo/bxuGwSdQSUyn/EcbVbFceVe3ePjcp0el8bRABbPbGZ0wIAToxUpk0+Mk5TCOXgljj5P2KYTxoK24Fk4HBP5sN0BFnZdTkI4Tt2//geomT8cbjVnu59RSrfBLJFj7sAEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762848; c=relaxed/simple;
	bh=xuLYWQOhgw08vQ5BKp/nueL1UkemSm7dHbP2izObk7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fRhN5St85J+pFYQ5JT8j1N1i+eMnOgob4fZ885mOTC+wSuGX9MlmY5tr5S5NplGQ+pt/8KzdLt4KSUBYRKxemmh9spjzYy1jQ4C+NTi966ChefcIeNYTkTNYI5rIf2cqdmMjYvaI0ivmBnHnWAWT/8wy2mFhFQmssnDfIC2Ofc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDfsfCZ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BwLi/fZD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 17:14:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740762843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVq1fsVwKJQ065yNUvP8FvYbfitStPoHjuHRmULWWeA=;
	b=pDfsfCZ7w2dNzAWyVAMlSRcwnf+3fc3TKwd3awctD94A9FNlnYcRX937hWZtnFJVi9kIU5
	Le0ss4gWPn42p1LDN+veMtiQpf2IVoIQe8Mhbph0UR82hXMKEp4K2r8HFPZSW+SAABJUCA
	LTY9Gj50Q3WQEdgR9+/6ADw9jHU1dVgAfV4AFFKhLV7fDNn7d8Z6j3wQxvS6Zyxxpdbu1a
	fRReoPIHk+dwl6zC9/+Mfr2mjNKVwkYp4C+Eb3VE/TLRQufwGG9J6zk7cEn4aCOv1wkV+b
	2ChO6HaiSdLkiw81MdX6ZwE4Ol0pTo9JZS9b7nwU8ugV20X/YYMQdxchyg07/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740762843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVq1fsVwKJQ065yNUvP8FvYbfitStPoHjuHRmULWWeA=;
	b=BwLi/fZDeFiAN4dxJi6OTDQC3H8/T6oeRRIafuJElx9srOK6VQZGlFEJM+78ZvUBvX3V/E
	qHFshinFFTbPMrCg==
From: "tip-bot2 for Philip Redkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm: Check return value from memblock_phys_alloc_range()
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
Message-ID: <174076284296.10177.8589425371875617719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     fd5935f9c20431eeadd6993fd4d2672e3e17a6b8
Gitweb:        https://git.kernel.org/tip/fd5935f9c20431eeadd6993fd4d2672e3e17a6b8
Author:        Philip Redkin <me@rarity.fan>
AuthorDate:    Fri, 15 Nov 2024 20:36:59 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 18:02:10 +01:00

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

