Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033BE3C6977
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jul 2021 06:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhGMEjL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 13 Jul 2021 00:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhGMEjK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 13 Jul 2021 00:39:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A4C0613DD;
        Mon, 12 Jul 2021 21:36:20 -0700 (PDT)
Date:   Tue, 13 Jul 2021 04:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626150977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OLxfYBTXkYYVSMMoc07cFS3jYh3pW4pxki3au8TXW9s=;
        b=IL59anytZ6Ji8mFDCiA5rAohHQtisVQCaZVJ2TLyidy7Ody4GiZzwkgRn/rDXuIiflJa4G
        jeFTGCvNGU9qXLzS7dzzt0xUlFkPKu9plg5l00tbjOOKCx0U95CDDoRO0gd5q2pWspzo9I
        Eld0bIFL2aJOLQ1Bbjx88cnyNbZgvn/q2pOCRN+qqPNomh+iNW1HldEphD8aboL4dw4z/F
        rVNqLihOjAgdr1v5p2x55QeN55wMKcfqYu8h+8XmN+vzZeD8sMN1q90UNZ+5J7NVRaAzWr
        NmSXNy8EnGGCTzdqeGclwiWMckzPJjfCJ5lvken5+6iqDSx8rzBBfoh4q+Q7MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626150977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OLxfYBTXkYYVSMMoc07cFS3jYh3pW4pxki3au8TXW9s=;
        b=pFZW7wGNvV06mPqXSqb6ywHIMNK8vF6OM0aS+GByJqdHW8yFPYNXUUFp7fmqh87bQODiER
        Fa1L5hm/12j6FnBg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] jump_labels: Mark __jump_label_transform() as
 __always_inlined to work around aggressive compiler un-inlining
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162615097706.395.9514541982225963135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     e48a12e546ecbfb0718176037eae0ad60598a29a
Gitweb:        https://git.kernel.org/tip/e48a12e546ecbfb0718176037eae0ad60598a29a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 13 Jul 2021 06:16:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 13 Jul 2021 06:32:05 +02:00

jump_labels: Mark __jump_label_transform() as __always_inlined to work around aggressive compiler un-inlining

In randconfig testing, certain UBSAN and CC Kconfig combinations
with GCC 10.3.0:

  CONFIG_X86_32=y

  CONFIG_CC_OPTIMIZE_FOR_SIZE=y

  CONFIG_UBSAN=y
  # CONFIG_UBSAN_TRAP is not set
  # CONFIG_UBSAN_BOUNDS is not set
  CONFIG_UBSAN_SHIFT=y
  # CONFIG_UBSAN_DIV_ZERO is not set
  CONFIG_UBSAN_UNREACHABLE=y
  CONFIG_UBSAN_BOOL=y
  # CONFIG_UBSAN_ENUM is not set
  # CONFIG_UBSAN_ALIGNMENT is not set
  # CONFIG_UBSAN_SANITIZE_ALL is not set

... produce this build warning (and build error if
CONFIG_SECTION_MISMATCH_WARN_ONLY=y is set):

  WARNING: modpost: vmlinux.o(.text+0x4c1cc): Section mismatch in reference from the function __jump_label_transform() to the function .init.text:text_poke_early()
  The function __jump_label_transform() references
  the function __init text_poke_early().
  This is often because __jump_label_transform lacks a __init
  annotation or the annotation of text_poke_early is wrong.

  ERROR: modpost: Section mismatches detected.

The problem is that __jump_label_transform() gets uninlined by GCC,
despite there being only a single local scope user of the 'static inline'
function.

Mark the function __always_inline instead, to work around this compiler
bug/artifact.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/jump_label.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 674906f..68f091b 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -79,9 +79,10 @@ __jump_label_patch(struct jump_entry *entry, enum jump_label_type type)
 	return (struct jump_label_patch){.code = code, .size = size};
 }
 
-static inline void __jump_label_transform(struct jump_entry *entry,
-					  enum jump_label_type type,
-					  int init)
+static __always_inline void
+__jump_label_transform(struct jump_entry *entry,
+		       enum jump_label_type type,
+		       int init)
 {
 	const struct jump_label_patch jlp = __jump_label_patch(entry, type);
 
