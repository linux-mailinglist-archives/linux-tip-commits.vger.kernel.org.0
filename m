Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4613B5F76
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhF1OAb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 10:00:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48024 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhF1OAb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 10:00:31 -0400
Date:   Mon, 28 Jun 2021 13:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624888684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iflIXw7SRfE7jhmS0exHbJ4ZumXIfGY70cRnrUIdoUk=;
        b=mjudzigOPWj73GEO/yGJzzW1w8pA9W/4DbEOKLOx9e8fVngaOyNzW9+G6jFs4WYDYc0gsM
        JYuGxV5Xr811S284Axe504a0mkncdFD46UkvTASZ65tSwA872jNwV6/xowYsWLu3QpiGoR
        5kkHzOgswvqLilTmKdxrCpIOS0rJd+4HCARlcJC0KxrHdm6oAQcyR7ychyibrFO20X7NYB
        MPkzZYs9Dna5YQWsoY0sQQ/qsWKssqVeHBQ2mRYjrVgJW3L5MFVXCvCmo+eG7OEVDOfxB8
        fqjfdFZK9bKUhqXlusIfPhHQIiwB6DPNvAZQFqqYpm2yR6hcLD0d5YTPI1gr+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624888684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iflIXw7SRfE7jhmS0exHbJ4ZumXIfGY70cRnrUIdoUk=;
        b=YQIbEEtzlzi6TpBALOEQ0DjTXTcxnGsqVBmV2tSazjmEAA9BNkq3T9c3VZel9P/INSvCfw
        SbSCnC94NehCodAA==
From:   "tip-bot2 for Julian Wiedmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] wait: use LIST_HEAD_INIT() to initialize wait_queue_head
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601151120.329223-1-jwi@linux.ibm.com>
References: <20210601151120.329223-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <162488868420.395.8032632844768075125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     77eccd0dfae353a64a2088d308bed3b373a4220f
Gitweb:        https://git.kernel.org/tip/77eccd0dfae353a64a2088d308bed3b373a4220f
Author:        Julian Wiedmann <jwi@linux.ibm.com>
AuthorDate:    Tue, 01 Jun 2021 17:11:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 28 Jun 2021 15:42:25 +02:00

wait: use LIST_HEAD_INIT() to initialize wait_queue_head

Replace the open-coded initialization with the right macro.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210601151120.329223-1-jwi@linux.ibm.com
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index fe10e85..99c5f05 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -56,7 +56,7 @@ struct task_struct;
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {					\
 	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),			\
-	.head		= { &(name).head, &(name).head } }
+	.head		= LIST_HEAD_INIT(name.head) }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
