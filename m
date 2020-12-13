Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C862D9024
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgLMTZs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgLMTCH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:07 -0500
Date:   Sun, 13 Dec 2020 19:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3vXpR45I/DAJ0jnJsp9Z38ey4a1zn3ddx+hW2Oiou9U=;
        b=vlmHMMGuOgzOgL3PwttzkqSZ6aoFlVyGYPl7enQcUMokZHfmkdt4asWjAJ7D7IwB1//ZF+
        vVVc7W5KImjoTROcBBkEPRrAzlIeZivt5wji0XOc8miMe6jxUgmzP+bZsmXBjtXAzvPPfZ
        2GfuhQBeG7XPQERVtpHgV2mVZFnF8qZoJfOU4XbMNJK50PY4zq7c/l9ZMgdeI7/koX1F82
        BSOBZBqgh9gb2oNW5bY2a3+Du2ZtB0oN1rY+0OKP0IsCoSIGlszSX+nG7vOfiQzIqp+Mv6
        v2XbBBdMsX5lKWOUvJYAi8F6v0FGiyIXb8sxqZaxKjjo2v6rpiQWohTPVmfwOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3vXpR45I/DAJ0jnJsp9Z38ey4a1zn3ddx+hW2Oiou9U=;
        b=2rbvXmPURLv91qeNhK6w6t+lyHq4u7A5ee4WHd3b3XKtkzRtlPeEL74C+GUTurAFV7Og5Q
        lJ3VsxCQX5k7/KDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Present the role of READ_ONCE()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607527.3364.17423362551535136919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     86b5a7381b12b1d1d5558d8087e5bbd04b7cf702
Gitweb:        https://git.kernel.org/tip/86b5a7381b12b1d1d5558d8087e5bbd04b7cf702
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 24 Sep 2020 20:53:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:07:15 -08:00

doc: Present the role of READ_ONCE()

This commit adds an explanation of the special cases where READ_ONCE()
may be used in place of a member of the rcu_dereference() family.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst       | 7 +++++++
 Documentation/RCU/rcu_dereference.rst | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2efed99..bb7128e 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -314,6 +314,13 @@ over a rather long period of time, but improvements are always welcome!
 	shared between readers and updaters.  Additional primitives
 	are provided for this case, as discussed in lockdep.txt.
 
+	One exception to this rule is when data is only ever added to
+	the linked data structure, and is never removed during any
+	time that readers might be accessing that structure.  In such
+	cases, READ_ONCE() may be used in place of rcu_dereference()
+	and the read-side markers (rcu_read_lock() and rcu_read_unlock(),
+	for example) may be omitted.
+
 10.	Conversely, if you are in an RCU read-side critical section,
 	and you don't hold the appropriate update-side lock, you -must-
 	use the "_rcu()" variants of the list macros.  Failing to do so
diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index c9667eb..f3e587a 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -28,6 +28,12 @@ Follow these rules to keep your RCU code working properly:
 	for an example where the compiler can in fact deduce the exact
 	value of the pointer, and thus cause misordering.
 
+-	In the special case where data is added but is never removed
+	while readers are accessing the structure, READ_ONCE() may be used
+	instead of rcu_dereference().  In this case, use of READ_ONCE()
+	takes on the role of the lockless_dereference() primitive that
+	was removed in v4.15.
+
 -	You are only permitted to use rcu_dereference on pointer values.
 	The compiler simply knows too much about integral values to
 	trust it to carry dependencies through integer operations.
