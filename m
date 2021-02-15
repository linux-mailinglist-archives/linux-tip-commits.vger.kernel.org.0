Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3183031BB92
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBOO4x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBOO4i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:38 -0500
Date:   Mon, 15 Feb 2021 14:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JsaoZCB9zSWouNLOeT/XvD1H+a5WgTq8/fZupRieDR4=;
        b=eNzLR9mJx0YSNDjY04tbJ5spHM04AqTIATPSxhF2rKIrqIJSsFRPSlL5RJTX54x+nwIxei
        FS26nytMH20ak9LkUZUhDgyacjy5UJWqQL5BaLXqHTSdFOXiZ3ij8BJIAP1SlZviiOTx6a
        bG5thfPCQIueuHm+hecNXh00qxGnV/v8NMiXHZzdP2nvpv5s7h2QIHwGuRwHwMj/pCaV1V
        nq+MchDFUDnBFRYymglBwaJo5T607ziVrkubQz0NasQB8McGxx+WNnGEqECyf5rm1ftXkR
        HmupQxMxctPAiNQC3HpLmcanGa4QmL6kLp1GmYdI21d8Lo8AX/U2B30ILB/vog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JsaoZCB9zSWouNLOeT/XvD1H+a5WgTq8/fZupRieDR4=;
        b=lXS8M5Nn0BNE2fCewuzr3mlHJ9JTF5NKOe7uhzEEnfrFTbcVmyWCO9VgB8prl8FlHd59R0
        xh9NFPPwoWqH2yCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tools/memory-model: Tie acquire loads to reads-from
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340095527.20312.14396173781027795750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8881e7a774a8d14088d6c6fde8730660f74a3642
Gitweb:        https://git.kernel.org/tip/8881e7a774a8d14088d6c6fde8730660f74a3642
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 06 Nov 2020 09:58:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:40:49 -08:00

tools/memory-model: Tie acquire loads to reads-from

This commit explicitly makes the connection between acquire loads and
the reads-from relation.  It also adds an entry for happens-before,
and refers to the corresponding section of explanation.txt.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index 79acb75..b2da636 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -33,10 +33,11 @@ Acquire:  With respect to a lock, acquiring that lock, for example,
 	acquire loads.
 
 	When an acquire load returns the value stored by a release store
-	to that same variable, then all operations preceding that store
-	happen before any operations following that load acquire.
+	to that same variable, (in other words, the acquire load "reads
+	from" the release store), then all operations preceding that
+	store "happen before" any operations following that load acquire.
 
-	See also "Relaxed" and "Release".
+	See also "Happens-Before", "Reads-From", "Relaxed", and "Release".
 
 Coherence (co):  When one CPU's store to a given variable overwrites
 	either the value from another CPU's store or some later value,
@@ -119,6 +120,11 @@ Fully Ordered:  An operation such as smp_mb() that orders all of
 	that orders all of its CPU's prior accesses, itself, and
 	all of its CPU's subsequent accesses.
 
+Happens-Before (hb): A relation between two accesses in which LKMM
+	guarantees the first access precedes the second.  For more
+	detail, please see the "THE HAPPENS-BEFORE RELATION: hb"
+	section of explanation.txt.
+
 Marked Access:  An access to a variable that uses an special function or
 	macro such as "r1 = READ_ONCE(x)" or "smp_store_release(&a, 1)".
 
