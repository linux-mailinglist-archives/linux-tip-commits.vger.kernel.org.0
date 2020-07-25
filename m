Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21B22D69F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jul 2020 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGYKNm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jul 2020 06:13:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYKNl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jul 2020 06:13:41 -0400
Date:   Sat, 25 Jul 2020 10:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595672020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMrAlyOGIn738wM0N0xR3lzjSDszTSHPdqD5zD669Ww=;
        b=S/NEFGrUKpNWLEFFTe3oI0dY2QBivzlIqAAX63K9e+Tl74jgNw0hVZ7vH0Zjpe04yCULU3
        oj+F5IYF22xpRdWvPnvA6yUQJag0whPuuVOjLz69T28+9dtru0Oaji6tNLDuHpX+WqnU3m
        N2gV0XxSYxdQvhIPRDIRo7uzJpPdzGhdPUCSvLe81HCQpA94ifteLORRbxTHqPzyrczKjj
        5Im649U9R3qlURXK9jphh0ZtNYqsKEaasvmkQScPJ4S2Qg8g7vNCB/8ffDK/CjtHSkvMr4
        H1xpEP0ELrnAqT8MB7SlDnt5mXdxXHgvw2rtJtrqpmO5eIqxyuiYnC4EyqCtGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595672020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMrAlyOGIn738wM0N0xR3lzjSDszTSHPdqD5zD669Ww=;
        b=nPTL2EZBqoXoG68jewYmP+olzeS7loOkhg6w0jGcBXYfycn35a9XPFygAMcIIiBv0oQ52s
        bnJ/gvE3hXMulRAA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Remove the unused mk_kernel_pgd() #define
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200724114418.629021-4-mingo@kernel.org>
References: <20200724114418.629021-4-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <159567201969.4006.15220161067207214829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4b8e0328e56e177663645a96ea4c5c0401ecd78f
Gitweb:        https://git.kernel.org/tip/4b8e0328e56e177663645a96ea4c5c0401ecd78f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 24 Jul 2020 13:44:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 12:00:57 +02:00

x86/mm: Remove the unused mk_kernel_pgd() #define

AFAICS the last uses of directly 'making' kernel PGDs was removed 7 years ago:

  8b78c21d72d9: ("x86, 64bit, mm: hibernate use generic mapping_init")

Where the explicit PGD walking loop was replaced with kernel_ident_mapping_init()
calls. This was then (unnecessarily) carried over through the 5-level paging conversion.

Also clean up the 'level' comments a bit, to convey the original, meanwhile somewhat
bit-rotten notion, that these are empty comment blocks with no methods to handle any
of the levels except the PTE level.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200724114418.629021-4-mingo@kernel.org
---
 arch/x86/include/asm/pgtable_64.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 1b68d24..d2af8c4 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -175,16 +175,13 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
  * and a page entry and page directory to the page they refer to.
  */
 
-/*
- * Level 4 access.
- */
-#define mk_kernel_pgd(address) __pgd((address) | _KERNPG_TABLE)
+/* PGD - Level 4 access */
 
-/* PUD - Level3 access */
+/* PUD - Level 3 access */
 
-/* PMD  - Level 2 access */
+/* PMD - Level 2 access */
 
-/* PTE - Level 1 access. */
+/* PTE - Level 1 access */
 
 /*
  * Encode and de-code a swap entry
