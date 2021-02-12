Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B662C319EED
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBLMnf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhBLMlW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:41:22 -0500
Date:   Fri, 12 Feb 2021 12:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CDQ0VQsFFu3XSMncu/md/n+h77WeDn/dkiuiQeq3ROg=;
        b=rtw/rw08NbRLAnXrS3bjoK8SRG54EckCy2V89VO3mz6bAoraeGhVy03p8IemagQF+w6BXY
        gEpUAbIYb4N96WXCyilz3ctPdZORDiBDil6P0T9z02SC+uppns+c2UWGFpxO6Auzf1FHiC
        fWjBS3ah9vq84sCzteRHJzbB0E9OvdcKRKXK9IwtB9ugjuCFG51PbU3WK2irCmeIPORxTS
        tWhrCgn+p3xwm6+1SMjDO30cL1MqmHVap2hUVBEGv8gGwOrt0vASnO4xvPXKUXYPfL+Q67
        MnEzWB7lg/3Lw0MxhWiiheZZWe/216m+sAl4rVM+73ZS5vxwUaUjFH5Dh76JtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CDQ0VQsFFu3XSMncu/md/n+h77WeDn/dkiuiQeq3ROg=;
        b=dcaCck9e2/Ggf5q6+Aej/NfHdKcPF2W0QqoHXclWJuhFc2vZCNnlW+YkCddIl29aEqyNu3
        uaaDw/+QIEbM3NAw==
From:   "tip-bot2 for Wang Qing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locking: Remove duplicate include of percpu-rwsem.h
Cc:     Wang Qing <wangqing@vivo.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344425.23325.10005591129809470247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c5586e32dfe258925c5dbb599bea3eadf34e79c1
Gitweb:        https://git.kernel.org/tip/c5586e32dfe258925c5dbb599bea3eadf34e79c1
Author:        Wang Qing <wangqing@vivo.com>
AuthorDate:    Sat, 07 Nov 2020 16:24:03 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 15:54:49 -08:00

locking: Remove duplicate include of percpu-rwsem.h

This commit removes an unnecessary #include.

Signed-off-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 62d215b..af99e9c 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -27,7 +27,6 @@
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
 
 MODULE_LICENSE("GPL");
