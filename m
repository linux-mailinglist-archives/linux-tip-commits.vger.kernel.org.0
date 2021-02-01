Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C33A30A695
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBALdI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBALdI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:08 -0500
Date:   Mon, 01 Feb 2021 11:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThkwSY9yhy4L4VL12JtDD6HHX7y3ZUozO4mN3+f9KQ8=;
        b=uXY2VqDpkHbJGF79IfFiPr9v6IF1SrEPstCNVXsJXM06hxgEb8YlJrxDMRtC7RcUOGIsbn
        MlgYcHH5lq5lgefvKdyqAmGX3VOOggkke5tZ/fcZ6saDNRrrOsTfMpk9HIr49jPOhklQPH
        OqVAi8t/c0TC94Fa+gepgAu4WgynWWPpvygWvxIk1Wn5/3vY/E3/bpnJrDzb89qsq1XeGv
        0pQ/0Sghpq/HuXL191BP0m1dHUSSYid3nUCF3H8DLezrXwfgVZNg4N+fVvd1erUAHlCBV+
        FGI4bpNfBwN4sgn9UFkf8vhg+idL4rmjg6dp8HGNBq5URh4XWmCltuqaY/vd/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThkwSY9yhy4L4VL12JtDD6HHX7y3ZUozO4mN3+f9KQ8=;
        b=kLi1YijIp/YLP4HFWn/jHl386euQkf+mrwARuipEJrVySnRR2bxbxFKWXv9+SjpPOsvlhh
        wONMZzkIuYkTqoBA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127235347.1402-6-will@kernel.org>
References: <20210127235347.1402-6-will@kernel.org>
MIME-Version: 1.0
Message-ID: <161217914543.23325.11625665091505426978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     c7bd8010a335260927e3643e79360272f9aca266
Gitweb:        https://git.kernel.org/tip/c7bd8010a335260927e3643e79360272f9aca266
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 23:53:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:29 +01:00

tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs

If __tlb_remove_tlb_entry() is not defined by the architecture then
we provide an empty definition in asm-generic/tlb.h.

Remove the redundant empty definitions for sparc64 and x86.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20210127235347.1402-6-will@kernel.org
---
 arch/sparc/include/asm/tlb_64.h | 1 -
 arch/x86/include/asm/tlb.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index e841cae..779a5a0 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -24,7 +24,6 @@ void flush_tlb_pending(void);
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #define tlb_flush(tlb)	flush_tlb_pending()
 
 /*
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 820082b..1bfe979 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -4,7 +4,6 @@
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
