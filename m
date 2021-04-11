Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A203F35B516
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhDKNpK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhDKNoY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:24 -0400
Date:   Sun, 11 Apr 2021 13:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vc7N7SrnKBZDqmSO9+dLrP0b2YWI+39yOfBu6gpgQVI=;
        b=Y3l1Z4XMj6Q1xWKZ17DspycHqDaBnAjlBSTSDUh3NafbNOvtS3AIfzYm05uopH5r1Awmdm
        V5wl2MAkWYEC4UROBfbB6hYPRUMhHVTJYlP8DR6isxji5mbfu/jz8xO9+ofAWLPMOKK3Wm
        aNDGMcQRU7W3eSEPT9THVsV+2Fj6NS8ILeXBfU3KQd96PCr4Romw+gxt1yHTTUuquufmCl
        6NVEDYE6/Jk0bZb9imk5mleRW6xxNdslhOL6oNY3vHcu1hPBqo2+uJIxN0W0SdNrRXldvM
        z6K5nfKjCwAenko5oODGxVn9VvOLd9BpYBelIt5teWBPtLh6L/dPaZ9L7bW85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vc7N7SrnKBZDqmSO9+dLrP0b2YWI+39yOfBu6gpgQVI=;
        b=kCK41C/TZi7nmDlHJfWaZWkExyokTxkTIu6vbt/WAYH+sBZ8klN0wrPaDjIkfHkVg5LcAw
        6er4rymUa/GUgnAA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix kfree_rcu() docbook errors
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862148.29796.2497631386779373400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e75956bd00cf4246067c6aee7751faf313233435
Gitweb:        https://git.kernel.org/tip/e75956bd00cf4246067c6aee7751faf313233435
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Thu, 14 Jan 2021 08:22:02 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:17:35 -08:00

rcu: Fix kfree_rcu() docbook errors

After commit 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro"),
kernel-doc now emits two warnings:

	./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
	./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu'

This commit added some macro magic in order to call two different versions
of kfree_rcu(), the first having just one argument and the second having
two arguments.  That makes it difficult to document the kfree_rcu() arguments
in the docboook header.

In order to make clearer that this macro accepts optional arguments,
this commit uses macro concatenation so that this macro changes from:
	#define kfree_rcu kvfree_rcu

to:
	#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)

That not only helps kernel-doc understand the macro arguments, but also
provides a better C definition that makes clearer that the first argument
is mandatory and the second one is optional.

Fixes: 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro")
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bd04f72..5cc6dea 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -881,7 +881,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu kvfree_rcu
+#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
