Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2698F32B07F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhCCDi6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:38:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577822AbhCBJz3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:55:29 -0500
Date:   Tue, 02 Mar 2021 09:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614678887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdMwa28/D84xxtnuOLco75KoubU2WJqel+lPTNDm290=;
        b=ckxgc9o/MxM0GlJMnx8c/17tZqiEWiHlcbR7MzDSH9lOyrKIccQJ/J9+mDmXTjRFlSeZfe
        nJIUPmRsgLfk1KrwAlQGlJEImyP5j80C+cpUr6ymhPN8etMqtRKAIwzfv08Lk1HdNJnlXp
        +sZ9UBMCrZBctoDg9uTJ++gVZP8UJIAMnIfzhk0U0/ekYmtATLoGJgp05Q16lzMKryAqVS
        pWVrT0b3/MqAlPslXd7J9fmjKI3WdpFdFnmA8J9uUEkZq0h9KH8xd9/nCYiA6+t7qceByY
        F/ptB+DlSu0h+y/hWCAup6NcrbFHvBhwiHyWY3/JKtqNwMRPpqO1yLhXQNSpwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614678887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdMwa28/D84xxtnuOLco75KoubU2WJqel+lPTNDm290=;
        b=Ikcfcigf8UclZGY7il6tLjPf+u1aNaYwi1K48gwgvzc/a533IHgDM4uLHASN07dLVBKrRx
        kQ7IONZoo4r5gMAg==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] cpumask: Mark functions as pure
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-8-namit@vmware.com>
References: <20210220231712.2475218-8-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161467888701.20312.1318725806452977108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1028a5918cbaae6b9d7f0a04b6a200b9e67aec14
Gitweb:        https://git.kernel.org/tip/1028a5918cbaae6b9d7f0a04b6a200b9e67aec14
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:10 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Mar 2021 08:01:38 +01:00

cpumask: Mark functions as pure

cpumask_next_and() and cpumask_any_but() are pure, and marking them as
such seems to generate different and presumably better code for
native_flush_tlb_multi().

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20210220231712.2475218-8-namit@vmware.com
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e..c53364c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -235,7 +235,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -252,8 +252,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
