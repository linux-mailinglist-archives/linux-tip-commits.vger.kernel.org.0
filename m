Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E63F47BE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhHWJjq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:39:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhHWJjp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:39:45 -0400
Date:   Mon, 23 Aug 2021 09:39:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711542;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1KxiDcXAsN6avrtYAJ86uY9l59Vr3FTTpCQ9FaH5G0=;
        b=wgURdIpWfBRSsP5+bpNI82v+9cEz9571eY38vChZObnTI6H5M3BCKOx7Xjn1860qffr2eL
        cQ/j2PmrsictAncWlOWtK3V1yFo2bnBFzOfPGGvFY6AeJRrkn1hAi4Lx63c04CTw+jxEBm
        YCNzw98Eh+A0Zyxm8o9+2aYRkL8BtmthUoB5a+AMHG16R5EVc8XPcC5DotmyOFa0b/vE1I
        vwBnq/mtOmTlHD8ajF0WHYi02NP6+0IfAhYOojTIuWCY/FQx3dNI8fMlan1xwZB4+tSD2l
        nZl9YK1JxxbO1/acapOM5ca5dVfjlbCsyRZwofd9FVfRbSBjufAUmiCt0g9JPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711542;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1KxiDcXAsN6avrtYAJ86uY9l59Vr3FTTpCQ9FaH5G0=;
        b=tdl+ZanOD0HqLuHLbZAHO/F/uJnBgbYeKvSM2roD56JPD+3FSax7LT8Wpd4wp0h28D0j4V
        9fLbz+RliYS4D1BQ==
From:   "tip-bot2 for Xiaoming Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/semaphore: Add might_sleep() to down_*() family
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210809021215.19991-1-nixiaoming@huawei.com>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Message-ID: <162971154151.25758.3817473813262421389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     99409b935c9ac5ea36ab5218954115c52449234d
Gitweb:        https://git.kernel.org/tip/99409b935c9ac5ea36ab5218954115c52449234d
Author:        Xiaoming Ni <nixiaoming@huawei.com>
AuthorDate:    Mon, 09 Aug 2021 10:12:15 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:17 +02:00

locking/semaphore: Add might_sleep() to down_*() family

Semaphore is sleeping lock. Add might_sleep() to down*() family
(with exception of down_trylock()) to detect atomic context sleep.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210809021215.19991-1-nixiaoming@huawei.com
---
 kernel/locking/semaphore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9aa855a..9ee381e 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -54,6 +54,7 @@ void down(struct semaphore *sem)
 {
 	unsigned long flags;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -77,6 +78,7 @@ int down_interruptible(struct semaphore *sem)
 	unsigned long flags;
 	int result = 0;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -103,6 +105,7 @@ int down_killable(struct semaphore *sem)
 	unsigned long flags;
 	int result = 0;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
 	unsigned long flags;
 	int result = 0;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
