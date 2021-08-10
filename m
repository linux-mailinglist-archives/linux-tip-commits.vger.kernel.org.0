Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64183E7D42
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhHJQPO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:15:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44546 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhHJQPE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:15:04 -0400
Date:   Tue, 10 Aug 2021 16:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628612081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZp/B+KFF7/Emkoq1FLpDQbSf6cHVKNazvE8BmlNWik=;
        b=FlaNHpKQbDOftfzSAGHLeeSsiaYJw73CoLi+cQ5yoEGpQnuQFoO6Z0MfjpeYQKSHBH7hRW
        sl+/9ed1+W0o6+keJt+U5f3xUVQcgs9NeesrBfpnOm5SJv+xPaK0O9KpqThySLdPgZtVqI
        cMIyUCI9jTGTxn/aPITwjsPQG+/y18t3EedObLyl/uiFp0Q6ZfhiQwrFIYC1lPsOub1NVk
        B1h/d7SZ/BPHw3sD1WcTokMziQTR1tSXTWEQeGiC94TCZ01qZWUJfV+qHIzywyamUxImfU
        DUcZB21IaUwUocH3kGR8rtIMJX2Doaqwv9owH7NYIT4d8rR3tYKhS6ySy5WcwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628612081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZp/B+KFF7/Emkoq1FLpDQbSf6cHVKNazvE8BmlNWik=;
        b=s4G20fcsc+ANjYDDjFgZvi4+mR2yhj01Uif/vcq/ckxADJXxFuGJOJzExhIuv/R4pFDoFe
        K5Gp1HeuaS4y8ABA==
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Fix comment typo
Cc:     John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1621585689-177398-1-git-send-email-john.garry@huawei.com>
References: <1621585689-177398-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <162861208109.395.17310369237583962117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c91eb2837310a4e8490fb712598aa7d7148e6d7f
Gitweb:        https://git.kernel.org/tip/c91eb2837310a4e8490fb712598aa7d7148e6d7f
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Fri, 21 May 2021 16:28:09 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 18:02:37 +02:00

cpu/hotplug: Fix comment typo

/s/reatdown/teardown/

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1621585689-177398-1-git-send-email-john.garry@huawei.com


---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f39b34b..6ac543d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -399,7 +399,7 @@ static inline int cpuhp_state_remove_instance(enum cpuhp_state state,
 
 /**
  * cpuhp_state_remove_instance_nocalls - Remove hotplug instance from state
- *					 without invoking the reatdown callback
+ *					 without invoking the teardown callback
  * @state:	The state from which the instance is removed
  * @node:	The node for this individual state.
  *
