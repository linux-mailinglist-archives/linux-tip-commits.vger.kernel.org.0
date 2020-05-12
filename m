Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591DC1CF76A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 May 2020 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgELOiC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 May 2020 10:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgELOhC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 May 2020 10:37:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C8C061A0E;
        Tue, 12 May 2020 07:37:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1i-0005oe-1B; Tue, 12 May 2020 16:36:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D5561C0475;
        Tue, 12 May 2020 16:36:57 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:57 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] fault_inject: Don't rely on "return value" from
 WRITE_ONCE()
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-9-will@kernel.org>
References: <20200511204150.27858-9-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421751.390.2633100555064287266.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     9a7cb2d8d6b959fc11a34668b1523f745ae5f714
Gitweb:        https://git.kernel.org/tip/9a7cb2d8d6b959fc11a34668b1523f745ae5f714
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:12 +02:00

fault_inject: Don't rely on "return value" from WRITE_ONCE()

It's a bit weird that WRITE_ONCE() evaluates to the value it stores and
it's also different to smp_store_release(), which can't be used this
way.

In preparation for preventing this in WRITE_ONCE(), change the fault
injection code to use a local variable instead.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Link: https://lkml.kernel.org/r/20200511204150.27858-9-will@kernel.org

---
 lib/fault-inject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 8186ca8..ce12621 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -106,7 +106,9 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 		unsigned int fail_nth = READ_ONCE(current->fail_nth);
 
 		if (fail_nth) {
-			if (!WRITE_ONCE(current->fail_nth, fail_nth - 1))
+			fail_nth--;
+			WRITE_ONCE(current->fail_nth, fail_nth);
+			if (!fail_nth)
 				goto fail;
 
 			return false;
