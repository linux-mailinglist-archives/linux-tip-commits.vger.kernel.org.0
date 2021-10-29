Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19C843F86D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhJ2IFi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhJ2IFc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:32 -0400
Date:   Fri, 29 Oct 2021 08:03:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s24nAzLA7D+EbUWx5IyHx1LUfEqdaXrozApp64hiup4=;
        b=JzMvPgpN02ngY5tm05B570JTqkFrx9b8hAS6+rME/tRMxhRD2G8Tx+XEBPMZ2G7EFVRk+w
        +wDjXHg1gvchoyLZf+Iqvd4wGGzxoEVmx6OefCKsKAGc+UXRD9/JGW+AzFfEEXKb91JAaa
        8DNBb8KYBDCyUPJHH5XpDg8lbDpy2znsvTR/5m7FYUNvcMzGjY4P0wCp4CYLCHobmo+yxz
        Z5pENbkBxwSm6EynG97kBvfZsEhIfp/INjOxhLULPcyyHFaHpFe0aXray5q+2/VqMjKkw+
        iO8u+wcE1WNuYmO5hRx9w8zXFji5J2jOEuq4g9Wd1/Daypa/txhMI6sD0ujHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s24nAzLA7D+EbUWx5IyHx1LUfEqdaXrozApp64hiup4=;
        b=6TWhukCEOl0kcFO6v6bWihmXbzyiaF4NTSEb6WKtsQTegLe9r9oUSi1OGOT4ZTuE0U1O43
        PJieUHsq7IlmMoAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/asm: Fix register order
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120309.978573921@infradead.org>
References: <20211026120309.978573921@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458269.626.2254333849360951638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a92ede2d584a2e070def59c7e47e6b6f6341c55c
Gitweb:        https://git.kernel.org/tip/a92ede2d584a2e070def59c7e47e6b6f6341c55c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:26 +02:00

x86/asm: Fix register order

Ensure the register order is correct; this allows for easy translation
between register number and trampoline and vice-versa.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120309.978573921@infradead.org
---
 arch/x86/include/asm/GEN-for-each-reg.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/GEN-for-each-reg.h b/arch/x86/include/asm/GEN-for-each-reg.h
index 1b07fb1..0794910 100644
--- a/arch/x86/include/asm/GEN-for-each-reg.h
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -1,11 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * These are in machine order; things rely on that.
+ */
 #ifdef CONFIG_64BIT
 GEN(rax)
-GEN(rbx)
 GEN(rcx)
 GEN(rdx)
+GEN(rbx)
+GEN(rsp)
+GEN(rbp)
 GEN(rsi)
 GEN(rdi)
-GEN(rbp)
 GEN(r8)
 GEN(r9)
 GEN(r10)
@@ -16,10 +21,11 @@ GEN(r14)
 GEN(r15)
 #else
 GEN(eax)
-GEN(ebx)
 GEN(ecx)
 GEN(edx)
+GEN(ebx)
+GEN(esp)
+GEN(ebp)
 GEN(esi)
 GEN(edi)
-GEN(ebp)
 #endif
