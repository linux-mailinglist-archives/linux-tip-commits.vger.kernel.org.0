Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B83EAFB3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2019 12:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfJaL6M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Oct 2019 07:58:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55281 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfJaLzG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92V-0002qc-O5; Thu, 31 Oct 2019 12:54:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5E6251C0070;
        Thu, 31 Oct 2019 12:54:55 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:55 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] drivers/scsi: Replace rcu_swap_protected() with
 rcu_replace_pointer()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157252289509.29376.651547979200552176.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c0eaf15cd5d39e79feb81a122975df0bb5a1c106
Gitweb:        https://git.kernel.org/tip/c0eaf15cd5d39e79feb81a122975df0bb5a1c106
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 23 Sep 2019 15:26:28 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:44:17 -07:00

drivers/scsi: Replace rcu_swap_protected() with rcu_replace_pointer()

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace_pointer() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
[ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: <linux-scsi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/scsi/scsi.c       | 4 ++--
 drivers/scsi/scsi_sysfs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1f5b5c8..7a1b6c7 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -434,8 +434,8 @@ static void scsi_update_vpd_page(struct scsi_device *sdev, u8 page,
 		return;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(*sdev_vpd_buf, vpd_buf,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_buf = rcu_replace_pointer(*sdev_vpd_buf, vpd_buf,
+				      lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_buf)
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 64c96c7..5adfcab 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -466,10 +466,10 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	sdev->request_queue = NULL;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(sdev->vpd_pg80, vpd_pg80,
-			   lockdep_is_held(&sdev->inquiry_mutex));
-	rcu_swap_protected(sdev->vpd_pg83, vpd_pg83,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg80 = rcu_replace_pointer(sdev->vpd_pg80, vpd_pg80,
+				       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg83 = rcu_replace_pointer(sdev->vpd_pg83, vpd_pg83,
+				       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg83)
