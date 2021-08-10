Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58113E5AA8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhHJNFK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 09:05:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbhHJNFJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 09:05:09 -0400
Date:   Tue, 10 Aug 2021 13:04:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628600685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpS7rLHiJW9ZgDds10K0Lwh5W/14sKn9OfhMZ6BmEzQ=;
        b=DNTE+8mGuGqNpz/oJSET/ruBaR+2XNuUevI7huBI/53O6aOC8gbpDGYHrQLHUw7xKKVenJ
        0WQOwLPv9ayfM07MRm/8E2Qoflca/cBpJJwABRGytWVVI/p5j218dd33jZ9sXHMiuXiN7l
        Pmsyl+cmzgY35VuLGfvGg8aBpw/lV/EmmXrXKWG/cRbNo1cA8zdE0CziLO9C9bOW9b5VIw
        uazO+nrS3ibTq8Abqu1kz+r4mk2sFq25xvfspeKZ6HDRN9z0lweZIjlzcW7doKPcGdyyvF
        kMYBp4HeCoVbPGM6skwC4BlQ9w+laIwjNIE5X/ufoQP2yS5HiIILcH2dlBnOcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628600685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpS7rLHiJW9ZgDds10K0Lwh5W/14sKn9OfhMZ6BmEzQ=;
        b=JVLFuooB8iBV1RKIXlf2ljI8LF7PZDXwqmxnAhBdza9OkgERqVT3wEOfxPuEYYNLd8Y0np
        iGbvfkDhT+OvgAAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smpboot: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-34-bigeasy@linutronix.de>
References: <20210803141621.780504-34-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162860068498.395.18082735088526071078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     844d87871b6e0ac3ceb177535dcdf6e6a9f1fd4b
Gitweb:        https://git.kernel.org/tip/844d87871b6e0ac3ceb177535dcdf6e6a9f1fd4b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:57:42 +02:00

smpboot: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-34-bigeasy@linutronix.de

---
 kernel/smpboot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index cf6acab..f6bc0bc 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -291,7 +291,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
 	unsigned int cpu;
 	int ret = 0;
 
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smpboot_threads_lock);
 	for_each_online_cpu(cpu) {
 		ret = __smpboot_create_thread(plug_thread, cpu);
@@ -304,7 +304,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
 	list_add(&plug_thread->list, &hotplug_threads);
 out:
 	mutex_unlock(&smpboot_threads_lock);
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
@@ -317,12 +317,12 @@ EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
  */
 void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smpboot_threads_lock);
 	list_del(&plug_thread->list);
 	smpboot_destroy_threads(plug_thread);
 	mutex_unlock(&smpboot_threads_lock);
-	put_online_cpus();
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
 
