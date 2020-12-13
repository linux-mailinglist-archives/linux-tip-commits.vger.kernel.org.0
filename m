Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03722D9001
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgLMTWv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388988AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFEBC0617A7;
        Sun, 13 Dec 2020 11:01:04 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bRX4s5BrTyVY8aF0YDeIu8bT4TpgGS5Job0HDCRKQSI=;
        b=Fe1WXlsa9KnkDEBPVlf9nrE2befJS+V0SO0RDdqrgO6R4N+xJe79OtJVbvo7UlozqajgMA
        xIQuJFhhdKtAyAzpHywInTNw18Fz34PFY5lfGEmXwJF9jLrobbRWcm7MdanXPBSuwzby15
        2ytqHqRKdAUmef3grokzJT7aWeCGLaV7xHLGgnBHHPgQvrpuOxXscvbv5sjn4LKW04GlJ6
        0p7g79HEsvRIY3o1rzJtjXytPrAzsBr1rrUfQ/yrund1pnroxREUltPej7zcIAz3alk3a6
        slUzSjvHmQwuGSx//zznee5SPbVoeH72LSt7SvByimcM9+ZBtHXCng8L1CXKsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bRX4s5BrTyVY8aF0YDeIu8bT4TpgGS5Job0HDCRKQSI=;
        b=yu4FGXNXmQbjUnrmUHP/paJPiNw828tOMFG9U7n5DxURmFgQ3VNcBVC0+cCNf66RZ1fEVK
        f/m7lEI9iIOQImCw==
From:   "tip-bot2 for Asif Rasheed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] list.h: Update comment to explicitly note circular lists
Cc:     Asif Rasheed <b00073877@aus.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606268.3364.13819247778167584383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1eafe075bf9cb4db575be4ddf1b1c8256758714a
Gitweb:        https://git.kernel.org/tip/1eafe075bf9cb4db575be4ddf1b1c8256758714a
Author:        Asif Rasheed <b00073877@aus.edu>
AuthorDate:    Sun, 20 Sep 2020 17:31:54 +04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:16 -08:00

list.h: Update comment to explicitly note circular lists

The students in the Operating System Lecture Section at the
American University of Sharjah were confused by the header comment
in include/linux/list.h, which says "Simple doubly linked list
implementation".  This comment means "simple" as in "not complex",
but "simple" is often used in this context to mean "not circular".
This commit therefore avoids this ambiguity by explicitly calling out
"circular".

Signed-off-by: Asif Rasheed <b00073877@aus.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index a18c87b..89bdc92 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 
 /*
- * Simple doubly linked list implementation.
+ * Circular doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
  * manipulating whole lists rather than single entries, as
