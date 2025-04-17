Return-Path: <linux-tip-commits+bounces-5046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EFA925DA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C368D7B604C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91E2561D5;
	Thu, 17 Apr 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUYX0SbC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sCgOLh8R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DD223710;
	Thu, 17 Apr 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913008; cv=none; b=TRl5FTfc3u0PyWIvceQ8HidELrjowMocPC2q6XPE7HhQDl6agaGKhMGSh4yMYkua++CClE1kt/tB4R/kra5BrV1lyLTrpkoPdLX/voM5/ichHu0Zv8sO+zSOTidYhEPqBbADh6yKltpUf27MB00WrDOZ/nHc/E33wz2tNeiknbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913008; c=relaxed/simple;
	bh=q/YUMyvtA4CGWflwbOipWzxrfqKCWKATN9nfNhn442w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uRxlaFnNODpUpVI+4kvzkq1BL7vA3pDjiZeXnOtAN0WT0mcr8R+W/tDETgjSAiRkMQ4d0gmT+5Hzwdc4mHfSA4QF3JyQSii+3DmXMdEXT0lc9DHt9T2pxyE+63WP7vaZETkAGwatZqzaBxrHJCj4ZFwsnN4PPpxz3Z5eZvCgxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUYX0SbC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sCgOLh8R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pJjzOrk/Lt+dViISsPl7b5Bl4SuARsrqdBzGJXbcJuc=;
	b=PUYX0SbCB6eiQFaSAQWB0VM/o0lMGWduxnzFxn9UndCXlj0aByfMf0TwepOJTMfwclPgmR
	lrgBuYFjK8qrcVmH0NZ+npnsMTmN/HtssGPtRgvZrIr/Tdc7Pi8ky34TsfElNCdCYGUMg7
	leJHw6FkuF/j355gB7QwMM041roU1BpkARr/O8liV1ebKkr5AZadUE2dhdcsG6slzOXX/H
	KwlbTNFZqaTpbFbhd3Ck0R3FcvdNOOyMYpvcq8dFT3h1w6q1Zu/pC4RmWS2hsk+4W/8ZfI
	1Uy2xEklJNrJopAW+FsygsO/bMTjmzpIkJFi5iFDRLtal9n54gnyHKkFytHEtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pJjzOrk/Lt+dViISsPl7b5Bl4SuARsrqdBzGJXbcJuc=;
	b=sCgOLh8RZmqOmylJRKjS/waYTnrRdyDn/JnGCO2vRgHuCRTvtmKcqHAyilCL6cn8VMiED0
	Dkv1jmED2qqKHuDA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove duplicated PMD preallocation macro
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300425.31282.4892024487045944709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     99b8f0c54f571616d7bf4a776a2863a321c38cb1
Gitweb:        https://git.kernel.org/tip/99b8f0c54f571616d7bf4a776a2863a321c38cb1
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:42 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Remove duplicated PMD preallocation macro

MAX_PREALLOCATED_PMDS and PREALLOCATED_PMDS are now identical. Just
use PREALLOCATED_PMDS and remove "MAX".

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173242.5ED13A5B%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pgtable.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f4fa8fa..c1144e2 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -118,7 +118,6 @@ static void pgd_dtor(pgd_t *pgd)
  * new process's life, we just pre-populate them here.
  */
 #define PREALLOCATED_PMDS	PTRS_PER_PGD
-#define MAX_PREALLOCATED_PMDS	PTRS_PER_PGD
 
 /*
  * "USER_PMDS" are the PMDs for the user copy of the page tables when
@@ -154,7 +153,6 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
 /* No need to prepopulate any pagetable entries in non-PAE modes. */
 #define PREALLOCATED_PMDS	0
-#define MAX_PREALLOCATED_PMDS	0
 #define PREALLOCATED_USER_PMDS	 0
 #define MAX_PREALLOCATED_USER_PMDS 0
 #endif	/* CONFIG_X86_PAE */
@@ -324,7 +322,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
-	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
+	pmd_t *pmds[PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc(mm);
 

