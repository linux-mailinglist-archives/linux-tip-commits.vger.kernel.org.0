Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8874F22E128
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Jul 2020 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGZQSb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Jul 2020 12:18:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGZQSb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Jul 2020 12:18:31 -0400
Date:   Sun, 26 Jul 2020 16:18:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595780309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3YYkjEvHjiHC/Ar2ExSh+apOQlT3lexx+oztxhhe5u4=;
        b=HhrGLMh4k5TPKDQqha+N9Eenz9c+jaIjtRr9NMOPCXYX88u8sk5TwJLOk0OzYaRh8ewVph
        fuSJJEO0P3V3xB2Nf/Y6eNbrMYLA69z4HDFFSDpddFDtX36FzHOUJhJdFIxHoCH4IHNXji
        CtCXRn9mdjaDAkCVlKq7+G6BYz9tnby5rWVJhIyh9V6dOVKekS+PP4jPsPYdE0XJ6hn5wQ
        th6WkfPDbHveLItPD2DApgi3BoPJXEn5OIRKNafOCouNSrG5twlSOhebVINmAwG8bQJc6y
        jKiu3dsjeksUjgG8uGO6tPLVZndSbEWd7Ax34skNiDQBlBSNoA5CGNFyyyZysA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595780309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3YYkjEvHjiHC/Ar2ExSh+apOQlT3lexx+oztxhhe5u4=;
        b=JJTCDxRDmxf5RIDJ15X6jBZV0oykix3vBmwPeGjrb8r3uTiad9dWfrjiUkAo+NzXdebNy2
        q3YOEySczfqYmMBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Correct __secure_computing() stub
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159578030831.4006.6596919231002837614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     543f5898d805e7e58bc5eadc20ed0a468368e7fd
Gitweb:        https://git.kernel.org/tip/543f5898d805e7e58bc5eadc20ed0a468368e7fd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 26 Jul 2020 18:14:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 26 Jul 2020 18:17:26 +02:00

entry: Correct __secure_computing() stub

The original version of that used secure_computing() which has no
arguments. Review requested to switch to __secure_computing() which has
one. The function name was correct, but no argument added and of course
compiling without SECCOMP was deemed overrated.

Add the missing function argument.

Fixes: 6823ecabf030 ("seccomp: Provide stub for __secure_computing()")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/seccomp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 03d28c3..3bcc214 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -58,9 +58,10 @@ static inline int seccomp_mode(struct seccomp *s)
 
 struct seccomp { };
 struct seccomp_filter { };
+struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(void) { return 0; }
+static inline int secure_computing(const struct seccomp_data *sd) { return 0; }
 static inline int __secure_computing(void) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
