Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAC3B6973
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 22:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhF1UIf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 16:08:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhF1UIf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 16:08:35 -0400
Date:   Mon, 28 Jun 2021 20:06:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624910767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YvDP/IlYkRfcGP3EXtU5tE7THSio+2IFxd9jh08Zifw=;
        b=tgIegyGU/5TTMoTgms+FPggFcBp06nt9Ce2DuSI/TDcLZWwnnHhoDelhI+xoD4JsLvfhD4
        O8H0dNbw5bSBexcGl1ERBDSA5WKYLFQfjxSzwcYqFhcxA26oTdRqT7KEMdjdo5G0Pk9VtW
        KWLL7cUGXZY0L0QoEuZr4lzI672o86EK3vJZSNDbrWxBg7ahuo7lcN9IecnuivA0/IacgV
        Z8FROXKryhd3nI+3fSjJLDHwbZAXS8ap2x9A6azSaEE9LHZ7hZmtnRJ038x+hL6rRgCq4s
        k7gbd+uGXWupWpZMw6k/Alna3YZiBCjQB7/2NviAGI35fOIn8ekxj/7QsiDtJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624910767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YvDP/IlYkRfcGP3EXtU5tE7THSio+2IFxd9jh08Zifw=;
        b=QY0YmxtpS0DmSMeB3O2Q9L4JlzTwvNOTqNz7hxfPHjnwyuDbh/wIholzjRkhLzsQgERXwe
        w0ljW+IVMtslKkAw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Disable CONFIG_SCHED_CORE by default
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162491076635.395.1145125297807393240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d29bcad34d042aefd79dec88caf4f0d2c1c961b
Gitweb:        https://git.kernel.org/tip/7d29bcad34d042aefd79dec88caf4f0d2c1c961b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 28 Jun 2021 21:55:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Jun 2021 21:58:35 +02:00

sched/core: Disable CONFIG_SCHED_CORE by default

This option adds extra overhead to the scheduler, and most users wouldn't want it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/Kconfig.preempt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c414..3654a92 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -102,7 +102,6 @@ config PREEMPT_DYNAMIC
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-	default y
 	depends on SCHED_SMT
 	help
 	  This option permits Core Scheduling, a means of coordinated task
