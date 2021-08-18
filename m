Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164343EFE66
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhHRH7U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbhHRH7S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B122FC061764;
        Wed, 18 Aug 2021 00:58:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IpBX0MyWsViM4lquxoElXmFs9eK7fkZe+KNax43vfgQ=;
        b=reJMsi6Iditj9Yv1rC8atrof3sWXfy8eeV+axJp9upyBCJu2ELDJUPk9T52L0yMSc7g9Fa
        ur3ELhCWFIDpCJ9afnRYvm85AnMJQxfF3FiAGJXNEUKk1WcjO+N4Zbe/9t1IyWtnKHB564
        bh+aoaHlnnXl5mwuYpyn2fW+Pq56hoEfXGy4tsYEdA55qoA5qLQjNV9/pGdgIxepLQe/oB
        sq+V283ZUW1irEoVVQVG1suP+PUDPGu2rsfFlFPaZQoUKk19osmoY2L0Xj8yl6Q1jgfwkK
        iUZFFk4zQmALjaMOgAhxAaQqaV2gauKj3UDoR6rLsHDL3vQBNzF39aOwAzcdfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IpBX0MyWsViM4lquxoElXmFs9eK7fkZe+KNax43vfgQ=;
        b=Ibnn/1Zwn7R9f+zT3MehV2tyJqgu4u9sWy4h0EexMNH0LUXtswVXbkPMW/EAkYj+jqqz68
        X+fKal/ev4TEJcCw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Make strict mode imply interruptible watchers
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352226.25758.1261161663325452572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     e04938042d77addc7f41d983aebea125cddbed33
Gitweb:        https://git.kernel.org/tip/e04938042d77addc7f41d983aebea125cddbed33
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 15 Jun 2021 20:39:38 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:44 -07:00

kcsan: Make strict mode imply interruptible watchers

If CONFIG_KCSAN_STRICT=y, select CONFIG_KCSAN_INTERRUPT_WATCHER as well.

With interruptible watchers, we'll also report same-CPU data races; if
we requested strict mode, we might as well show these, too.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 26f03c7..e0a93ff 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -150,7 +150,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP.
 
 config KCSAN_INTERRUPT_WATCHER
-	bool "Interruptible watchers"
+	bool "Interruptible watchers" if !KCSAN_STRICT
+	default KCSAN_STRICT
 	help
 	  If enabled, a task that set up a watchpoint may be interrupted while
 	  delayed. This option will allow KCSAN to detect races between
