Return-Path: <linux-tip-commits+bounces-4024-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E936A5476C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952343A8F44
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983B41C92;
	Thu,  6 Mar 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6LxtbVa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ppDqGDiw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8919DF49;
	Thu,  6 Mar 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256032; cv=none; b=Wsv9ZAezP1nYgbkpyI72Z9tUMEC732B+HQPPhVwJxkRFTS2nkYy9F7QLvf+VlXpmJbdarQAMXLc9x+GcrTCmhEW86NLIsW0ZyAysZ8eUaOyC50v65MEAyLVhHXmEQ7SZjPJ+f4fMJpsEv0RyXKWQJlqF7l+xn7VL1RHV1Jwjbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256032; c=relaxed/simple;
	bh=df5gGnvs9z79Sddw7nzLHTjjjG5yNbKcZptAnRxlKSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dDo6AKLSRXB7ucPxBg6h+SnpOKDUvQFAHIY8k+j1wYKMNYRSnOwnbsLJNObj0dEkCpZpqubUA31p5xpxxrT196Ogd8NbK3Vo1FH3Z0oZVOnmLWBf4L50DRhPq9KgrHDEXvqlrDSR2rVBuh7akYMQ1e/+pMXCsB9Q+tZBzom+ZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6LxtbVa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ppDqGDiw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 10:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741256029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EhcSOaHj8qjHFqnzylinI18wubMEWxY4nGcaetKP6s=;
	b=z6LxtbVa7r74gdNccPHjbmqkCF8GeZXY5tFQWIIdbJJh+WfNkwUl1rlNYCbmcAAFFBiqcV
	V4jzlWzzV6bXnVAD+/us5rqX8I/Ng6AcGbtn+fg7NYRoeQYW32GhQMM2NBe+1tQfvD/8vL
	Dwkz2fKP9V63dVCgL/+4K6tCLJVbgycLY6pU6cufKVo19QMcz25jhoIEfmOR+wtQ1f95FG
	1sRJZZs9Fbu36C+kfHr/doQ4PlvCPmIvcJ6+mwhKUcQT5I2mPqyU6P4TFpvT4MwEhzMvsa
	UAQVCSaajjWJgKWYhgNYQyBCxSu8h/bCb76NnPJZ2vIPjUAGSzUoMnnWDjGf7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741256029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EhcSOaHj8qjHFqnzylinI18wubMEWxY4nGcaetKP6s=;
	b=ppDqGDiwNouqUeXGF0+avN0aRwA9vTbL1KYjCvJ9l7Jc0rYsd/oJEAr2cprCodjWqQx0Hz
	u4luXe9hN5cc6NCw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Check if PTRS_PER_PMD is defined before use
Cc: kernel test robot <lkp@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     74a6c5103f8c27df056227e9e3bfe1ffeb7fc3f3
Gitweb:        https://git.kernel.org/tip/74a6c5103f8c27df056227e9e3bfe1ffeb7fc3f3
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 06 Mar 2025 11:25:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 11:03:59 +01:00

x86/mm: Check if PTRS_PER_PMD is defined before use

Compiler (GCC) is not happy about PTRS_PER_PMD being undefined
(note, clang also issues the quite similar warning):

  In file included from arch/x86/kernel/head_32.S:29:
  arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
     59 | #if PTRS_PER_PMD > 1

Add a check to make sure PTRS_PER_PMD is defined before use.

The documentation for GCC 7.5.0+ says that:

	if defined BUFSIZE && BUFSIZE >= 1024

    can generally be simplified to just #if BUFSIZE >= 1024, since if BUFSIZE
    is not defined, it will be interpreted as having the value zero.

But in the same time the last paragraph points out that

    It will warn wherever your code uses this feature.

which is what we met here.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250306092658.378837-1-andriy.shevchenko@linux.intel.com

Closes: https://lore.kernel.org/r/202412152358.l9RJiVaH-lkp@intel.com/
---
 arch/x86/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 7d4ad89..3c05235 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -56,7 +56,7 @@ do {						\
  * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
  * the PMD's in addition to the pages required for the last level pagetables.
  */
-#if PTRS_PER_PMD > 1
+#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)
 #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
 #else
 #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)

