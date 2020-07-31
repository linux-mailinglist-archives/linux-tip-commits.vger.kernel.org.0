Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3749E2342EE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgGaJ1I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:27:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732398AbgGaJXO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:14 -0400
Date:   Fri, 31 Jul 2020 09:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yAYiFwxU4IdAOrHOljH+7q7VJBQC1K79g743HdLNCK4=;
        b=CziwZMAcKZu3Nlc2/fm7flAroS1nddG54ipDyq+a0NfI/GAdPrUCwn0L9/BdCJxwnkeWpC
        rFVoovnW8VEk+0iA2oViqgrGLGxDXuO+j0scs/+wJDcXOcfvbXOoKrdiy8Awh/S2dR73iA
        DiZYgkzjbvRtxLcykddMe+cdKtfNu2c4h2AvqVt8PxqhTlZnu6Rep5YJX45ouU4HsyhImp
        S9kwqCHS+PfAc1C//rPnCZ88tLFCjJjZPOBHMBkPAQvTYQeNigNpSZtJ/biDRMQU9K3qlH
        M2On7qoq/qiH9o6AStaFgWG5FATgsOilX6PszGtfGjnF4+Rh2HFpwgN1gW7b2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yAYiFwxU4IdAOrHOljH+7q7VJBQC1K79g743HdLNCK4=;
        b=jjy60WRLERcO5+xU7R8TwcBvehzg8aE0YEMyx5XwYxU8qtTG3H0qAROX1B2hVmNHP81Bgz
        n1qTDBrvxySfnrDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add #include of rcupdate_trace.h to update.c
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739254.4006.12761856794820578212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5b3cc99bedf5885055fbaf35fe63d205f06b5be5
Gitweb:        https://git.kernel.org/tip/5b3cc99bedf5885055fbaf35fe63d205f06b5be5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 May 2020 19:33:47 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:22 -07:00

rcu-tasks: Add #include of rcupdate_trace.h to update.c

Although this is in some strict sense unnecessary, it is good to allow
the compiler to compare the function declaration with its definition.
This commit therefore adds a #include of linux/rcupdate_trace.h to
kernel/rcu/update.c.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843ad..c0fea80 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -42,6 +42,7 @@
 #include <linux/kprobes.h>
 #include <linux/slab.h>
 #include <linux/irq_work.h>
+#include <linux/rcupdate_trace.h>
 
 #define CREATE_TRACE_POINTS
 
