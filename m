Return-Path: <linux-tip-commits+bounces-4616-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43470A783A3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 22:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE957A43E8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE62144BB;
	Tue,  1 Apr 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYU8wucA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JD9Yn/L6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643B211282;
	Tue,  1 Apr 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540807; cv=none; b=bqO7+ns7PzSWi7UQLCPRYtijzMLHo/dkjKiVkXnNo/EkRF086UAH1IbezIb9vb3S/JQNCd7cbZBOzb5Coswvnom6PJFDrTqiR3WgoZFPIA0BGksGD9ciELfLzur6+JncQHg3ifV3pTz4gwEskDsYhaDMDWW8GU6s7GvXjvIdZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540807; c=relaxed/simple;
	bh=OwPFl+bzaq2c22kXF7mT6FC9c6PLdvj1QQiDKagvONY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gEImGIIPI5wlaUAtqMOzVpCuHTkuexNrizQrImt5oDM3JOYiU7P20Cedt5nq8zb4EJexsZWw8+bkXXKqv9MkNY8eBYK8PKbKu1W6LZfFQy1JSKZWHcAVRnRjdcO+FQXk/yDhZlL+T/kSSkbg39ObSRPmp8dw/Fe2oYCNXkT03Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYU8wucA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JD9Yn/L6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 20:53:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743540804;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLCxtEpaGgglAynKaTg7VHL/OLuEcvNWQbJKHrQCR/Q=;
	b=FYU8wucAbIdLdV/F7Wl4L/aY5J291mm7ar74pdU6bHzGYW02fqT8JGij9ruF/sEIC91z3j
	q4ppBEUou38pUC51CRvKWEBj/cPr5kCORoiS/989FP7xnM/jprUSPk9SM5rfqvkSdzM+Hq
	/ojikz0hBsHKqbPqe0JTAkB7M35jO8Cif6QRujSfHI85oS2H0T/DFE4x0DXazvF66IoPLV
	wb3E78/bHDA4Et8vlbjXp0EGcSmeuMPPVlf3gyYhZ7REldj+2341xwTsoP3qc2iui1OO7H
	3nmub7X4lyewLvPEyinKSoNpycCuM6gK1NsO8qafPhTWzTcNLOPFKcAcW+5lgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743540804;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLCxtEpaGgglAynKaTg7VHL/OLuEcvNWQbJKHrQCR/Q=;
	b=JD9Yn/L62E71mKnZHBT+/KK9RnjyJyu6bJZ04flCZOcZz7M/EZes3rLPy9tFlvXzw/M/t2
	qGYDYaFlYgqK71Cg==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the arch-specific pgd_leaf() definition
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-6-bhe@redhat.com>
References: <20250331081327.256412-6-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174354080373.14745.16179554733114666534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b0510ac74e189442dde8799c1b212bd106f2300c
Gitweb:        https://git.kernel.org/tip/b0510ac74e189442dde8799c1b212bd106f2300c
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:46:51 +02:00

x86/mm: Remove the arch-specific pgd_leaf() definition

PGD huge pages are not supported yet, let's use the generic definition
in <linux/pgtable.h>.

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Link: https://lore.kernel.org/r/20250331081327.256412-6-bhe@redhat.com
---
 arch/x86/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7bd6bd6..5f4fcc0 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1472,9 +1472,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
-#define pgd_leaf	pgd_leaf
-static inline bool pgd_leaf(pgd_t pgd) { return false; }
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages

