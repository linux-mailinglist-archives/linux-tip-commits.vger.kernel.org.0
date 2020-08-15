Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5993124531A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Aug 2020 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgHOV6B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 15 Aug 2020 17:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgHOVwA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F47C09B04E;
        Sat, 15 Aug 2020 08:47:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:46:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597506411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chcjr83BJGvHqcyPSbJuu69hZ3Bzn+h+dT5NU8PJR0c=;
        b=NoYHWaXlFP4iFWYRJGFkDqBUjeLtr5mgFIldN6XjTTF/dPlof8kCNH3P78AaV0axSpy0ZX
        4gDxPQ/Gk44z9EhQt6wDvUwGyhPYlgxWaNiQFPP2b9E98APU2hMVAPSYbvsuhJTMP6jvOE
        S7bg6keL4LpZUnXZCEgHZkfMDy+JijtKYCRcH8JLeK5sK3BltADUU5EzO1N/MhYqg8xFp+
        KQHSJ9SmxmmpGFeZ7YSEvedopArYy///Jd/XIJvMrGNp5vDwh8kKzWOjBf0MGrDluDKVh5
        yFDWj8oCAgtCQliFRZ2i1IR16ng0peY3kWUvoREIwfimPRnliBRmEwD9rGrQ3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597506411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chcjr83BJGvHqcyPSbJuu69hZ3Bzn+h+dT5NU8PJR0c=;
        b=+JH2Id1qxdAFWM9Xrx7zBAq20yXhG34rI/zk4FgSpkK2Q+6DwyPgTO/n/hBxUJIVb8mO2L
        8n26YfdRoQ6GSCBg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/entry/32: Simplify CONFIG_XEN_PV build dependency
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200815100641.26362-5-jgross@suse.com>
References: <20200815100641.26362-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <159750641102.3192.11180286110321491044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     76fdb041c1f02311e6e05211c895e932af08b041
Gitweb:        https://git.kernel.org/tip/76fdb041c1f02311e6e05211c895e932af08b041
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sat, 15 Aug 2020 12:06:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 13:52:12 +02:00

x86/entry/32: Simplify CONFIG_XEN_PV build dependency

With 32-bit Xen PV support gone, the following commit is not needed
anymore:

  a4c0e91d1d65bc58 ("x86/entry/32: Fix XEN_PV build dependency")

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200815100641.26362-5-jgross@suse.com
---
 arch/x86/include/asm/idtentry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a433661..337dcfd 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -547,7 +547,7 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	exc_machine_check);
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
+#ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
 #endif
 
@@ -557,7 +557,7 @@ DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
 #else
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	exc_debug);
 #endif
-#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
+#ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
 #endif
 
