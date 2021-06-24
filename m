Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1873B2A4B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhFXI2k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhFXI2h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 04:28:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD5C061756;
        Thu, 24 Jun 2021 01:26:18 -0700 (PDT)
Date:   Thu, 24 Jun 2021 08:26:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624523175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/DlKiyMx9S/FygcFbg2Yj/n7fxWGQTCdIx0H+jZnh8=;
        b=k5dvL/MSdN8CYCL0xYaf9W2MjllCvVY3oRQ7BcC0WbETG69b6OYQYN5Igk4bE1f2+PBFPI
        KRwSL7rJtdg14LTzP1lF7Bw429eVthcguqr8rGMYi9tSkydH4jW75lxR3GSVSml7ifty1d
        k3vKL2KHar8Cot151O82+RYeyTmwN4gVk3bKL9aKsJQ0XruccFxTa9rTWGJj3kR8bdl+e+
        M60fHR6dZ4R5LsE5bOhN316X7btPQSOryU+VVFguoIVDIL/MuTxJAVDVfy9xf8fgVo2JJ2
        S/FtNsNfUqcEiMEORwnblazugRczk4bcXJC6TXra/2xQr+PMUNHgeEjYOHeBKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624523175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/DlKiyMx9S/FygcFbg2Yj/n7fxWGQTCdIx0H+jZnh8=;
        b=B1EQJRgGiJMDVOtgHilTOiIX0WK+Gc187hFuRRZvCOHmXprJb5Je188Wc7smtD3+Su2/JK
        wFw/uc8+BRYoO9Aw==
From:   "tip-bot2 for Fabio M. De Francesco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix kernel-doc in pseudo_lock.c
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210616181530.4094-1-fmdefrancesco@gmail.com>
References: <20210616181530.4094-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Message-ID: <162452317495.395.16784005187722946009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f9b871c89ae61d5a4c0b81659fa6819c50d4ced2
Gitweb:        https://git.kernel.org/tip/f9b871c89ae61d5a4c0b81659fa6819c50d4ced2
Author:        Fabio M. De Francesco <fmdefrancesco@gmail.com>
AuthorDate:    Wed, 16 Jun 2021 20:15:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Jun 2021 10:21:05 +02:00

x86/resctrl: Fix kernel-doc in pseudo_lock.c

Add undocumented parameters detected by scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20210616181530.4094-1-fmdefrancesco@gmail.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 05a89e3..2207916 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -49,6 +49,7 @@ static struct class *pseudo_lock_class;
 
 /**
  * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ * @void: It takes no parameters.
  *
  * Capture the list of platforms that have been validated to support
  * pseudo-locking. This includes testing to ensure pseudo-locked regions
@@ -162,7 +163,7 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 }
 
 /**
- * pseudo_lock_pm_req - A power management QoS request list entry
+ * struct pseudo_lock_pm_req - A power management QoS request list entry
  * @list:	Entry within the @pm_reqs list for a pseudo-locked region
  * @req:	PM QoS request
  */
@@ -184,6 +185,7 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 
 /**
  * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ * @plr: Pseudo-locked region
  *
  * To prevent the cache from being affected by power management entering
  * C6 has to be avoided. This is accomplished by requesting a latency
@@ -196,6 +198,8 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
  * the ACPI latencies need to be considered while keeping in mind that C2
  * may be set to map to deeper sleep states. In this case the latency
  * requirement needs to prevent entering C2 also.
+ *
+ * Return: 0 on success, <0 on failure
  */
 static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 {
@@ -520,7 +524,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 
 /**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
- * @r: resource group being queried
+ * @rdtgrp: resource group being queried
  *
  * Return: 1 if monitor groups have been created for this resource
  * group, 0 otherwise.
@@ -1140,6 +1144,8 @@ out:
 
 /**
  * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
+ * @rdtgrp: Resource group to which the pseudo-locked region belongs.
+ * @sel: Selector of which measurement to perform on a pseudo-locked region.
  *
  * The measurement of latency to access a pseudo-locked region should be
  * done from a cpu that is associated with that pseudo-locked region.
