Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD83EF362
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhHQUPZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhHQUO4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:56 -0400
Date:   Tue, 17 Aug 2021 20:14:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEIqyu+7fVkEjye0Br9BZUPqeXL0sXSvzptbdNXY4J8=;
        b=IpxNmB5PA+iNCiyCQ09DGz8cOAqkzlxWawbhZVZXLUTOd21YzfSyUxVH6K56YHS/BswSGU
        6wXXNvZ/Xy5GFrCTJphCpb236fgbp3/DsIRprpHrYddNZqaLnssofU6feW34H2f0acyUu3
        92p8Gp5OzuVm/9LJYvMsgyIzao8JKvCWXPKIz7YuiD9pIlIhutAUKosrV1P6IGp8SZfM5o
        9cf+0mkHUnN5NbvyyN61RVrdhLJlaZvJAxEs6dVoq9kQ4keEsB9ph8LDzs/5gx+QHluDpq
        +m4qEXSNGdDo7DSgiYyX2WFuU+rswWybXqcXgSAksI3Uopu5UT4OzfHw7mS7pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEIqyu+7fVkEjye0Br9BZUPqeXL0sXSvzptbdNXY4J8=;
        b=MklS0yw433vJEUtJWIFf/fy/aqnW46WgAwbe3OmQycXoOmAfklFyaJDj6676OYcTZ6dMgT
        PYWtQtpL7v5Mk8Bg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Reduce <linux/rtmutex.h> header
 dependencies, only include <linux/rbtree_types.h>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.598003167@linutronix.de>
References: <20210815211303.598003167@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126191.25758.15241316586748657955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e4e17af3b7f8841279b5a429de14907e26845c39
Gitweb:        https://git.kernel.org/tip/e4e17af3b7f8841279b5a429de14907e26845c39
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:37:26 +02:00

locking/rtmutex: Reduce <linux/rtmutex.h> header dependencies, only include <linux/rbtree_types.h>

We have the following header dependency problem on RT:

 - <linux/rtmutex.h> needs the definition of 'struct rb_root_cached'.
 - <linux/rbtree.h> includes <linux/kernel.h>, which includes <linux/spinlock.h>

That works nicely for non-RT enabled kernels, but on RT enabled kernels
spinlocks are based on rtmutexes, which creates another circular header
dependency as <linux/spinlocks.h> will require <linux/rtmutex.h>.

Include <linux/rbtree_types.h> instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.598003167@linutronix.de
---
 include/linux/rtmutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 4be97ae..9deedfe 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -15,7 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
