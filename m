Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF93451DA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 22:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCVVfg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCVVfX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 17:35:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA398C061574;
        Mon, 22 Mar 2021 14:35:22 -0700 (PDT)
Date:   Mon, 22 Mar 2021 21:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616448921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLyXDA8SOPNRw51io+H6qYj4T+mXFdPk/unTF0alwA4=;
        b=fEazB+Ev4ASsZSKJycHL3v9EX7UyWzMZDvXB/udizN4Tg5hinpc/4FWe1JICr7ZJOExe6s
        zindIN2ZYjhfK5ht/1GvL05F+w/HW7X+tPcuQ9pAEq/gnf3cSpMuAyVLuiYEeUHabyAc/C
        kHEj77poVN2+3xszy101hASKtaMgDl2hCP94ks7eLqJs3xUEjW+SZ44XAQZ8f7m8Angies
        Ori/Y+s8R2+K8GAZxfaYwyP8a8tIyAFz6sWRBTOkExX2423CCn97iAt1n+MC0bJ/Z8CfYp
        YTAzWLn2Te2PNvLjrt7GPmnFOt9toFyEaNUlZnexAFBJYnba+1oKgilubzHreg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616448921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLyXDA8SOPNRw51io+H6qYj4T+mXFdPk/unTF0alwA4=;
        b=ETA8wqVvWdO2R/0UxA7J/xqAZA8EFE5GhZdF4d3S5ByGje6PhzlaHdtLkBfdGFy/sfYLFz
        HJD16oCtyQ600vBg==
From:   "tip-bot2 for Otavio Pontes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Check for offline CPUs before
 requesting new microcode
Cc:     Otavio Pontes <otavio.pontes@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210319165515.9240-2-otavio.pontes@intel.com>
References: <20210319165515.9240-2-otavio.pontes@intel.com>
MIME-Version: 1.0
Message-ID: <161644892049.398.15933027756160547817.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7189b3c11903667808029ec9766a6e96de5012a5
Gitweb:        https://git.kernel.org/tip/7189b3c11903667808029ec9766a6e96de5012a5
Author:        Otavio Pontes <otavio.pontes@intel.com>
AuthorDate:    Fri, 19 Mar 2021 09:55:15 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 22 Mar 2021 22:29:40 +01:00

x86/microcode: Check for offline CPUs before requesting new microcode

Currently, the late microcode loading mechanism checks whether any CPUs
are offlined, and, in such a case, aborts the load attempt.

However, this must be done before the kernel caches new microcode from
the filesystem. Otherwise, when offlined CPUs are onlined later, those
cores are going to be updated through the CPU hotplug notifier callback
with the new microcode, while CPUs previously onine will continue to run
with the older microcode.

For example:

Turn off one core (2 threads):

  echo 0 > /sys/devices/system/cpu/cpu3/online
  echo 0 > /sys/devices/system/cpu/cpu1/online

Install the ucode fails because a primary SMT thread is offline:

  cp intel-ucode/06-8e-09 /lib/firmware/intel-ucode/
  echo 1 > /sys/devices/system/cpu/microcode/reload
  bash: echo: write error: Invalid argument

Turn the core back on

  echo 1 > /sys/devices/system/cpu/cpu3/online
  echo 1 > /sys/devices/system/cpu/cpu1/online
  cat /proc/cpuinfo |grep microcode
  microcode : 0x30
  microcode : 0xde
  microcode : 0x30
  microcode : 0xde

The rationale for why the update is aborted when at least one primary
thread is offline is because even if that thread is soft-offlined
and idle, it will still have to participate in broadcasted MCE's
synchronization dance or enter SMM, and in both examples it will execute
instructions so it better have the same microcode revision as the other
cores.

 [ bp: Heavily edit and extend commit message with the reasoning behind all
   this. ]

Fixes: 30ec26da9967 ("x86/microcode: Do not upload microcode if CPUs are offline")
Signed-off-by: Otavio Pontes <otavio.pontes@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/20210319165515.9240-2-otavio.pontes@intel.com
---
 arch/x86/kernel/cpu/microcode/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b935e1b..6a6318e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -629,16 +629,16 @@ static ssize_t reload_store(struct device *dev,
 	if (val != 1)
 		return size;
 
-	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
-	if (tmp_ret != UCODE_NEW)
-		return size;
-
 	get_online_cpus();
 
 	ret = check_online_cpus();
 	if (ret)
 		goto put;
 
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	if (tmp_ret != UCODE_NEW)
+		goto put;
+
 	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
