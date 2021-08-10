Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A459F3E5A69
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbhHJMw0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:52:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhHJMwZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:25 -0400
Date:   Tue, 10 Aug 2021 12:52:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628599922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ekcc/ZwUVRvQ8FzJXJCuaiO/RfFX3ZEu6ubLcv4NSKk=;
        b=uNBjxaURk/sJh1cNtVh9c8G/tF80EJTy2UTmP5CZDzom033ZPGMCbLP8WvUbjRF8DiSIA9
        U3cqAQqKikKAb/gS5RK8oqPp388TOJo4I7Kn9Fsvw1ZFQD+uUZkuSsAi9VeetYDjg+wXDx
        wd5WWxFML/gNZsoJ9NoSTjcQB7Mt/EPszGZzIyI5MTXI7BgVI43IDOT2zRIHdeo5JsnuI1
        anRbQV0r5DU1YVMRbwPSBJ8+xxLA9AkagvskFBksZiwZTPuzbePd+BUOJAT/QnO3QLGAWm
        EzOlD6378SIDRltK3XGQeTdqjA3DL3odls2xOc6wL5b41ZQ9I2CaJPYkH/b0rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628599922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ekcc/ZwUVRvQ8FzJXJCuaiO/RfFX3ZEu6ubLcv4NSKk=;
        b=2i3rFW64nLsGaxW2pl4XDBZ9diLkFVp3DJrnQAuSfwIGbxQi3jQc+FMaQ9CdfdupIhPmGv
        Z6BZllFn6QMUdDDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mtrr: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-8-bigeasy@linutronix.de>
References: <20210803141621.780504-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162859992162.395.6019915739574272273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1a351eefd4acc97145903b1c07e4d8b626854b82
Gitweb:        https://git.kernel.org/tip/1a351eefd4acc97145903b1c07e4d8b626854b82
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:46:27 +02:00

x86/mtrr: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-8-bigeasy@linutronix.de

---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index a76694b..2746cac 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -336,7 +336,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	replace = -1;
 
 	/* No CPU hotplug when we change MTRR entries */
-	get_online_cpus();
+	cpus_read_lock();
 
 	/* Search for existing MTRR  */
 	mutex_lock(&mtrr_mutex);
@@ -398,7 +398,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	error = i;
  out:
 	mutex_unlock(&mtrr_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return error;
 }
 
@@ -485,7 +485,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 
 	max = num_var_ranges;
 	/* No CPU hotplug when we change MTRR entries */
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&mtrr_mutex);
 	if (reg < 0) {
 		/*  Search for existing MTRR  */
@@ -520,7 +520,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 	error = reg;
  out:
 	mutex_unlock(&mtrr_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return error;
 }
 
