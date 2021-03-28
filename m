Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72B34BF5A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Mar 2021 23:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhC1VdE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 28 Mar 2021 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhC1Vcj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 28 Mar 2021 17:32:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E44C061762;
        Sun, 28 Mar 2021 14:32:38 -0700 (PDT)
Date:   Sun, 28 Mar 2021 21:32:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616967156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gK4jGRKi4QpGkW+ijfwsqF4H+hbIAyTPtkDR62NSHaE=;
        b=0Nx9XJ7z2yyZuOAMcirzSdA3FOGt0XhCO8zlJdArZwOytmM1DlpJNA8G7oFvMYyOPQSbtX
        FEqiq7npsuQUNHORWxT6x0aXeTPt7fAHXE6s9Za0m/U4R8kbp7zHp8CII9ILmgl2/eEoOg
        irO7MMYSuO8C7juAq+5jgN4Zo3XuXKdm0n4/e1rlFnFupM/GfgYkNZxljioqOPzsTjyp6W
        fpAl5Jsb8Zo66BoHW3wM/ai1oxfSwry/8/RbrDGL8HoIEE/3+YEYqTVaUgQpFqXF2IDWq3
        nUiusLkpKGPj7ZSYoz+JT0i4w0KVE5LfNXbI2QvfWFXNGJi2xRrOyNrH8d4nog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616967156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gK4jGRKi4QpGkW+ijfwsqF4H+hbIAyTPtkDR62NSHaE=;
        b=WiJz72YGdowNOjlNTFSEBLpUXbVyGF8mQHliuCK60vGAKsNmOYSDfYHSH3t2WDXFztwMCP
        +/MBFu/CMluBvvCA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] Documentation/admin-guide: Change doc for
 split_lock_detect parameter
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322135325.682257-4-fenghua.yu@intel.com>
References: <20210322135325.682257-4-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <161696715561.398.9620783137672566551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     ebca17707e38f2050b188d837bd4646b29a1b0c2
Gitweb:        https://git.kernel.org/tip/ebca17707e38f2050b188d837bd4646b29a1b0c2
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 22 Mar 2021 13:53:25 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 28 Mar 2021 22:52:16 +02:00

Documentation/admin-guide: Change doc for split_lock_detect parameter

Since #DB for bus lock detect changes the split_lock_detect parameter,
update the documentation for the changes.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20210322135325.682257-4-fenghua.yu@intel.com

---
 Documentation/admin-guide/kernel-parameters.txt | 22 +++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..aef927c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5100,27 +5100,37 @@
 	spia_peddr=
 
 	split_lock_detect=
-			[X86] Enable split lock detection
+			[X86] Enable split lock detection or bus lock detection
 
 			When enabled (and if hardware support is present), atomic
 			instructions that access data across cache line
-			boundaries will result in an alignment check exception.
+			boundaries will result in an alignment check exception
+			for split lock detection or a debug exception for
+			bus lock detection.
 
 			off	- not enabled
 
-			warn	- the kernel will emit rate limited warnings
+			warn	- the kernel will emit rate-limited warnings
 				  about applications triggering the #AC
-				  exception. This mode is the default on CPUs
-				  that supports split lock detection.
+				  exception or the #DB exception. This mode is
+				  the default on CPUs that support split lock
+				  detection or bus lock detection. Default
+				  behavior is by #AC if both features are
+				  enabled in hardware.
 
 			fatal	- the kernel will send SIGBUS to applications
-				  that trigger the #AC exception.
+				  that trigger the #AC exception or the #DB
+				  exception. Default behavior is by #AC if
+				  both features are enabled in hardware.
 
 			If an #AC exception is hit in the kernel or in
 			firmware (i.e. not while executing in user mode)
 			the kernel will oops in either "warn" or "fatal"
 			mode.
 
+			#DB exception for bus lock is triggered only when
+			CPL > 0.
+
 	srbds=		[X86,INTEL]
 			Control the Special Register Buffer Data Sampling
 			(SRBDS) mitigation.
