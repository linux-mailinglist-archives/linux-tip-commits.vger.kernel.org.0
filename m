Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F983B8426
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhF3Nw7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbhF3NvW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:22 -0400
Date:   Wed, 30 Jun 2021 13:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qlyhb3VdFrD6Q5rWKlKwtwnFyo5s3aDdmDV0WQyE/yw=;
        b=GFU2VMcq/qQoQu/xsoahC4KON/tF9ycu9Uqk1hZG4QrBrtlETw2fUPNUxEXNWrjnoV9DJV
        B5QaCqtj+ShSXB88Oge28aBPQAZBSRLXUhxm3p81/Fw8tGy29d5nFI4AlYroOP0ykvekZq
        wDDrn+leFnuGGc6g34PfeoGBtJS0eNdnTKxPyqteVB7MWqHbdsA1kvp+vMrp7uuDq/FCiw
        p77tUU2h4+I6qzafPB8wV8Z0XMzGOgIIzNDI2Qm04E0qmzdfdVAzyXItLUKoPyCiydn4mm
        i5k8c0y+5qasgfJG6UVpXlK9Jv6AhPPNxPnTJw16GdKlCSU3kzmHqjnePTIEdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qlyhb3VdFrD6Q5rWKlKwtwnFyo5s3aDdmDV0WQyE/yw=;
        b=WfLvFGB7CAg3JS5RsSpaC8uZjQO4G7v6RaphVnOKNYlXwvUg0WXFBDfsi2aS5U0woZQPXK
        5Q9cttXfnLJGIxAw==
From:   "tip-bot2 for Akira Yokosawa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Use URL link for pointing access-marking.txt
Cc:     Marco Elver <elver@google.com>, Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089610.395.954946146241651282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     117232c0b9126e254d84f38ccaf9e576ccfcd990
Gitweb:        https://git.kernel.org/tip/117232c0b9126e254d84f38ccaf9e576ccfcd990
Author:        Akira Yokosawa <akiyks@gmail.com>
AuthorDate:    Thu, 13 May 2021 10:49:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:15 -07:00

kcsan: Use URL link for pointing access-marking.txt

For consistency within kcsan.rst, use a URL link as the same as in
section "Data Races".

Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index d1efd9c..6a600cf 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -89,8 +89,7 @@ the below options are available:
 * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
   any data races due to accesses in ``expr`` should be ignored and resulting
   behaviour when encountering a data race is deemed safe.  Please see
-  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
-  tree for more information.
+  `"Marking Shared-Memory Accesses" in the LKMM`_ for more information.
 
 * Disabling data race detection for entire functions can be accomplished by
   using the function attribute ``__no_kcsan``::
@@ -112,6 +111,8 @@ the below options are available:
 
     KCSAN_SANITIZE := n
 
+.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
+
 Furthermore, it is possible to tell KCSAN to show or hide entire classes of
 data races, depending on preferences. These can be changed via the following
 Kconfig options:
