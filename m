Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385CD2D8F9C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgLMTCb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbgLMTCI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:08 -0500
Date:   Sun, 13 Dec 2020 19:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ss+MwVg/VQFRhvH6m9A35VGSaJ5zrVstJKAovZiwr4s=;
        b=ObUn5ts3QFpOIOHte+uUqXx3KART/PX4z3B2vAXIzrYZK+7+IVXqd7KF/YM0jPBxjL0Awa
        Ic3XXl6jdMLOhiLNsSBU4A7quXCej1NpS0GET1VtTOdsUDSsq8PG6d8OGMA+aUci10tF0N
        g4ywXg7Zkr6ZekERF/030LR2OgzSBane/+Hw6LPuY2wgIoNY4PWMmKC1vOUf3WZqbgve5F
        aWvM0OIFjYuBdfv4tldnSV0uZMipytJRxJwmW+jNgAvez+Z5unrRSsv6KWA2yVH44IoSo/
        z0SnF6lfHEh7amTjqy3rBi0WQOMz3qzThWOCOlGoRyTEPpkV56a7d8iBYt0lIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ss+MwVg/VQFRhvH6m9A35VGSaJ5zrVstJKAovZiwr4s=;
        b=8QOEgfxCeXtbdBpowmTFdwM5RecgHgkR4uwQh6/JJFyNWFGJxY7YIjBrUaGp9OnbO+k71Z
        K38rbCNK8sRfcWBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model: Move Documentation description to
 Documentation/README
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607544.3364.11089937620762407479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ab8bcad67bee82e4be290b32f0faaf582d7c3edc
Gitweb:        https://git.kernel.org/tip/ab8bcad67bee82e4be290b32f0faaf582d7c3edc
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 04 Aug 2020 14:00:17 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 26 Oct 2020 16:18:53 -07:00

tools/memory-model: Move Documentation description to Documentation/README

This commit moves the descriptions of the files residing in
tools/memory-model/Documentation to a README file in that directory,
leaving behind the description of tools/memory-model/Documentation/README
itself.  After this change, tools/memory-model/Documentation/README
provides a guide to the files in the tools/memory-model/Documentation
directory, guiding people with different skills and needs to the most
appropriate starting point.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README | 59 ++++++++++++++++++++++++-
 tools/memory-model/README               | 22 +---------
 2 files changed, 61 insertions(+), 20 deletions(-)
 create mode 100644 tools/memory-model/Documentation/README

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
new file mode 100644
index 0000000..2d9539f
--- /dev/null
+++ b/tools/memory-model/Documentation/README
@@ -0,0 +1,59 @@
+It has been said that successful communication requires first identifying
+what your audience knows and then building a bridge from their current
+knowledge to what they need to know.  Unfortunately, the expected
+Linux-kernel memory model (LKMM) audience might be anywhere from novice
+to expert both in kernel hacking and in understanding LKMM.
+
+This document therefore points out a number of places to start reading,
+depending on what you know and what you would like to learn.  Please note
+that the documents later in this list assume that the reader understands
+the material provided by documents earlier in this list.
+
+o	You are new to Linux-kernel concurrency: simple.txt
+
+o	You are familiar with the Linux-kernel concurrency primitives
+	that you need, and just want to get started with LKMM litmus
+	tests:  litmus-tests.txt
+
+o	You are familiar with Linux-kernel concurrency, and would
+	like a detailed intuitive understanding of LKMM, including
+	situations involving more than two threads:  recipes.txt
+
+o	You are familiar with Linux-kernel concurrency and the use of
+	LKMM, and would like a quick reference:  cheatsheet.txt
+
+o	You are familiar with Linux-kernel concurrency and the use
+	of LKMM, and would like to learn about LKMM's requirements,
+	rationale, and implementation:	explanation.txt
+
+o	You are interested in the publications related to LKMM, including
+	hardware manuals, academic literature, standards-committee
+	working papers, and LWN articles:  references.txt
+
+
+====================
+DESCRIPTION OF FILES
+====================
+
+README
+	This file.
+
+cheatsheet.txt
+	Quick-reference guide to the Linux-kernel memory model.
+
+explanation.txt
+	Detailed description of the memory model.
+
+litmus-tests.txt
+	The format, features, capabilities, and limitations of the litmus
+	tests that LKMM can evaluate.
+
+recipes.txt
+	Common memory-ordering patterns.
+
+references.txt
+	Background information.
+
+simple.txt
+	Starting point for someone new to Linux-kernel concurrency.
+	And also a reminder of the simpler approaches to concurrency!
diff --git a/tools/memory-model/README b/tools/memory-model/README
index c8144d4..39d08d1 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -161,26 +161,8 @@ running LKMM litmus tests.
 DESCRIPTION OF FILES
 ====================
 
-Documentation/cheatsheet.txt
-	Quick-reference guide to the Linux-kernel memory model.
-
-Documentation/explanation.txt
-	Describes the memory model in detail.
-
-Documentation/litmus-tests.txt
-	Describes the format, features, capabilities, and limitations
-	of the litmus tests that LKMM can evaluate.
-
-Documentation/recipes.txt
-	Lists common memory-ordering patterns.
-
-Documentation/references.txt
-	Provides background reading.
-
-Documentation/simple.txt
-	Starting point for someone new to Linux-kernel concurrency.
-	And also for those needing a reminder of the simpler approaches
-	to concurrency!
+Documentation/README
+	Guide to the other documents in the Documentation/ directory.
 
 linux-kernel.bell
 	Categorizes the relevant instructions, including memory
