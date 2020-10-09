Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7961288250
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbgJIGgP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbgJIGfq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA7C0613D9;
        Thu,  8 Oct 2020 23:35:46 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NpVsmdpKphpcDhvThpQWrITazUwJYEuOooT8vJXgi+g=;
        b=4HuCHctT7BwKBvxQZm5zp/S+QVO/w05hRoGQmlBIXcWDPvX0xqfxTDf01ERr/axz2JOzKR
        DlSW/BULLjkH8UJdAzbfjktB1pHfu+So9djLP4Yn8OYDeAddU7Rv+LB1YcKfHcFFvqH1oR
        a04MrEU6PkBc1UN2M1xXoSSH0/A9ljm9Sc0D32M3U/VGpQaJCx1yUqOrehMoeD1rVnBwjs
        xKQW9ULlYr8KdGOTI4leo2XVLGuEcXZSfwL6z8oCRuV9qhHPmS+ArB728KpyJH0KZpwSe9
        DyrNkZbw4f3cg1jvDiYkq4M0XDA7fgE3/tXLULnY2C8ksbL5cMDWO3c1vUMnTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NpVsmdpKphpcDhvThpQWrITazUwJYEuOooT8vJXgi+g=;
        b=qUayX1qSNHyum3s7wda1bhrtyWRW3Ph81+e2CsNTWXow533I92T4zwke8B3cYQaAeOzBh4
        3XrjPUzb5MhJb+Bw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove KCSAN stubs from update.c
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534454.7002.2781838051337786961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     beb27bd649a08655b6e15b71265fccad9c00bd2c
Gitweb:        https://git.kernel.org/tip/beb27bd649a08655b6e15b71265fccad9c00bd2c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Jun 2020 13:26:20 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:03 -07:00

rcu: Remove KCSAN stubs from update.c

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2de49b5..5f7713a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -53,19 +53,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcupdate."
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
