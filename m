Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC222CD3C4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgLCKg3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbgLCKg0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536FC061A4D;
        Thu,  3 Dec 2020 02:35:46 -0800 (PST)
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+b6gXqajHoczC8+Nlzv+FOWhE7itIPWKxrMdFElui88=;
        b=exiuQmBx09Uxw8Db/fE31gcsPTVSN2vI7dWohOndsb7nBDdg8+xvpfwRs549hhy13ABpPf
        42kiPAElAuEqdAL9JmMhPKlDH3VoR6u/2y3JM/VBUiiZHmR36/EStJ4H88BFZHgmfyHVpX
        RYBKZboWdE9N8440xE0hwE4H6oCiK+5S1obXn66O28BR9gLB8Od3aFS3wEg6d30mOgzDz8
        oNG5o9Xt826tZ4bdEODw2OAWoc4/eVquwQaBgmMGi+8RebCwmnmsfmKXSZfBDKOF81qXuz
        IHIRussP1ttkEb66H8ImxdIFTXUpz87ZmJy7Ht9eaeVGYbyG2iCFO8LP/WZ0eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+b6gXqajHoczC8+Nlzv+FOWhE7itIPWKxrMdFElui88=;
        b=CAULRPdE6upKC8w6JgNGtNFJZfUaFbQaKR+NFian7Qb/LV0YBnULtCc2dFbqn05FEw5Qk3
        E2eMYITFCwEjGsDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] atomic: Update MAINTAINERS
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160699174418.3364.11772742350803606640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     79f3b4372b74f03ba25784f7f2e4b0c90e3aef47
Gitweb:        https://git.kernel.org/tip/79f3b4372b74f03ba25784f7f2e4b0c90e3aef47
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Nov 2020 16:02:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:51 +01:00

atomic: Update MAINTAINERS

Update the files list to include refcount.h and the Documentation/

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da6d8c..6928881 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2982,6 +2982,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
+F:	include/linux/refcount.h
+F:	Documentation/atomic_*.txt
 F:	scripts/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
