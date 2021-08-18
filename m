Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2F3EFE72
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhHRH7c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbhHRH7W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD04C061764;
        Wed, 18 Aug 2021 00:58:48 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yw/qYZZlNNUn5lMyuoB1F5fRAiySaNBgR0THX/gkSQ0=;
        b=Rw2aKADXebDKAFRXf2UAGvsmsiMOWB7IQni+lyqP5Poz2zp2+PxBhhpDQ5zH+jNSlPrSRO
        kYbuOxRMjf6jloA2IJx5QDajN6ZdU6SV9vd4gM9+1q70x+mVyQeq1LoM1+cy9X26iOVmj+
        wsRP9i9lmV3HP9Co/nEHytuW56EfEmEvv/e0A/73vWGqilKZ/06KsftS60bI7hT3gWvDKl
        eYA2GkDPlgUtcrWJ6xbUpwjNzifGrnoFVwxcKqyxO4pRyfR77yydZLO2+wJ21x75XCDpIz
        mzTMFVvzVYTYx7yA8e9iIX5K271jR+AwAfM7+UUKx2+0jqLRwKZuXP1U07Onsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yw/qYZZlNNUn5lMyuoB1F5fRAiySaNBgR0THX/gkSQ0=;
        b=6y5WtDt04fQ2/OP5kHgnxkMJCPhhdc1n1exFpD0Yaj27jIGv6XQxhuxRD3EDDbIk3bypgr
        8eB0qcRP6LPOHpDg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Improve some Kconfig comments
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352636.25758.992475127071222181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     eb32f9f990d974a7878a8792cee9bb821720c24b
Gitweb:        https://git.kernel.org/tip/eb32f9f990d974a7878a8792cee9bb821720c24b
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:47 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:43 -07:00

kcsan: Improve some Kconfig comments

Improve comment for CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE. Also shorten
the comment above the "strictness" configuration options.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 0440f37..6152fbd 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,10 +40,14 @@ menuconfig KCSAN
 
 if KCSAN
 
-# Compiler capabilities that should not fail the test if they are unavailable.
 config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
 	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
 		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+	help
+	  The compiler instruments plain compound read-write operations
+	  differently (++, --, +=, -=, |=, &=, etc.), which allows KCSAN to
+	  distinguish them from other plain accesses. This is currently
+	  supported by Clang 12 or later.
 
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
@@ -169,13 +173,9 @@ config KCSAN_REPORT_ONCE_IN_MS
 	  reporting to avoid flooding the console with reports.  Setting this
 	  to 0 disables rate limiting.
 
-# The main purpose of the below options is to control reported data races (e.g.
-# in fuzzer configs), and are not expected to be switched frequently by other
-# users. We could turn some of them into boot parameters, but given they should
-# not be switched normally, let's keep them here to simplify configuration.
-#
-# The defaults below are chosen to be very conservative, and may miss certain
-# bugs.
+# The main purpose of the below options is to control reported data races, and
+# are not expected to be switched frequently by non-testers or at runtime.
+# The defaults are chosen to be conservative, and can miss certain bugs.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
