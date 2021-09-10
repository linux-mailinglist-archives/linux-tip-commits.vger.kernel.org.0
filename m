Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD640737B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Sep 2021 00:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhIJWq2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 18:46:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhIJWq1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 18:46:27 -0400
Date:   Fri, 10 Sep 2021 22:45:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631313914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XY59VXYolSV0S9iwLnVywnc5P8orSXzToQx88qpUIio=;
        b=zz4KtExef62sWIUAocnQUE1EhY6nLxssNzcdP8M3fe0fR9wSNeX/RBTaFgmdIoW2hhHPP0
        VMatbYaxCYD92SKi5bdQAAuYHdYueRYWGz1EeHvWj4DYk5GIYxA14w6zOQ44O1iX3bn4+C
        jh6uqlBmU7pG+2tjdyRFl3JlVj1QaWzJHEvXA+MNMKtmvzOFtfw4QBEh6V8V1ImYQLIfhx
        GTcXyWCihzxkgofZPwvSij3cP2v6rpeEF2HteIe4gVjlwBm0UWtz0Jn1jQqB03EhauzWBj
        n/dzkTvSF5iOQhqZCwD6tS4gNpc4ZIT2ChT++oGzzqkwsZVcMFYMcVrG5OCQ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631313914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XY59VXYolSV0S9iwLnVywnc5P8orSXzToQx88qpUIio=;
        b=SQWyCGEFcreEDudAKzyxLI+q7VyMdQu678at5fOQ2nPF8OSTD/+6CDvmMjvPEaxx+R78F5
        jmcYWXn4TI3T3wCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] thermal: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-20-bigeasy@linutronix.de>
References: <20210803141621.780504-20-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163131391331.25758.7108415411921343282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     c122358ea1e510d3def876abb7872f1b2b7365c9
Gitweb:        https://git.kernel.org/tip/c122358ea1e510d3def876abb7872f1b2b7365c9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Sep 2021 00:41:21 +02:00

thermal: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-20-bigeasy@linutronix.de

---
 drivers/thermal/intel/intel_powerclamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index b0eb5ec..a5b58ea 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -528,7 +528,7 @@ static int start_power_clamp(void)
 
 	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
 	/* prevent cpu hotplug */
-	get_online_cpus();
+	cpus_read_lock();
 
 	/* prefer BSP */
 	control_cpu = 0;
@@ -542,7 +542,7 @@ static int start_power_clamp(void)
 	for_each_online_cpu(cpu) {
 		start_power_clamp_worker(cpu);
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return 0;
 }
