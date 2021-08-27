Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2403FA1F0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 01:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhH0Xyc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Aug 2021 19:54:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhH0Xyb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Aug 2021 19:54:31 -0400
Date:   Fri, 27 Aug 2021 23:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630108421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ujici2zlndoGTKRvetFhU/l42w0eHXw597AjTNN4D10=;
        b=sDWP9TLFlXoUFB6hJuFK/TaC8R8T0RVFn/uQTYWR3UZNohVfaL92z1syg0kQUTe0NpiaK6
        cs/502uM4Y8QfvXsHA/fGUupChHk140RM/VoIaT2GcL9BeBhEbt+d0llTKm2jW49vZD/jd
        huQWybAF3HWg3mNh8Y5hBLK3B7yGZC/NurmAqe2ncslGmcws9CZDVrfjQNdUOTIHz1JNcH
        YxuVN7ZsQUmoV7y4I+KLQ0WrwbpHfVafo+4KlVnNh84/zqtSziXREZ2OiWc6s4CNxSM8Wz
        KPnUk6CTtWCnq7vz1eTSDF3MqZjUYe+Hm99x9TOhacUK0odUFEXcaMrHEC9h6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630108421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ujici2zlndoGTKRvetFhU/l42w0eHXw597AjTNN4D10=;
        b=92c/Nqlvl0+rT9WTHS6MFtMr0IFuyNAWaMXHV/O/Pj5TGnZhFdoW3UmsvVaMnehbN+lfiv
        Jfwnbu+XbPh5XfDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] Documentation: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-2-bigeasy@linutronix.de>
References: <20210803141621.780504-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163010842031.25758.4638656274157973111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c7483d823ee0da31e42d32e51a752f667a059735
Gitweb:        https://git.kernel.org/tip/c7483d823ee0da31e42d32e51a752f667a059735
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Aug 2021 01:46:17 +02:00

Documentation: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Update the documentation accordingly.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-2-bigeasy@linutronix.de

---
 Documentation/core-api/cpu_hotplug.rst | 2 +-
 Documentation/trace/ftrace.rst         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index a2c96be..1122cd3 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -220,7 +220,7 @@ goes online (offline) and during initial setup (shutdown) of the driver. However
 each registration and removal function is also available with a ``_nocalls``
 suffix which does not invoke the provided callbacks if the invocation of the
 callbacks is not desired. During the manual setup (or teardown) the functions
-``get_online_cpus()`` and ``put_online_cpus()`` should be used to inhibit CPU
+``cpus_read_lock()`` and ``cpus_read_unlock()`` should be used to inhibit CPU
 hotplug operations.
 
 
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index cfc81e9..4e5b26f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2762,7 +2762,7 @@ listed in:
   put_prev_task_idle
   kmem_cache_create
   pick_next_task_rt
-  get_online_cpus
+  cpus_read_lock
   pick_next_task_fair
   mutex_lock
   [...]
