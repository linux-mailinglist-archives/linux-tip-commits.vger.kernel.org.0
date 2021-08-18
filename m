Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1333EFE6F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhHRH7Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhHRH7V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D6C0613CF;
        Wed, 18 Aug 2021 00:58:47 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eGoVw0Ybvi4GjfzrkEV/IPERfl3L9l4lN8LXB4O4jvo=;
        b=3c5NlLNBrMnL4mBXUZ7gAytQoxfkPU6rW/yfLdw4dNDXTdiDqzZhY+r1UBIGEjto4vy9DQ
        wsWY2ByURprHfanbKiIzSMDxFnUFoRc0Yp9bm07t5U2Ua18tmNrhDLNZ0OgvAvJ1wIehAv
        qrNOSnlO0666qChS1mXpa+x0KzE98UWdXooLFMdb3JXtat7nGKwnHLwD7Zby4aDz3JOKRB
        cN/qfXPJXyE8LdTldSLis3nd2hWq4F8v/e/WLcKw3O1gg+pW9PZ/crA080UqxbCUYIpGVo
        5e0SmrUNK2Qa4ahrWoL//eHKqJuCzlBKUn2c8qSxwlDj5qpieRycyY4gQ3oDIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eGoVw0Ybvi4GjfzrkEV/IPERfl3L9l4lN8LXB4O4jvo=;
        b=mR+yzyW6/3Q7RCAMNmfOE7IzWwY6XRNwuFEArsug/AvuCTgvMDXp3snSJ5QmluQ7UchkCc
        0vkWIHf5UBGBYODg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Introduce CONFIG_KCSAN_STRICT
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352528.25758.9839549022962931479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     e675d2533a74acfa95c62e7bb088335866f44fd2
Gitweb:        https://git.kernel.org/tip/e675d2533a74acfa95c62e7bb088335866f44fd2
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:49 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:43 -07:00

kcsan: Introduce CONFIG_KCSAN_STRICT

Add a simpler Kconfig variable to configure KCSAN's "strict" mode. This
makes it simpler in documentation or messages to suggest just a single
configuration option to select the strictest checking mode (vs.
currently having to list several options).

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst |  4 ++++
 lib/Kconfig.kcsan                 | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 6a600cf..69dc9c5 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -127,6 +127,10 @@ Kconfig options:
   causes KCSAN to not report data races due to conflicts where the only plain
   accesses are aligned writes up to word size.
 
+To use the strictest possible rules, select ``CONFIG_KCSAN_STRICT=y``, which
+configures KCSAN to follow the Linux-kernel memory consistency model (LKMM) as
+closely as possible.
+
 DebugFS interface
 ~~~~~~~~~~~~~~~~~
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 5304f21..c76fbb3 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -183,9 +183,17 @@ config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	  reported if it was only possible to infer a race due to a data value
 	  change while an access is being delayed on a watchpoint.
 
+config KCSAN_STRICT
+	bool "Strict data-race checking"
+	help
+	  KCSAN will report data races with the strictest possible rules, which
+	  closely aligns with the rules defined by the Linux-kernel memory
+	  consistency model (LKMM).
+
 config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	bool "Only report races where watcher observed a data value change"
 	default y
+	depends on !KCSAN_STRICT
 	help
 	  If enabled and a conflicting write is observed via a watchpoint, but
 	  the data value of the memory location was observed to remain
@@ -194,6 +202,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 	bool "Assume that plain aligned writes up to word size are atomic"
 	default y
+	depends on !KCSAN_STRICT
 	help
 	  Assume that plain aligned writes up to word size are atomic by
 	  default, and also not subject to other unsafe compiler optimizations
@@ -206,6 +215,7 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
+	depends on !KCSAN_STRICT
 	help
 	  Never instrument marked atomic accesses. This option can be used for
 	  additional filtering. Conflicting marked atomic reads and plain
