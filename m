Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2463EFE71
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbhHRH71 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbhHRH7W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46FC0613D9;
        Wed, 18 Aug 2021 00:58:47 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PcymhDgSEofz7YHYSjk+mp1kN4dd6xDKtKCxwvJ9dEY=;
        b=088LC12o1YYUPijDk/13WIYJ91ahMd96EdteozaTjoTUT+guZv026y8PN+KA9WnmUc6zXF
        QF8bddsnT1LTS5Tye/ICYCxN+kMSOoPhdyQIuSlYc9HIRjux8wkSWEL0shBnU4h0Ns0SK0
        pbrLZYPzcQjHyCDfQILttjr0Cc4Ca2NMDfAarVh7kfaD2kA9b9SwPynt9D3BrEOD+9y62H
        O1tmCmTm4qDrRzn6zKlR4JzosfTktvM/hMUCmrBNJYLfsbhLuyEhuKkh7T8MyZyV7rjE2m
        cnDLT4Gc8SHCgVKirHx6yi0K7fRTnjiXVtSbB44wPVDmDRF2wsgBYx7B17eWnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PcymhDgSEofz7YHYSjk+mp1kN4dd6xDKtKCxwvJ9dEY=;
        b=VVxhupmfFQf8Nt+Ss6dDe32RbbvwbMwJ46Qfnh16eB+ScaQYbTyDEyGRsC0ae+8UJeKESZ
        kLqKDoRwpSeXRBAA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Remove CONFIG_KCSAN_DEBUG
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352583.25758.13676271825523193296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     a7a73697360ea81244eea550138b8f614348860c
Gitweb:        https://git.kernel.org/tip/a7a73697360ea81244eea550138b8f614348860c
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:48 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:43 -07:00

kcsan: Remove CONFIG_KCSAN_DEBUG

By this point CONFIG_KCSAN_DEBUG is pretty useless, as the system just
isn't usable with it due to spamming console (I imagine a randconfig
test robot will run into this sooner or later). Remove it.

Back in 2019 I used it occasionally to record traces of watchpoints and
verify the encoding is correct, but these days we have proper tests. If
something similar is needed in future, just add it back ad-hoc.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c |  9 ---------
 lib/Kconfig.kcsan   |  3 ---
 2 files changed, 12 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 26709ea..d92977e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -479,15 +479,6 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		break; /* ignore; we do not diff the values */
 	}
 
-	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
-		kcsan_disable_current();
-		pr_err("watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
-		       is_write ? "write" : "read", size, ptr,
-		       watchpoint_slot((unsigned long)ptr),
-		       encode_watchpoint((unsigned long)ptr, size, is_write));
-		kcsan_enable_current();
-	}
-
 	/*
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 6152fbd..5304f21 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -62,9 +62,6 @@ config KCSAN_VERBOSE
 	  generated from any one of them, system stability may suffer due to
 	  deadlocks or recursion.  If in doubt, say N.
 
-config KCSAN_DEBUG
-	bool "Debugging of KCSAN internals"
-
 config KCSAN_SELFTEST
 	bool "Perform short selftests on boot"
 	default y
