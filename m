Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574A53B077C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVOhe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 10:37:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVOhd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 10:37:33 -0400
Date:   Tue, 22 Jun 2021 14:35:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624372517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEO/XqhA3bJBZQnTpM4woRDvvOEN5K6LbPEYoYQF/P4=;
        b=y6ECdLFKE7MKUsF4cPldYVCu7oyuGqvDvF/V3Z+VLqIup9y0Ze0VvUjB1qISap4Si7rSkl
        3FxYNV7PjHM3YHfbhkUZS5kpU+/0YPWUdT34Zj+exjfmIVf0SxinhreFQZgsDr2Oc9A5xv
        TvZ+LEi6qU3GlfE4e7eaeh4QnRdd4rj6xHF4OpgFMZeR9GvMwsEomNAt3qXVQW5rYms36I
        kgAmceQsKxPG4RwQYqZmzL0eqV8aGsrzUx8Ac4zdoaw5+rpbkYn8AmZ2bYrB5QpUZoqIN0
        FYiJcjffa8ipGeNk6K2UYV3a5f/TUCLOm7ymV5/e1j5WCNLIEBjGx+4ORCjOCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624372517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEO/XqhA3bJBZQnTpM4woRDvvOEN5K6LbPEYoYQF/P4=;
        b=5FF92xN051tn3OgR/vEWdyFvRlT0VxOmZr2e13+tmm663l8S+Z89E8FnCkK8WlDQh1dzTk
        Xe+KNnLo/U83bKDw==
From:   "tip-bot2 for Baokun Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Add missing parameter documentation
Cc:     Baokun Li <libaokun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210608024305.2750999-1-libaokun1@huawei.com>
References: <20210608024305.2750999-1-libaokun1@huawei.com>
MIME-Version: 1.0
Message-ID: <162437251630.395.14333436881714840214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     64ab7071254c178e81a6d0203354aad6521258ea
Gitweb:        https://git.kernel.org/tip/64ab7071254c178e81a6d0203354aad6521258ea
Author:        Baokun Li <libaokun1@huawei.com>
AuthorDate:    Tue, 08 Jun 2021 10:43:05 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 16:33:16 +02:00

clockevents: Add missing parameter documentation

Add the missing documentation for the @cpu parameter of
tick_cleanup_dead_cpu().

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210608024305.2750999-1-libaokun1@huawei.com

---
 kernel/time/clockevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0056d2b..bb9d2fe 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -629,6 +629,7 @@ void tick_offline_cpu(unsigned int cpu)
 
 /**
  * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
+ * @cpu:	The dead CPU
  */
 void tick_cleanup_dead_cpu(int cpu)
 {
