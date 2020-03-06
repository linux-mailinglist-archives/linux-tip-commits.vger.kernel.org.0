Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698A717BA62
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2020 11:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCFKjJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Mar 2020 05:39:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCFKjJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAANk-0000CP-1q; Fri, 06 Mar 2020 11:39:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 71EFC1C0081;
        Fri,  6 Mar 2020 11:39:03 +0100 (CET)
Date:   Fri, 06 Mar 2020 10:39:03 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] asm-generic/bitops: Update stale comment
Cc:     Stefan Asserhall <stefana@xilinx.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213093927.1836-1-will@kernel.org>
References: <20200213093927.1836-1-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158349114313.28353.2410503196690088637.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5d0c9b0eb8ab2dd540919174abe75aa3b86b802f
Gitweb:        https://git.kernel.org/tip/5d0c9b0eb8ab2dd540919174abe75aa3b86b802f
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Thu, 13 Feb 2020 09:39:27 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Mar 2020 11:06:19 +01:00

asm-generic/bitops: Update stale comment

The comment in 'asm-generic/bitops.h' states that you should "recode
these in the native assembly language, if at all possible". This is
pretty crappy advice now that the generic implementation is defined in
terms of atomic_long_t rather than a spinlock, so update the comment and
hopefully save future architecture maintainers a bit of work.

Reported-by: Stefan Asserhall <stefana@xilinx.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200213093927.1836-1-will@kernel.org
---
 include/asm-generic/bitops.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index bfc96bf..df9b5bc 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -4,8 +4,9 @@
 
 /*
  * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents.  You should
- * recode these in the native assembly language, if at all possible.
+ * architecture, here are some C-language equivalents.  They should
+ * generate reasonable code, so take a look at what your compiler spits
+ * out before rolling your own buggy implementation in assembly language.
  *
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
