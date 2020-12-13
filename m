Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC12D8FEF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbgLMTTC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390972AbgLMTCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA98C0619D5;
        Sun, 13 Dec 2020 11:01:11 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7FSzG2Qo2EDCOGqUHRDOHrD5/tJZs7moRwnfQ7bvgOE=;
        b=xonTMBZDMmrjv2lO+QBhs1BDxKLGzh23xTcL36d58PLVFBWUuUPB/5bzWoBZltAl/P5LJ2
        +VUvswwEYcTBcuKU9Py3TXXPHdQNwVcayaYI8ps7Z5ZX+y3PVPlZpRWQN8jUZRlK2wcpt8
        NYnadb7Da4SBwrV1hNjXOLdSHOYH14FsFKOnJUG2GIBfrKCHk9Ty1UvfQ18tyGDZJCOxQs
        2WU7hXL4IEXD/sMAI4nde7iVMhXoEaEHfTjOzSp/4yOSRwgYbhrk4C1a+hR9f6ZI4y7/ty
        vFgbuXR3FqORLRNmKAZeRSXR0dIu3lxqY7w1OosAd23ou14yc2kg8F9+45ooFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7FSzG2Qo2EDCOGqUHRDOHrD5/tJZs7moRwnfQ7bvgOE=;
        b=hcuxeWMoAKwYss7VX0LXIUNMgLLuUPHKuSSel44H3w8v1XMMifjU1dRLETVHp0FnRDfIXk
        Iir+DYih0SQ86yAA==
From:   "tip-bot2 for Hou Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Ignore nreaders_stress if no readlock support
Cc:     Hou Tao <houtao1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606933.3364.1160215468410470955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e5ace37d83af459bd491847df570b6763c602344
Gitweb:        https://git.kernel.org/tip/e5ace37d83af459bd491847df570b6763c602344
Author:        Hou Tao <houtao1@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 19:44:24 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:52 -08:00

locktorture: Ignore nreaders_stress if no readlock support

Exclusive locks do not have readlock support, which means that a
locktorture run with the following module parameters will do nothing:

 torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1

This commit therefore rejects this combination for exclusive locks by
returning -EINVAL during module init.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 316531d..046ea2d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -870,7 +870,8 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (nwriters_stress == 0 && nreaders_stress == 0) {
+	if (nwriters_stress == 0 &&
+	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
 		pr_alert("lock-torture: must run at least one locking thread\n");
 		firsterr = -EINVAL;
 		goto unwind;
