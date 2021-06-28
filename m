Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD33B58B9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 07:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhF1Fsm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 01:48:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhF1Fsl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 01:48:41 -0400
Date:   Mon, 28 Jun 2021 05:46:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624859175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UAKjJdWtmKqBJLNF534pJg0UNDZh4brZXeI5Pyc4bHw=;
        b=rJ1Gfl0xdxzs1eAYm14N53fVDVrP2fEKCcrcRbghQR4YobHZG/M8K6/HZISqCYGg+Bk2bq
        6/GAlrigC8J1K1KAsVz26J3p8hnl1uj1WFfpgtM8ntuLHQ3QvRo2au2slntKpTaXW+h5M+
        ut4pXPNu72qYAH4jzj/SB+QcgTNM5t5syhDvpdkCb/YPhshSH3LC4NeMz4GL6BfWhGnB8T
        5tSyTtnW0SDDxjt9/PONq0p6OX+djBs7NWOVOsvLSC96cpTsKPgrho4KPbo7LDaxuHqvQs
        YMqn21n94roDjgssNMzxtpgc7KhLKErQWgoZqmLO3RcYNuOhG6sYzUii/bTA5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624859175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UAKjJdWtmKqBJLNF534pJg0UNDZh4brZXeI5Pyc4bHw=;
        b=IAsNKXpEdNM/jH2TVUybCfLQPS1rVE44tYcKi+iN1sFEWgeyyqUN//Zy7ab8Sb9A+MrRRH
        hbO+MfVkwX6RKiAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/kunit: Add missing MODULE_LICENSE()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162485917429.395.4159105611609357619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2d0a9eb23ccfdf11308bec6db0bc007585d919d2
Gitweb:        https://git.kernel.org/tip/2d0a9eb23ccfdf11308bec6db0bc007585d919d2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 26 Jun 2021 22:44:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Jun 2021 07:40:23 +02:00

time/kunit: Add missing MODULE_LICENSE()

[ mingo: MODULE_LICENSE() takes a string. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/time_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 341ebfa..831e8e7 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -96,3 +96,4 @@ static struct kunit_suite time_test_suite = {
 };
 
 kunit_test_suite(time_test_suite);
+MODULE_LICENSE("GPL");
