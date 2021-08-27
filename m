Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB273FA1F2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 01:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhH0Xyd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Aug 2021 19:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhH0Xyc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Aug 2021 19:54:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FDC0613D9;
        Fri, 27 Aug 2021 16:53:42 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:53:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630108420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRhNbnt3DAm6tPBt6h9ZXvnjc2L9dbwx7zWa+qhmDW4=;
        b=h5gOUbJcreKy+lAcS+ZLFzs2jN8hiBVzZiiQ2eIFqk/thsglLDxcaOY2Pntx/xWYp2brLn
        3OxQbQtwdBcOn1cb5ZzQClrQG6RWzBCNHtz3te43p0JtWwhDU7XosqWHrQJAMndxbbPH6t
        FJ98K0SWAboSRxfuz6nhcR/xjk1BmGnN7crRxpHWSMQ6g7dqUHzsE87/a/pIz8eqaKERew
        n9mn3FbyEHLVuXkYh/B8aowNZng1DvVtzHhWGrdGfq/a42ZBflD7Dx5sj9KfIbk+c7vgi2
        MNZrUfu4tFhAHlz4mVaV1B5KAH/ZBVgGq5lJfHIWbDHOWGFeHR+kucA6aFIPLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630108420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRhNbnt3DAm6tPBt6h9ZXvnjc2L9dbwx7zWa+qhmDW4=;
        b=bgEOw7i6iHg+83OOQJzznZ7qCkfAfh2J9qIREiOgMekXgiVQyC6zVIS50kZasQGxAlu4VP
        FhMxsic/z4ZG6ODw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] md/raid5: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <song@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-16-bigeasy@linutronix.de>
References: <20210803141621.780504-16-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163010841968.25758.13055777938918716276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     252034e03f04e54acfb5f5924dd26ae638e3215e
Gitweb:        https://git.kernel.org/tip/252034e03f04e54acfb5f5924dd26ae638e3215e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Aug 2021 01:46:17 +02:00

md/raid5: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20210803141621.780504-16-bigeasy@linutronix.de

---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b8436e4..02ed53b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2437,7 +2437,7 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 	    conf->scribble_sectors >= new_sectors)
 		return 0;
 	mddev_suspend(conf->mddev);
-	get_online_cpus();
+	cpus_read_lock();
 
 	for_each_present_cpu(cpu) {
 		struct raid5_percpu *percpu;
@@ -2449,7 +2449,7 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 			break;
 	}
 
-	put_online_cpus();
+	cpus_read_unlock();
 	mddev_resume(conf->mddev);
 	if (!err) {
 		conf->scribble_disks = new_disks;
