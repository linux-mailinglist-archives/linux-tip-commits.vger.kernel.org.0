Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4D3E5A6A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhHJMwa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbhHJMw3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DDC0613D3;
        Tue, 10 Aug 2021 05:52:05 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:52:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628599921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Rxl+VsuGekwJvwLtVa39N0vlt84EiS5G5HKk/2GdQk=;
        b=tFVzW5QRObuk3L27QDQnJVVG7C73XgZWygxSibSL0rFEsHX9nowSRQyDhPK4JHIdGl3SuP
        wmkh03AHKHQWZKQc0hvTOo+mU8Zm5tEa1KCEPueuTAbDAb0hLe/km4omW73rnprbrdVBB9
        JLrK3T61xH/qoGkRl4BtI6A2t+Er/lay4DQ7ZLvrf4nDdlq1jc5zZmP7BRErjY0EwOfgjG
        QGw9Zr2hguWs+IKgQZrpI0iWKgWojNjN6rn7onUjbaY9Tb6wjUgykaCK/87Y5ogl6FgwnZ
        eBdOxulhzSmn1elrN3Unbresnc7Sxt4a4ZlKI5xgG5vRgi+AGVsXOkxGqmsa4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628599921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Rxl+VsuGekwJvwLtVa39N0vlt84EiS5G5HKk/2GdQk=;
        b=rrkdgBzpJ0HExaVxp/REXbob68fJzlEyHM39E/sTCDz7RrdlOuBFL0ddcfOZ8LFE+xZyKV
        zkxiU2SsBrMKuqAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/microcode: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-9-bigeasy@linutronix.de>
References: <20210803141621.780504-9-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162859992105.395.17673744654736339766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2089f34f8c5b91f7235023ec72e71e3247261ecc
Gitweb:        https://git.kernel.org/tip/2089f34f8c5b91f7235023ec72e71e3247261ecc
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:46:27 +02:00

x86/microcode: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-9-bigeasy@linutronix.de

---
 arch/x86/kernel/cpu/microcode/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6a6318e..efb69be 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -55,7 +55,7 @@ LIST_HEAD(microcode_cache);
  * All non cpu-hotplug-callback call sites use:
  *
  * - microcode_mutex to synchronize with each other;
- * - get/put_online_cpus() to synchronize with
+ * - cpus_read_lock/unlock() to synchronize with
  *   the cpu-hotplug-callback call sites.
  *
  * We guarantee that only a single cpu is being
@@ -431,7 +431,7 @@ static ssize_t microcode_write(struct file *file, const char __user *buf,
 		return ret;
 	}
 
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
 
 	if (do_microcode_update(buf, len) == 0)
@@ -441,7 +441,7 @@ static ssize_t microcode_write(struct file *file, const char __user *buf,
 		perf_check_microcode();
 
 	mutex_unlock(&microcode_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -629,7 +629,7 @@ static ssize_t reload_store(struct device *dev,
 	if (val != 1)
 		return size;
 
-	get_online_cpus();
+	cpus_read_lock();
 
 	ret = check_online_cpus();
 	if (ret)
@@ -644,7 +644,7 @@ static ssize_t reload_store(struct device *dev,
 	mutex_unlock(&microcode_mutex);
 
 put:
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (ret == 0)
 		ret = size;
@@ -853,14 +853,14 @@ static int __init microcode_init(void)
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
 
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
 
 	error = subsys_interface_register(&mc_cpu_interface);
 	if (!error)
 		perf_check_microcode();
 	mutex_unlock(&microcode_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (error)
 		goto out_pdev;
@@ -892,13 +892,13 @@ static int __init microcode_init(void)
 			   &cpu_root_microcode_group);
 
  out_driver:
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
 
 	subsys_interface_unregister(&mc_cpu_interface);
 
 	mutex_unlock(&microcode_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 
  out_pdev:
 	platform_device_unregister(microcode_pdev);
