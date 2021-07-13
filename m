Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DDB3C6975
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jul 2021 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGMEi5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 13 Jul 2021 00:38:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhGMEiz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 13 Jul 2021 00:38:55 -0400
Date:   Tue, 13 Jul 2021 04:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626150963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jj6UyBOyXEzLFWsMg+oxI+l23bxA8dSQx3WFTtDkRN8=;
        b=X2LLF0sHciBknYHGuLByDH9sM5khpkVqiHnMg9B2l2Qnw0BAV4eMMqOsgtIr6LohnlKC+9
        9ksSq13lz96Z9290FttSJXclTtVZAr2z/aFqIG1EXt+/RknoJdwHKkQ6NgdocuiO3jn1rk
        i6hEzTOsYgrgF0bNYp4RXXFeN2v/lPlNw6mJgDnc5epqLU9d/a2Pih1nQaCVeutdA57f65
        M4bj3Y0E+bwr7YnwNk9j7n7dIawc3teoXrXHIf4n1SasR8rVNXXnOBS0Ntcfuj6BmOaWwz
        0sPTttc4A5+QKrvkoIenXocPlg2hCSJM2BCwgWByOr7ORH1prsQK5/sp1bA+sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626150963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jj6UyBOyXEzLFWsMg+oxI+l23bxA8dSQx3WFTtDkRN8=;
        b=2CFfZDq3CEjJvoKyw92cqd4H+9W5ZSuzBY7s8OEaKfA2kDlmh+ClSrL1nrNx+yCAM2gDFS
        tGQ79q4OxkPfoyCQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] smpboot: Mark idle_init() as __always_inlined to
 work around aggressive compiler un-inlining
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162615096187.395.16156439314770075462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     e9ba16e68cce2f85e9f5d2eba5c0453f1a741fd2
Gitweb:        https://git.kernel.org/tip/e9ba16e68cce2f85e9f5d2eba5c0453f1a741fd2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 11 Jul 2021 08:26:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 13 Jul 2021 06:32:59 +02:00

smpboot: Mark idle_init() as __always_inlined to work around aggressive compiler un-inlining

While this function is a static inline, and is only used once in
local scope, certain Kconfig variations may cause it to be compiled
as a standalone function:

  89231bf0 <idle_init>:
  89231bf0:       83 05 60 d9 45 89 01    addl   $0x1,0x8945d960
  89231bf7:       55                      push   %ebp

Resulting in this build failure:

  WARNING: modpost: vmlinux.o(.text.unlikely+0x7fd5): Section mismatch in reference from the function idle_init() to the function .init.text:fork_idle()
  The function idle_init() references
  the function __init fork_idle().
  This is often because idle_init lacks a __init
  annotation or the annotation of fork_idle is wrong.
  ERROR: modpost: Section mismatches detected.

Certain USBSAN options x86-32 builds with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
seem to be causing this.

So mark idle_init() as __always_inline to work around this compiler
bug/feature.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index e416304..21b7953 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -47,7 +47,7 @@ void __init idle_thread_set_boot_cpu(void)
  *
  * Creates the thread if it does not exist.
  */
-static inline void idle_init(unsigned int cpu)
+static inline void __always_inline idle_init(unsigned int cpu)
 {
 	struct task_struct *tsk = per_cpu(idle_threads, cpu);
 
