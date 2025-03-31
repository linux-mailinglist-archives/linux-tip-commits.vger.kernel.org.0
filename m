Return-Path: <linux-tip-commits+bounces-4591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D93A7641E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB851168D29
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31491DF973;
	Mon, 31 Mar 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZSUQZ9A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMJFjmi+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DE42049;
	Mon, 31 Mar 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416764; cv=none; b=Q10x/+QGbLglIfd1wFLFaDmT9QZ5SNc4laaI9DfvRu4f2L0WQT40ECL8FVBepNhot25vOYeOXFGrRSoi1vP4bELnJPdzteqPjv3mTWamq6UytfGK/fpo3LeyGFVnxmsCTeorzfEaldrphudbujKvlEwD1wFLuCbEJbqlxPzNwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416764; c=relaxed/simple;
	bh=/X/1wsbn+AMNprRuQVkG3gb633UOdRlOjAv21BSWAfc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FEl9kBzhhqRRcG8Ic/JD6cTTq/3PmIdOgNycetFWXPhVQoA8J9a/XXa+cjn3rdECr9dSZf/5kb2gYDJ5fk/ZsmooSbq0cPguce5vFShT7bUQyBzTWdCY2AJK/Bk9WDA27HRSuiwF/UPwR68Z0iPFx5i300BU43DSju63FS3sH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZSUQZ9A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMJFjmi+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 10:25:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743416761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggyO31qNOxY/osgpsAPniVNGie+NfR9z05HtSwZ1MCg=;
	b=CZSUQZ9A+hb04Noy2gjkzULGz89GwEOYLm8IVddq2lT92tE12SHo8ROeoEbw9cAdtQcQd3
	vo94yrNyhqkNF1XC5DxUTuA1Y3W1s+ZTsGEhza2qGHp6dTMtOCy2q8dG5GV6H22sW3oBvb
	2E7QbVTKhdwLs/EhGc48SrJnu9PjEuVZtv9M8E5F6QRPS7jTz9DnxVxhS1vw2CZ3o5o1WL
	Nk8Qnp1+mtkZzhfQfFak2l74pRMrEiGX5whZIMnREFfBbtlgQVOyU75nmkBunWDbnmy/gr
	P6tYZzMHxgzePqhC2e0tTkcTwYHE2y8I3fQvZUwlJgwf+gxQEKuoppvnR5yonQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743416761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggyO31qNOxY/osgpsAPniVNGie+NfR9z05HtSwZ1MCg=;
	b=zMJFjmi+co/w8W4VRjykKXPWTqrg8/uhR643ZBk/vjrbKdZvCxQcEUMyqtSyG2tujsPj+0
	CFmXYtlCdPH4XZBQ==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the arch-specific p4d_leaf() definition
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-7-bhe@redhat.com>
References: <20250331081327.256412-7-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174341675980.14745.1298944085473516132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     3532c1f79ffcc57d14b8387a67b01797cc0e8be0
Gitweb:        https://git.kernel.org/tip/3532c1f79ffcc57d14b8387a67b01797cc0e8be0
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:26 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 31 Mar 2025 12:08:17 +02:00

x86/mm: Remove the arch-specific p4d_leaf() definition

P4D huge pages are not supported yet, let's use the generic definition
in <linux/pgtable.h>.

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250331081327.256412-7-bhe@redhat.com
---
 arch/x86/include/asm/pgtable.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5f4fcc0..5ddba36 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -292,13 +292,6 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
-#define p4d_leaf p4d_leaf
-static inline bool p4d_leaf(p4d_t p4d)
-{
-	/* No 512 GiB pages yet */
-	return 0;
-}
-
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 #define pmd_leaf pmd_leaf

