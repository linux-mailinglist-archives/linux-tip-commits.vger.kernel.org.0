Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0327903E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIYS0f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 14:26:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYS0f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 14:26:35 -0400
Date:   Fri, 25 Sep 2020 18:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601058392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd9MKJMjiZ4BRJCGXiQBp/qZgmy5aeDgwR8dOx414sM=;
        b=w9YkclN34Bo53KyvjGPooM626AOAHRpa3Vf1r1xUvWVFLhL9ayuU1vaRccotXSLAUL620a
        cNiIcCPPMn5FH9VGAE5hmeDXn7936TxgOkHxA/7V4VV34WyHBAcNCGa2pTh7SWzb7bZypk
        F41Dbqcr0cpUW3TgS5fleT5VJytC40FGrzGftN+44rSuULwKQbPExHBp57zC0gvJDmzARf
        kP6gnpDpVmcUccxM2lccNlDTtuEtAErTfwyNTLd0Euyl7B0oRfWca1Hewa9iAuP8IIYRNh
        ucdEklvkq09Ehbv43APY8P4Yza2RwDnnjlsXm/OACqssKytzcAZnlDVJJIp9Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601058392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd9MKJMjiZ4BRJCGXiQBp/qZgmy5aeDgwR8dOx414sM=;
        b=S8ZZAKUsfttDEyNRL4jb8ae8isc3WiedPFUvG1yw+7sqAZDcV2QjGt8t6SYKCDSMA5B+vj
        nP8bqaqvnLpP2fDA==
From:   "tip-bot2 for Qinglang Miao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE()
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200919012252.171437-1-miaoqinglang@huawei.com>
References: <20200919012252.171437-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Message-ID: <160105839157.7002.12548841557640248021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4bd442e9a8388e8ec4ba7cf23a4774989d93b78e
Gitweb:        https://git.kernel.org/tip/4bd442e9a8388e8ec4ba7cf23a4774989d93b78e
Author:        Qinglang Miao <miaoqinglang@huawei.com>
AuthorDate:    Sat, 19 Sep 2020 09:22:52 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 25 Sep 2020 19:05:31 +02:00

RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE()

Use the DEFINE_SHOW_ATTRIBUTE() macro and simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200919012252.171437-1-miaoqinglang@huawei.com
---
 drivers/ras/cec.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 6939aa5..ddecf25 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -435,7 +435,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%
 
 static const char * const bins[] = { "00", "01", "10", "11" };
 
-static int array_dump(struct seq_file *m, void *v)
+static int array_show(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
 	int i;
@@ -467,18 +467,7 @@ static int array_dump(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int array_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, array_dump, NULL);
-}
-
-static const struct file_operations array_ops = {
-	.owner	 = THIS_MODULE,
-	.open	 = array_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
@@ -513,7 +502,7 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
+	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_fops);
 	if (!array) {
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
