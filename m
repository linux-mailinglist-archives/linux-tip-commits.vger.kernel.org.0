Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5BF288418
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgJIH6p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbgJIH6o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A870C0613D2;
        Fri,  9 Oct 2020 00:58:44 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HgKmdV3/sIQk6pReP2yFNHWtrFMB4KF6rkW0/rSUffE=;
        b=xACPW/8I6mEPUqBPS+IfZg+fPR3r+z7GFJYkEVGOXjy/J/Z21iNwvFqPXGmvEM882URoXB
        90CgerTxpfba7n4iPIEaBSWWusNYgVdGnFl0zAOxH9KUJI/730c2z5DNCR32Z3n7Mk8UsZ
        zeTIgaN3dP4ArMCZID76nWxQB+EhVu24Rp2piXUNTSrtNmC6lcT6GKHBzRLXlRFHxiUEe8
        mjqeDcMaq8ibHbekP2owPwlINlWaN/XtOVSb7iHpd7d4b+4gddzisnX4+Lx6b57A2BymYn
        E99AsP6bNV0G6uSD8j4+BCMJmVkWdFyTCq3Mhr/X+73KtXNpVYPARKxGkrAY1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HgKmdV3/sIQk6pReP2yFNHWtrFMB4KF6rkW0/rSUffE=;
        b=sYRQ0HcZW40/fg9LxRGMPC1jbfklitloEoDrWH2g08m3FebKvjH5XpsZ/7bRYkR5yOyqSF
        fIGUb2EXU2f9qYAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032227.7002.11784206910145110880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0ce0c78eff7d22c8a261de6c4305a5abb638c200
Gitweb:        https://git.kernel.org/tip/0ce0c78eff7d22c8a261de6c4305a5abb638c200
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 04 Aug 2020 11:35:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 04 Sep 2020 11:58:15 -07:00

tools/memory-model: Expand the cheatsheet.txt notion of relaxed

This commit adds a key entry enumerating the various types of relaxed
operations.  While in the area, it also renames the relaxed rows.

[ paulmck: Apply Boqun Feng feedback. ]
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/cheatsheet.txt | 33 +++++++++-------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 33ba98d..99d0087 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -3,9 +3,9 @@
                                C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
-Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                          Y   Y        Y
-Unsuccessful RMW operation           Y                          Y   Y        Y
+Relaxed store                        Y                                       Y
+Relaxed load                         Y                          Y   Y        Y
+Relaxed RMW operation                Y                          Y   Y        Y
 rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
@@ -17,14 +17,19 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
 smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
 
 
-Key:	C:	Ordering is cumulative
-	P:	Ordering propagates
-	R:	Read, for example, READ_ONCE(), or read portion of RMW
-	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
-	Y:	Provides ordering
-	a:	Provides ordering given intervening RMW atomic operation
-	DR:	Dependent read (address dependency)
-	DW:	Dependent write (address, data, or control dependency)
-	RMW:	Atomic read-modify-write operation
-	SELF:	Orders self, as opposed to accesses before and/or after
-	SV:	Orders later accesses to the same variable
+Key:	Relaxed:  A relaxed operation is either READ_ONCE(), WRITE_ONCE(),
+		  a *_relaxed() RMW operation, an unsuccessful RMW
+		  operation, a non-value-returning RMW operation such
+		  as atomic_inc(), or one of the atomic*_read() and
+		  atomic*_set() family of operations.
+	C:	  Ordering is cumulative
+	P:	  Ordering propagates
+	R:	  Read, for example, READ_ONCE(), or read portion of RMW
+	W:	  Write, for example, WRITE_ONCE(), or write portion of RMW
+	Y:	  Provides ordering
+	a:	  Provides ordering given intervening RMW atomic operation
+	DR:	  Dependent read (address dependency)
+	DW:	  Dependent write (address, data, or control dependency)
+	RMW:	  Atomic read-modify-write operation
+	SELF:	  Orders self, as opposed to accesses before and/or after
+	SV:	  Orders later accesses to the same variable
