Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1802D8F9B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbgLMTCb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbgLMTCL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:11 -0500
Date:   Sun, 13 Dec 2020 19:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vcDkqBPV+8mKvf+z9RYyhQIlOM47AMp5XMNOCSMST2c=;
        b=d7/UsbFzPubHOP1lPouslilIL9OrEPX4d/O9xIywnNgELdwsob3sESNW4oN+bP8L8hq/vU
        YjeoH8HRQanK/eluZDOgtu2Iwj4fnjGbfaSwYChPXSk3i05+DhnOVfNCAV6p4N22Pv/v1W
        9EDBD1gJXklu31ZZ/3a8XLfzDZ3xVtXmT7F02VswINAP8YNOHa1bJD25OBtUXBv+T5oC+8
        SGfTATbvPkeGk9R2ng8u473bTzL6YfCRJmTP3gOhoppR2GKbHWMsIplznhEt5cQVI1Suc2
        Kr4CMV5+HSESaukBQk5tHSbkQgiI/jbb7/iIt59TPWwuwZ36c1t5Go8IGwHaHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vcDkqBPV+8mKvf+z9RYyhQIlOM47AMp5XMNOCSMST2c=;
        b=vGhGsPv78pxpiGxU1R+dqqi+GL+MnH0R5r9KkX7BkilP79bBTQmC+GQod4azt6BzdoXu33
        kb3mRfppEGQQXrBQ==
From:   "tip-bot2 for Alan Stern" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools: memory-model: Document that the LKMM can
 easily miss control dependencies
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607560.3364.720718627034297917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9270e1a744f8ed953009b0e94b26ed0912d9ec1c
Gitweb:        https://git.kernel.org/tip/9270e1a744f8ed953009b0e94b26ed0912d9ec1c
Author:        Alan Stern <stern@rowland.harvard.edu>
AuthorDate:    Sat, 03 Oct 2020 21:40:22 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 26 Oct 2020 16:18:53 -07:00

tools: memory-model: Document that the LKMM can easily miss control dependencies

Add a small section to the litmus-tests.txt documentation file for
the Linux Kernel Memory Model explaining that the memory model often
fails to recognize certain control dependencies.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/litmus-tests.txt | 17 ++++++++++++++-
 1 file changed, 17 insertions(+)

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 2f840dc..8a9d5d2 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -946,6 +946,23 @@ Limitations of the Linux-kernel memory model (LKMM) include:
 	carrying a dependency, then the compiler can break that dependency
 	by substituting a constant of that value.
 
+	Conversely, LKMM sometimes doesn't recognize that a particular
+	optimization is not allowed, and as a result, thinks that a
+	dependency is not present (because the optimization would break it).
+	The memory model misses some pretty obvious control dependencies
+	because of this limitation.  A simple example is:
+
+		r1 = READ_ONCE(x);
+		if (r1 == 0)
+			smp_mb();
+		WRITE_ONCE(y, 1);
+
+	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
+	even when r1 is nonzero, but LKMM doesn't realize this and thinks
+	that the write may execute before the read if r1 != 0.  (Yes, that
+	doesn't make sense if you think about it, but the memory model's
+	intelligence is limited.)
+
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
 
