Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA29B35B514
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhDKNpJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhDKNoY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:24 -0400
Date:   Sun, 11 Apr 2021 13:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6z1ok1A3UJs/yWs+5EngOCngdZVjEoCZfvOQcHiLsBc=;
        b=uLbSFDfz8gd5b/qAzULuKBuyW3N8lr0wuQIBpfrOTwFwGAdbbiw/AqtoxF8jsJGyL4n9QY
        2sH524/tIApdtP1ALlV2YRgfjrK8+F30tVIQFhbS9CFicrvaHp5ufoz+pmtZZuTBDgpMfi
        ipm9LJVFpE8VCEb+lGjWxjs/INT2uAXHup4WOYHZs1rQJs8VBPwpkUUEA4EEezMhNLhVwD
        n96+bUOsO39+L0o3w3s/Zv/t/aG8FjUChfHe1ldgXRjNE22SA/JYSJjhEcyaXbWKlippow
        krLpkB7Dfrq2CDmqNt6ESsFWyPLxqGV8s/lOy/pPLVLaYNrLZQdLI2mE7skY6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6z1ok1A3UJs/yWs+5EngOCngdZVjEoCZfvOQcHiLsBc=;
        b=D0KwNjeQA7sDLy27pc8HpTz25iE3hVQSf+PBCiiobI6rd5gOCsK+sa1bOZGfvGY8EDqB/1
        JkFn5zeh9i+PovDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument
 kvfree_rcu()
Cc:     Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862081.29796.8568693950030914916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b01b405092b7940bd366053a27ed54a87c84e96a
Gitweb:        https://git.kernel.org/tip/b01b405092b7940bd366053a27ed54a87c84e96a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 20 Jan 2021 17:21:47 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:07 -08:00

kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()

This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
carried out by the single-argument variant of kvfree_rcu(), thus avoiding
this can-sleep code path from dipping into the emergency reserves.

Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1f8c980..08b5044 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3519,7 +3519,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
