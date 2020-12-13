Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF52D8FA0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbgLMTCx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgLMTCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4C2C0611CA;
        Sun, 13 Dec 2020 11:01:07 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HFR0kfB/VhDZx5Bpcb56YuTh1L5yWFqTGfdoKEkoE9g=;
        b=P8khpuBmFdJowsIeqQT7vhKlnYCncR+SNltNHcJ2iP5QdcJwhtu43a01cXSy6ez0WkWBJL
        laAcJF8lKm95GotOLms095ojRpCM+tEDgqTBegjcwLUuUh8rsleVGondE2yQE4I9DDjGTN
        INkRK/P0AGrdgTJW2c9H1DGCu+vwlzV0NattZ03noDHfRC0JcPNWcQ6uHE5ZVeiMi/6pJr
        iaaYouDDhaf1QxMF7G7H81CxNyZOYD4H2Ma0JOAq7Ix5bXj4qjw0a+CjLKFmtlcx6O6XpX
        4xlx3OFFq2V25EPStOPpiSeOARovLUOv2s79AWblEA2/4O5/XxfE8bDZgiziLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HFR0kfB/VhDZx5Bpcb56YuTh1L5yWFqTGfdoKEkoE9g=;
        b=OhcQFBqKYbJ1X3RXGYKSihT+Esyd1RV9GCTGbjT2gF52K14yBNZpeYZB7we2C9jZyG7KZ1
        s9Gb1QaGPmPcPpCw==
From:   "tip-bot2 for Fox Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs/memory-barriers.txt: Fix a typo in CPU MEMORY
 BARRIERS section
Cc:     Fox Chen <foxhlchen@gmail.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606519.3364.8577581789632517372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d8566f15da9b1e51fd35f24321ec133095e02d06
Gitweb:        https://git.kernel.org/tip/d8566f15da9b1e51fd35f24321ec133095e02d06
Author:        Fox Chen <foxhlchen@gmail.com>
AuthorDate:    Wed, 09 Sep 2020 14:53:40 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:24:51 -08:00

docs/memory-barriers.txt: Fix a typo in CPU MEMORY BARRIERS section

Commit 39323c6 ("smp_mb__{before,after}_atomic(): update Documentation")
has a typo in CPU MEORY BARRIERS section:
"RMW functions that do not imply are memory barrier are ..." should be
"RMW functions that do not imply a memory barrier are ...".

This patch fixes this typo.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 17c8e0c..7367ada 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1870,7 +1870,7 @@ There are some more advanced barrier functions:
 
      These are for use with atomic RMW functions that do not imply memory
      barriers, but where the code needs a memory barrier. Examples for atomic
-     RMW functions that do not imply are memory barrier are e.g. add,
+     RMW functions that do not imply a memory barrier are e.g. add,
      subtract, (failed) conditional operations, _relaxed functions,
      but not atomic_read or atomic_set. A common example where a memory
      barrier may be required is when atomic ops are used for reference
