Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39533231DF7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jul 2020 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgG2MCi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jul 2020 08:02:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2MCh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jul 2020 08:02:37 -0400
Date:   Wed, 29 Jul 2020 12:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596024155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3fiI8kEzJLzx7f9GhNpHCCPryXYwTat7MLMxiPCCdQ=;
        b=YluZYPuBL31TPlM0SFM0AHBTwI26HjSDAmmNHIYtQNnT6vcNPKte5Z5imDu2Cfmt8HADgv
        UA6aTWa57FI/nYznXnJzKs3dfFLemigoA+DZLgqZ1Faf9VNc2Rd9phYaoRB3IS5jHl8t0p
        Fj9kobpHoNuGdB0qF0ru2Ws7qrJmKT4/XR7sj+HVShJbJSQbhML5sJJGtXus9vdEiEIR7B
        HvCDUQjWXZUnV8ghXIRp4LYdJPYW/Ka4Zm5+PuoBgbnPBTAd7YALdb+AbYK0J4BSF3ibph
        OBDlUw22QpGjFE8pZ5RE8yjXElfzpeZOnNyKMJvLd9ptMCmHuGDlLkVbr/gQ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596024155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3fiI8kEzJLzx7f9GhNpHCCPryXYwTat7MLMxiPCCdQ=;
        b=rZZD2QspO6hG6D6caBRD0nPhqXYiRySg5zkxthbgi70Hj3ujyKOZgeJPoBATfwMtV+IdCJ
        OZO4p7hAlURAU3BA==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] Documentation/sysctl: Document uclamp sysctl knobs
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716110347.19553-3-qais.yousef@arm.com>
References: <20200716110347.19553-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <159602415378.4006.11058141925168356516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1f73d1abe5836bd8ffe747ff5cb7561b17ce5bc6
Gitweb:        https://git.kernel.org/tip/1f73d1abe5836bd8ffe747ff5cb7561b17ce5bc6
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 16 Jul 2020 12:03:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 13:51:48 +02:00

Documentation/sysctl: Document uclamp sysctl knobs

Uclamp exposes 3 sysctl knobs:

	* sched_util_clamp_min
	* sched_util_clamp_max
	* sched_util_clamp_min_rt_default

Document them in sysctl/kernel.rst.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200716110347.19553-3-qais.yousef@arm.com
---
 Documentation/admin-guide/sysctl/kernel.rst | 54 ++++++++++++++++++++-
 1 file changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 83acf50..55bf6b4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1062,6 +1062,60 @@ Enables/disables scheduler statistics. Enabling this feature
 incurs a small amount of overhead in the scheduler but is
 useful for debugging and performance tuning.
 
+sched_util_clamp_min:
+=====================
+
+Max allowed *minimum* utilization.
+
+Default value is 1024, which is the maximum possible value.
+
+It means that any requested uclamp.min value cannot be greater than
+sched_util_clamp_min, i.e., it is restricted to the range
+[0:sched_util_clamp_min].
+
+sched_util_clamp_max:
+=====================
+
+Max allowed *maximum* utilization.
+
+Default value is 1024, which is the maximum possible value.
+
+It means that any requested uclamp.max value cannot be greater than
+sched_util_clamp_max, i.e., it is restricted to the range
+[0:sched_util_clamp_max].
+
+sched_util_clamp_min_rt_default:
+================================
+
+By default Linux is tuned for performance. Which means that RT tasks always run
+at the highest frequency and most capable (highest capacity) CPU (in
+heterogeneous systems).
+
+Uclamp achieves this by setting the requested uclamp.min of all RT tasks to
+1024 by default, which effectively boosts the tasks to run at the highest
+frequency and biases them to run on the biggest CPU.
+
+This knob allows admins to change the default behavior when uclamp is being
+used. In battery powered devices particularly, running at the maximum
+capacity and frequency will increase energy consumption and shorten the battery
+life.
+
+This knob is only effective for RT tasks which the user hasn't modified their
+requested uclamp.min value via sched_setattr() syscall.
+
+This knob will not escape the range constraint imposed by sched_util_clamp_min
+defined above.
+
+For example if
+
+	sched_util_clamp_min_rt_default = 800
+	sched_util_clamp_min = 600
+
+Then the boost will be clamped to 600 because 800 is outside of the permissible
+range of [0:600]. This could happen for instance if a powersave mode will
+restrict all boosts temporarily by modifying sched_util_clamp_min. As soon as
+this restriction is lifted, the requested sched_util_clamp_min_rt_default
+will take effect.
 
 seccomp
 =======
