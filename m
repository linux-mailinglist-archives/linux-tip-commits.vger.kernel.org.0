Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB75319EE9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhBLMnX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhBLMkm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:42 -0500
Date:   Fri, 12 Feb 2021 12:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FRaI3sQjCeshQMzGhBxLjEjmUL9tQ+4g486H8Z4AnyQ=;
        b=s+9maFWJ6du6OPx7Pxb08uPBKxeNXFAVErJFt2CNse2aAIsk62aTmPgKm6brzynWHmco9B
        ucPqL3Ozsx+wnWl1pAk8NSNLvF/03HQ3PCEY85EMRKq29vuqY/m05cXPadlEtmDukFskhA
        KKohH3l5E57ParUh4/KvHGy/BW0g2lTjN9FLm4WDe9sEZKkJY2b7FHIM60eNxHfaTtn6sL
        I/QqDCIMVw7JHOCZf/BgF+7eH3AJjS1y4WSD5CNX03rqZYx9idrL0J1FyVwajY7sy+OTfu
        Ri1uEDeo+z1c7i4aeCmgoJ+TJXvb/IjA5I41qMEPWgkyw+M+JMzL2EKarwhvmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FRaI3sQjCeshQMzGhBxLjEjmUL9tQ+4g486H8Z4AnyQ=;
        b=l1b8vkNh63f5ChQQe9AwZ9fSKOwkjVX9WCt5Q+6aMmNXKZAyw8/n7pU8wMkGZdYploWtEK
        c544VjZnc69WV3CQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make TASKS_TRACE_RCU select IRQ_WORK
Cc:     kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344327.23325.3926169999535371814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c26165efac41bce0c7764262b21f5897e771f34f
Gitweb:        https://git.kernel.org/tip/c26165efac41bce0c7764262b21f5897e771f34f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 21 Dec 2020 21:00:18 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 15:54:49 -08:00

rcu: Make TASKS_TRACE_RCU select IRQ_WORK

Tasks Trace RCU uses irq_work_queue() to safely awaken its grace-period
kthread, so this commit therefore causes the TASKS_TRACE_RCU Kconfig
option select the IRQ_WORK Kconfig option.

Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..84dfa8d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,6 +95,7 @@ config TASKS_RUDE_RCU
 
 config TASKS_TRACE_RCU
 	def_bool 0
+	select IRQ_WORK
 	help
 	  This option enables a task-based RCU implementation that uses
 	  explicit rcu_read_lock_trace() read-side markers, and allows
