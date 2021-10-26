Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1443B6D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJZQTR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbhJZQTN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:13 -0400
Date:   Tue, 26 Oct 2021 16:16:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30XCVgmwaovkWEUMbRcyHPfNsu0Xryx+pyJdstab2r0=;
        b=tTgq/yw/NdeWaN/I57IKCZRzqFwxctM12+NeafcSHSbB7jKO4S6NAybZtGV9ydUprUqMA0
        AtWLxXKvbfJx7jYmQR+X4u16bTRKAS7DlENiIbagJ0dUApXeYj2RyNwbfeIE4IKLnT/oyC
        kcYjBHx3Hrop1C5xHxCKM0Fluh3Da32avGK7cYIhSeOIi22h9VZuJLWOg8um9wjLmaZjFB
        wpbCoRnSUAjgmhul0ua+/kL67ge1BkMHUZ5qnu4tODHHpdLF9GhjREad4Y5XZXnGadyv4z
        5sEa/0ct/vhdmvGLe15ZGZklm9dGi/qqDNpwkeeAnvhpDRP9xhpbg0/+ngHbbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30XCVgmwaovkWEUMbRcyHPfNsu0Xryx+pyJdstab2r0=;
        b=ATeIhhIkNbbLREdXcjv+rjwZWnnZT8E6lNLpYt3VAEpkJk5mLQrEjqqyTsGnTtT6lqXS5n
        AyP6hV83GqN0WqCA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Provide xstate_calculate_size()
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-4-chang.seok.bae@intel.com>
References: <20211021225527.10184-4-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500769.626.2064661725935611440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     84e4dccc8fce20b497388d756e12de5c9006eb48
Gitweb:        https://git.kernel.org/tip/84e4dccc8fce20b497388d756e12de5c9006eb48
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:07 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu/xstate: Provide xstate_calculate_size()

Split out the size calculation from the paranoia check so it can be used
for recalculating buffer sizes when dynamically enabled features are
supported.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
[ tglx: Adopted to changed base code ]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-4-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 46 +++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cbba381..310c420 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -549,6 +549,33 @@ static bool __init check_xstate_against_struct(int nr)
 	return true;
 }
 
+static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
+{
+	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	int i;
+
+	for_each_extended_xfeature(i, xfeatures) {
+		/* Align from the end of the previous feature */
+		if (xfeature_is_aligned(i))
+			size = ALIGN(size, 64);
+		/*
+		 * In compacted format the enabled features are packed,
+		 * i.e. disabled features do not occupy space.
+		 *
+		 * In non-compacted format the offsets are fixed and
+		 * disabled states still occupy space in the memory buffer.
+		 */
+		if (!compacted)
+			size = xfeature_uncompacted_offset(i);
+		/*
+		 * Add the feature size even for non-compacted format
+		 * to make the end result correct
+		 */
+		size += xfeature_size(i);
+	}
+	return size;
+}
+
 /*
  * This essentially double-checks what the cpu told us about
  * how large the XSAVE buffer needs to be.  We are recalculating
@@ -575,25 +602,8 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 			XSTATE_WARN_ON(1);
 			return false;
 		}
-
-		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
-			size = ALIGN(size, 64);
-		/*
-		 * In compacted format the enabled features are packed,
-		 * i.e. disabled features do not occupy space.
-		 *
-		 * In non-compacted format the offsets are fixed and
-		 * disabled states still occupy space in the memory buffer.
-		 */
-		if (!compacted)
-			size = xfeature_uncompacted_offset(i);
-		/*
-		 * Add the feature size even for non-compacted format
-		 * to make the end result correct
-		 */
-		size += xfeature_size(i);
 	}
+	size = xstate_calculate_size(fpu_kernel_cfg.max_features, compacted);
 	XSTATE_WARN_ON(size != kernel_size);
 	return size == kernel_size;
 }
